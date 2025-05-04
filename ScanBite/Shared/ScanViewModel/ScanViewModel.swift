//
//  ScanViewModel.swift
//  ScanBite
//
//  Created by Syed Ahmad  on 02/05/2025.
//



import Foundation
import CoreLocation
import SwiftUI
import Vision

class ScanViewModel : ViewModel{
    
    @Published var menuImage = ""
    @Published var menu = Restaurant()
    @Published var meal = Meal()
    @Published var userDetails = UserDefaultManager.shared.get() ?? User()
    @Published var base64image = ""
    @Published var selectedImage = UIImage()
    @Published var nearbyRestaurants : GooglePlacesResponse?
    @Published var location = CLLocation()
//    @Published var selectedImage: UIImage = UIImage(named: "menu") ?? UIImage()
    @Published var scannedMenuText = ""
    @Published var selectedScanOption : ScanOption = .scanFood
}

extension ScanViewModel: NetworkManagerService{
    
    @MainActor func scanMenu(completion: @escaping () -> Void) async {
        
        self.showLoader = true
        
        await self.fetchRestaurant()
        
        let prompt = PromptGenerator.generatePromptFoodMenu(for: userDetails, coordinates: CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude), place: nearbyRestaurants?.results.first, scannedMenuText: self.scannedMenuText)
        let endPoint: OpenAIEndpoints = .scanMenu(prompt: prompt)
        let request = await sendRequest(endpoint: endPoint, responseModel: OpenAIResponse.self)
        self.scannedMenuText = ""
        showLoader = false
        
        switch request {
            
        case .success(let data):

            let parsedResult = OpenAIResponseParser.parse(data: data, responseModel: Restaurant.self)
            
            switch parsedResult {
                
            case .success(let parsedData):
                
                debugPrint(parsedData)
                self.menu = parsedData
                completion()
                
            case .failure:
                
//                showAlert(message: error.customMessage)
                showAlert(message: "Provide a clear food menu image for processing.") //GPT returns failure OCR message
            }
        case .failure(let error):
            
            debugPrint(error.customMessage)
            self.showAlert(message: error.customMessage)
        }

        
    }
    
    @MainActor func scanFood(description: String, completion: @escaping () -> Void) async {

        self.showLoader = true
        
        self.base64image = getBase64String(from: self.selectedImage)
        
        let prompt = PromptGenerator.generatePromptMeal(description: description)
        let endPoint: OpenAIEndpoints = .scanFood(prompt: prompt, image: self.base64image)
        let request = await sendRequest(endpoint: endPoint, responseModel: OpenAIResponse.self)
        
        showLoader = false
        
        switch request {
            
        case .success(let data):

            let parsedResult = OpenAIResponseParser.parse(data: data, responseModel: Meal.self)
            
            switch parsedResult {
                
            case .success(let parsedData):
                
                debugPrint(parsedData)
                self.meal = parsedData
                completion()
                
            case .failure(let error):
                
                showAlert(message: error.customMessage)
            }
        case .failure(let error):
            
            debugPrint(error.customMessage)
            self.showAlert(message: error.customMessage)
        }

        
    }
    
    
    @MainActor func fetchRestaurant() async {
        
        let endPoint: LocationEndPoints = .getNearbyRestaurants(location: "\(location.coordinate.latitude),\(location.coordinate.longitude)")
        
        let request = await sendRequest(endpoint: endPoint, responseModel: GooglePlacesResponse.self)
        
        switch request {
            
        case .success(let data):
            
            self.nearbyRestaurants = data

        case .failure(let error):
            
            debugPrint(error.customMessage)
            
            self.showAlert(message: error.customMessage)
        }
        
        
        

        
    }
    
}


extension ScanViewModel{
    
    func ocr(image: UIImage, completion: @escaping () -> Void) {
        
        if let cgImage = image.cgImage {
        
            let handler = VNImageRequestHandler(cgImage: cgImage)
            
            let recognizeRequest = VNRecognizeTextRequest { (request, error) in
                
                guard let result = request.results as? [VNRecognizedTextObservation] else {
                    return
                }
                
                let stringArray = result.compactMap { result in
                    result.topCandidates(1).first?.string
                }
                
                DispatchQueue.main.async {
                    self.scannedMenuText = stringArray.joined(separator: "\n")
                    completion()
                }
            }
            
            recognizeRequest.recognitionLevel = .accurate
            do {
                
                try handler.perform([recognizeRequest])
                
            } catch {
                
                print(error)
                
            }
            
        }
    }
    
}
