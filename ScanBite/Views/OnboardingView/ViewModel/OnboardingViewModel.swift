//
//  OnboardingViewModel.swift
//  ScanBite
//
//  Created by Syed Ahmad  on 19/04/2025.
//


import Foundation
import Combine
import SwiftData

class OnboardingViewModel: ViewModel {
    
    @Published var userDetails = User()
    @Published var plan = PersonalizedPlanModel()


}
extension OnboardingViewModel: NetworkManagerService{
    
    @MainActor func preparePersonalizedPlan(isBeingEdited: Bool? = nil) async {

        self.showLoader = true
        
        let endPoint: OpenAIEndpoints = .personalizedPlanView(prompt: PromptGenerator.personalizedPlanPrompt(user: self.userDetails))
        let request = await sendRequest(endpoint: endPoint, responseModel: OpenAIResponse.self)
        
        showLoader = false
        
        switch request {
            
        case .success(let data):

            let parsedResult = OpenAIResponseParser.parse(data: data, responseModel: PersonalizedPlanModel.self)
            
            switch parsedResult {
                
            case .success(let parsedData):
                
                debugPrint(parsedData)
                self.plan = parsedData
                self.saveUser() // have a  check here bypassed for now, save user when personalised plan is being ready
                if isBeingEdited ?? false {
                    self.saveUser()
                    self.showAlert(message: "Your personalized plan is updated!")
                }
            case .failure(let error):
                
                showAlert(message: error.customMessage)
            }
        case .failure(let error):
            
            debugPrint(error.customMessage)
            self.showAlert(message: error.customMessage)
        }

        
    }
    
    func saveUser() {
        
        self.userDetails.calories = self.plan.calories
        self.userDetails.carbs = self.plan.carbs
        self.userDetails.fats = self.plan.fat
        self.userDetails.protein = self.plan.protein
        UserDefaultManager.shared.set(user: userDetails)
        
    }
    
    func fetchPlan(){
        
//        self.userDetails = UserDefaultManager.shared.get() ?? User()
        self.plan.calories = self.userDetails.calories
        self.plan.carbs = self.userDetails.carbs
        self.plan.fat = self.userDetails.fats
        self.plan.protein = self.userDetails.protein
        
    }
    
}
