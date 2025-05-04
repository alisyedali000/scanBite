//
//  RestaurantMdoel.swift
//  ScanBite
//
//  Created by Syed Ahmad  on 01/05/2025.
//

import Foundation
import SwiftData
@Model
class RestaurantEntity: Identifiable, Hashable {
    @Attribute(.unique) var id: UUID
    var menuData: Data // Store encoded Restaurant model as Data
    var createdAt = Date()
    
    init(id: UUID, menu: Restaurant) {
        self.id = id
        self.menuData = try! JSONEncoder().encode(menu) // Convert Restaurant to Data
    }

    // Computed property to decode menu from Data
    var menu: Restaurant {
        get {
            return (try? JSONDecoder().decode(Restaurant.self, from: menuData)) ?? Restaurant()
        }
        set {
            menuData = try! JSONEncoder().encode(newValue)
        }
    }
}
struct Restaurant: Codable, Hashable {
//    @Attribute(.unique) var id: UUID
//    var date = Date()
    var name: String
    var address: String
    var meals: [Meal]?
    var gecoordinates: GeoCoordinates?
    
    init(name: String, address: String, meals: [Meal]? = nil, gecoordinates: GeoCoordinates? = nil) {
        self.name = name
        self.address = address
        self.meals = meals
        self.gecoordinates = gecoordinates
    }
    
    init(){
        
        self.name = ""
        self.address = ""
        self.meals = [Meal]()
        self.gecoordinates = GeoCoordinates()
        
    }
    
    // MARK: - Codable Conformance
    enum CodingKeys: String, CodingKey {
        case name, address, meals, gecoordinates
    }
    
}

// MARK: - GeoCoordinates Model for Codable Support

struct GeoCoordinates: Codable, Hashable {
    var latitude: Double
    var longitude: Double
    


    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    // MARK: - Codable Conformance
    enum CodingKeys: String, CodingKey {
        case latitude, longitude
    }
    
    init(){
        
        self.latitude = 0.0
        self.longitude = 0.0
    }
}

