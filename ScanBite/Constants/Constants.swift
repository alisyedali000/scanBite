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
