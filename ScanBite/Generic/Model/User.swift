//
//  User.swift
//  ScanBite
//
//  Created by Syed Ahmad  on 19/04/2025.
//


import Foundation
struct User: Codable {
    
    var gender: String
    var age: String
    var birthMonth : String
    var birthDay : String
    var birthYear : String
    var height: String
    var diet: String
    var workout: String
    var goal: String
    var feet: String
    var inches: String
    var weight: String
    var desiredWeight: Int
    var calories: Double
    var carbs: Double
    var fats: Double
    var protein: Double
    
    
    var loggedCaloris: Double
    var loggedProtein: Double
    var loggedFats: Double
    var loggedCarbs: Double
    
//    var loggedMeals : [Meal] //recently logged meal
    enum CodingKeys: String, CodingKey{
        
        case gender, age, birthYear, birthMonth, birthDay, height, diet, workout, goal, feet, inches, weight, desiredWeight,  calories, carbs, fats, protein, loggedCaloris,
        loggedProtein,
        loggedFats,
        loggedCarbs
//        case loggedMeals
        
    }
    
    init() {
        self.gender = ""
        self.age = ""
        self.birthDay = "22"
        self.birthYear = "1995"
        self.birthMonth = "July"
        self.height = ""
        self.diet = ""
        self.workout = ""
        self.goal = ""
        self.feet = "5"
        self.inches = "3"
        self.weight = "120"
        self.desiredWeight = 0
        self.calories = 0
        self.carbs = 0
        self.protein = 0
        self.fats = 0
        self.loggedCaloris = 0
        self.loggedProtein = 0
        self.loggedFats = 0
        self.loggedCarbs = 0
//        self.loggedMeals = [Meal]()
    }

}


struct DailyMacrosData: Codable{
    
    let date : Date
    var data: User
    
    enum CodingKeys: String, CodingKey{
        
        case date, data
        
    }
    
    init(date: Date, data: User) {
        self.date = date
        self.data = data
    }
    
    init(){
        self.date = Date()
        self.data = User()
    }
    
}