let sampleRestaurant = Restaurant(
    name: "Sample Restaurant",
    address: "Greensboro, NC",
    meals: [
        Meal(
            title: "Cowboy Burger",
            calories: "~850 kcal",
            carbs: "68g",
            fat: "48g",
            protein: "45g",
            icon: "🍔",
            isSelected: true,
            alternatives: [
                AlternativeItem(
                    title: "Grilled Steak",
                    details: "A high-protein alternative with lower carbs.",
                    category: "Carnivore",
                    icon: "🥩"
                )
            ],
            activeIngredients: ["Beef Patty", "Cheese", "Bun"],
            nutrition: FullNutritionInformation(
                calories: "~850",
                totalFat: FatInfo(amount: "~48g", saturatedFat: "~20g", transFat: "~2g"),
                cholesterol: "~120mg",
                sodium: "~900mg",
                totalCarbohydrates: CarbInfo(amount: "~68g", dietaryFiber: "~4g", totalSugars: "~8g"),
                protein: "~45g",
                totalSugar: "~8g"
            )
        ),
        Meal(
            title: "Hawaiian Heatwave Chicken Sandwich",
            calories: "~720 kcal",
            carbs: "62g",
            fat: "30g",
            protein: "52g",
            icon: "🥪",
            isSelected: true,
            alternatives: [
                AlternativeItem(
                    title: "Grilled Chicken Breast",
                    details: "A leaner option with similar protein content.",
                    category: "Carnivore",
                    icon: "🍗"
                )
            ],
            activeIngredients: ["Chicken", "Pineapple", "Bun"],
            nutrition: FullNutritionInformation(
                calories: "~720",
                totalFat: FatInfo(amount: "~30g", saturatedFat: "~10g", transFat: "~1g"),
                cholesterol: "~100mg",
                sodium: "~850mg",
                totalCarbohydrates: CarbInfo(amount: "~62g", dietaryFiber: "~3g", totalSugars: "~10g"),
                protein: "~52g",
                totalSugar: "~10g"
            )
        ),
        Meal(
            title: "The Big Smoke Burger",
            calories: "~1,100 kcal",
            carbs: "75g",
            fat: "65g",
            protein: "65g",
            icon: "🍔",
            isSelected: true,
            alternatives: [
                AlternativeItem(
                    title: "BBQ Ribs",
                    details: "A hearty alternative with rich flavors.",
                    category: "Carnivore",
                    icon: "🍖"
                )
            ],
            activeIngredients: ["Beef Patty", "Bacon", "Cheese"],
            nutrition: FullNutritionInformation(
                calories: "~1,100",
                totalFat: FatInfo(amount: "~65g", saturatedFat: "~25g", transFat: "~3g"),
                cholesterol: "~150mg",
                sodium: "~1,200mg",
                totalCarbohydrates: CarbInfo(amount: "~75g", dietaryFiber: "~5g", totalSugars: "~12g"),
                protein: "~65g",
                totalSugar: "~12g"
            )
        ),
        Meal(
            title: "Spicy Inferno Burger",
            calories: "~890 kcal",
            carbs: "70g",
            fat: "52g",
            protein: "50g",
            icon: "🍔",
            isSelected: true,
            alternatives: [
                AlternativeItem(
                    title: "Spicy Grilled Chicken",
                    details: "A spicy alternative with less fat.",
                    category: "Carnivore",
                    icon: "🌶️"
                )
            ],
            activeIngredients: ["Beef Patty", "Jalapeños", "Cheese"],
            nutrition: FullNutritionInformation(
                calories: "~890",
                totalFat: FatInfo(amount: "~52g", saturatedFat: "~18g", transFat: "~2g"),
                cholesterol: "~130mg",
                sodium: "~950mg",
                totalCarbohydrates: CarbInfo(amount: "~70g", dietaryFiber: "~4g", totalSugars: "~9g"),
                protein: "~50g",
                totalSugar: "~9g"
            )
        ),
        Meal(
            title: "The Green Goddess Veggie Sandwich",
            calories: "~650 kcal",
            carbs: "72g",
            fat: "30g",
            protein: "28g",
            icon: "🥪",
            isSelected: false,
            alternatives: [
                AlternativeItem(
                    title: "Grilled Chicken Salad",
                    details: "A protein-rich alternative with fewer carbs.",
                    category: "Carnivore",
                    icon: "🥗"
                )
            ],
            activeIngredients: ["Veggie Patty", "Avocado", "Bun"],
            nutrition: FullNutritionInformation(
                calories: "~650",
                totalFat: FatInfo(amount: "~30g", saturatedFat: "~8g", transFat: "~0g"),
                cholesterol: "~30mg",
                sodium: "~800mg",
                totalCarbohydrates: CarbInfo(amount: "~72g", dietaryFiber: "~6g", totalSugars: "~7g"),
                protein: "~28g",
                totalSugar: "~7g"
            )
        ),
        Meal(
            title: "Southern Crispy Chicken Melt",
            calories: "~980 kcal",
            carbs: "85g",
            fat: "48g",
            protein: "55g",
            icon: "🍗",
            isSelected: true,
            alternatives: [
                AlternativeItem(
                    title: "Grilled Chicken Melt",
                    details: "A lower-fat alternative with similar taste.",
                    category: "Carnivore",
                    icon: "🍗"
                )
            ],
            activeIngredients: ["Chicken", "Cheese", "Bun"],
            nutrition: FullNutritionInformation(
                calories: "~980",
                totalFat: FatInfo(amount: "~48g", saturatedFat: "~15g", transFat: "~2g"),
                cholesterol: "~60mg",
                sodium: "~1,000mg",
                totalCarbohydrates: CarbInfo(amount: "~85g", dietaryFiber: "~7g", totalSugars: "~10g"),
                protein: "~55g",
                totalSugar: "~10g"
            )
        )
    ]
)
