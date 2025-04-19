//
//  PersonalizedPlanModel.swift
//  ScanBite
//
//  Created by Syed Ahmad  on 19/04/2025.
//


import Foundation

struct PersonalizedPlanModel: Codable {
    var calories: Double
    var protein: Double
    var fat: Double
    var carbs: Double
    var maintainWeight: Double
    
    init(calories: Double, protein: Double, fat: Double, carbs: Double, maintainWeight: Double) {
        self.calories = calories
        self.protein = protein
        self.fat = fat
        self.carbs = carbs
        self.maintainWeight = maintainWeight
    }
    
    init(){
        self.calories = 0.0
        self.protein = 0.0
        self.fat = 0.0
        self.carbs = 0.0
        self.maintainWeight = 0.0
    }
    
    enum CodingKeys: String, CodingKey {
        case calories, protein, fat, carbs, maintainWeight
    }
    
}
