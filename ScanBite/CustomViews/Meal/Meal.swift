//
//  Meal.swift
//  ScanBite
//
//  Created by Syed Ahmad  on 01/05/2025.
//

import Foundation

struct Meal: Codable, Hashable {
//    @Attribute(.unique) var id: UUID
    var title: String
    var calories: String?
    var carbs: String?
    var fat: String?
    var protein: String?
    var icon: String?
    var isSelected: Bool
    var alternatives: [AlternativeItem]?
    var activeIngredients: [String]?
    var nutrition: FullNutritionInformation?
    var img: Data?
    

    
    // MARK: - Codable Conformance
    enum CodingKeys: String, CodingKey {
        case title, calories, carbs, fat, protein, icon, isSelected, alternatives, activeIngredients, nutrition, img
    }
    
    init(title: String, calories: String? = nil, carbs: String? = nil, fat: String? = nil, protein: String? = nil, icon: String? = nil, isSelected: Bool, alternatives: [AlternativeItem]? = nil, activeIngredients: [String]? = nil, nutrition: FullNutritionInformation? = nil, img: Data? = nil) {
        self.title = title
        self.calories = calories
        self.carbs = carbs
        self.fat = fat
        self.protein = protein
        self.icon = icon
        self.isSelected = isSelected
        self.alternatives = alternatives
        self.activeIngredients = activeIngredients
        self.nutrition = nutrition
        self.img = img
    }
    
    init(){
        
        self.title = ""
        self.calories = ""
        self.carbs = ""
        self.fat = ""
        self.protein = ""
        self.icon = ""
        self.isSelected = false
        self.alternatives = []
        self.activeIngredients = []
        self.nutrition = FullNutritionInformation()
        self.img = Data()
        
    }

}

// MARK: - Alternative Item Model
struct AlternativeItem: Codable, Hashable {
//    @Attribute(.unique) var id: UUID
    var title: String
    var details: String? // Renamed `description` to `details`
    var category: String?
    var icon: String?
    

    
    // MARK: - Codable Conformance
    enum CodingKeys: String, CodingKey {
        case title, details, category, icon // Changed `description` to `details`
    }
    
    init(title: String, details: String? = nil, category: String? = nil, icon: String? = nil) {
        self.title = title
        self.details = details
        self.category = category
        self.icon = icon
    }
    
    init(){
        
        self.title = ""
        self.details = ""
        self.category = ""
        self.icon = ""
    }
    

}

struct FullNutritionInformation: Codable, Hashable {
    var calories: String?
    var totalFat: FatInfo?
    var cholesterol: String?
    var sodium: String?
    var totalCarbohydrates: CarbInfo?
    var protein: String?
    var totalSugar: String?


    init(calories: String? = nil, totalFat: FatInfo? = nil, cholesterol: String? = nil, sodium: String? = nil, totalCarbohydrates: CarbInfo? = nil, protein: String? = nil, totalSugar: String? = nil) {
        self.calories = calories
        self.totalFat = totalFat
        self.cholesterol = cholesterol
        self.sodium = sodium
        self.totalCarbohydrates = totalCarbohydrates
        self.protein = protein
        self.totalSugar = totalSugar
    }
    init(){
        
        self.calories = ""
        self.totalFat = FatInfo()
        self.cholesterol = ""
        self.sodium = ""
        self.totalCarbohydrates = CarbInfo()
        self.protein = ""
        self.totalSugar = ""
    }
    
    enum CodingKeys: String, CodingKey {
        case calories
        case totalFat = "total_fat"
        case cholesterol
        case sodium
        case totalCarbohydrates = "total_carbohydrates"
        case protein
        case totalSugar = "total_sugar"
    }
    

    

}


// MARK: - FatInfo Model
struct FatInfo: Codable, Hashable {
    var amount: String?
    var saturatedFat: String?
    var transFat: String?
    
    init(amount: String? = nil, saturatedFat: String? = nil, transFat: String? = nil) {
        self.amount = amount
        self.saturatedFat = saturatedFat
        self.transFat = transFat
    }

    init(){
        self.amount = ""
        self.saturatedFat = ""
        self.transFat = ""
    }

    enum CodingKeys: String, CodingKey {
        case amount
        case saturatedFat = "saturated_fat"
        case transFat = "trans_fat"
    }

    
}

// MARK: - CarbInfo Model

struct CarbInfo: Codable, Hashable {
    var amount: String?
    var dietaryFiber: String?
    var totalSugars: String?
    

    init(amount: String? = nil, dietaryFiber: String? = nil, totalSugars: String? = nil) {
        self.amount = amount
        self.dietaryFiber = dietaryFiber
        self.totalSugars = totalSugars
    }
    init(){
        self.amount = ""
        self.dietaryFiber = ""
        self.totalSugars = ""
    }
    
    enum CodingKeys: String, CodingKey {
        case amount
        case dietaryFiber = "dietary_fiber"
        case totalSugars = "total_sugars"
    }

    

}
