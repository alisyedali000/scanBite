//
//  Constants.swift
//  ScanBite
//
//  Created by Syed Ahmad  on 14/04/2025.
//
import Foundation
let onboarding1Title = "Scan Any \nRestaurent Menu"
let onboarding2Title = "Effortless Caloreis \nTracking"
let onboarding3Title = "Track Calories & \nMacros"

let onboarding1Description = "Scan any menu, and let AI instantly track calories and macros for you."
let onboarding2Description = "Simply take a photo of your meal, and we’ll handle the rest."
let onboarding3Description = "Get a detailed breakdown of your meals, calories, macros, and more! All in one place."


let genders = ["Male", "Female"]
let months = ["January", "February", "March", "April", "May", "June",
              "July", "August", "September", "October", "November", "December"]
let currentYear = Calendar.current.component(.year, from: Date())
let years = (1900...currentYear - 10)

let feetRange = ["2", "3", "4", "5", "6" , "7", "8", "9"]
let inchesRange = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11"]
 

let diets = [
    (icon: "veganICon", name: "Vegan"),
    (icon: "VegetarianICon", name: "Vegetarian"),
    (icon: "ClassicICon", name: "Classic"),
    (icon: "PescatarianICon", name: "Pescatarian"),
    (icon: "PaleoICon", name: "Paleo"),
    (icon: "KetoDietICon", name: "Keto Diet"),
    (icon: "Whole30ICon", name: "Whole30"),
    (icon: "CarnivoreICon", name: "Carnivore"),
    (icon: "IntermittentFastingICon", name: "Intermittent Fasting")
]

enum Goal: String{
    
    case gain = "Gain Weight"
    case lose = "Lose Weight"
    case maintain = "Maintain Weight"
    case none
    
}


enum NutrientType: String, CaseIterable {
    case calories = "Calories"
    case protein = "Protein"
    case fat = "Fats"
    case carbs = "Carbs"
    
    var icon: String {
        switch self {
        case .calories: return  "caloriesIcon"
        case .carbs: return "caloriesIcon"
        case .protein: return "caloriesIcon"
        case .fat: return  "caloriesIcon"
        }
    }
    
}
enum ScanOption {
    case scanMenu
    case scanFood
}

enum MediaSource {
    case camera
    case cameraWithPhotoLibrary
}
enum MealTag: String {
    case keto = "Keto"
    case highFats = "High Fats"
    case highProtein = "High Protein"
    case notKetoFriendly = "Not Keto Friendly"
}



let googleAPIKey = "AIzaSyCxQ7SxMx8XrrFtb5jS3IHdqCsUpy68UYI"

import SwiftUI
import Foundation
import SwiftUI
import UIKit

func getBase64String(from image: UIImage) -> String {
    let compressedImage = image.resizeAndCompressImage()
    
    let compressedString = compressedImage.base64EncodedString()
    return compressedString
}
extension UIImage {
    
    func resizeAndCompressImage() -> Data {
        guard let reducedImage = self.resizeImage() else {
            debugPrint("Image is not compressed")
            return Data()
        }
        
        guard let compressedImage = reducedImage.compressImage() else {
            debugPrint("image not compressed")
            return Data()
        }
        
        return compressedImage
    }
    
    func resizeImage() -> UIImage? {
        let targetHeight: CGFloat = min(self.size.height, 1200) // Change this value for smaller/bigger images
        let aspectRatio = self.size.width / self.size.height
        let targetWidth = targetHeight * aspectRatio
        
        let newSize = CGSize(width: targetWidth, height: targetHeight)
        
        let renderer = UIGraphicsImageRenderer(size: newSize)
        let resizedImage = renderer.image { context in
            self.draw(in: CGRect(origin: .zero, size: newSize))
        }
        
        return resizedImage
    }
    
    func compressImage() -> Data? {
        let targetSizeInKB = 300 // Change this value for smaller/bigger quality
        var compressionQuality: CGFloat = 1.0
        let maxSizeInBytes = targetSizeInKB * 1024 // Convert KB to bytes

        guard var compressedData = self.jpegData(compressionQuality: compressionQuality) else {
            return nil // Return nil if initial compression fails
        }

        while compressedData.count > maxSizeInBytes && compressionQuality > 0 {
            compressionQuality -= 0.05 // Adjust the compression quality

            guard let newCompressedData = self.jpegData(compressionQuality: compressionQuality) else {
                break // Break the loop if compression fails
            }

            compressedData = newCompressedData
        }

        return compressedData
    }
}
