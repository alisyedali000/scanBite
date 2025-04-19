//
//  PromptGenerator.swift
//  ScanBite
//
//  Created by Syed Ahmad  on 19/04/2025.
//

import CoreLocation
import Foundation

class PromptGenerator {
    
    static func generatePromptFoodMenu(for user: User, coordinates: CLLocationCoordinate2D, place: Place?, scannedMenuText: String) -> String {
        return """
        You are a highly advanced nutritional assistant specializing in food analysis. Your task is to analyze the attached scanned food menu which is in the textual form in the end, extract **all available meal details**, and provide nutritional recommendations based on the user’s dietary profile and fitness goals.
        
        ### 🧑‍💻 User Profile & Goals
        
        - **Gender**: \(user.gender)
        - **Height**: \(user.feet) feet \(user.inches) inches
        - **Weight**: \(user.weight) lbs
        - **Dietary Preference**: \(user.diet)
        - **Workout Frequency**: \(user.workout) times per week
        - **Goal**: \(user.goal) while maintaining proper nutrition
        
        ---
        
        ### **📌 Key Requirements**
        ✅ **Include all meals from the menu** (do not filter out any meal).
        ✅ **Each meal must have an `"isSelected"` field**:
           - `true` if suitable for the user’s goal and diet.
           - `false` if not suitable.
        ✅ **Every meal must include `"alternatives"`**:
           - If an official alternative is provided by the restaurant, extract it.
           - If no alternative is listed, generate a **nutritionally appropriate recommendation**.
           - Ensure alternatives align with the user’s **dietary preference** and **fitness goal**.
        ✅ **Extract full restaurant details**, including:
           - Name
           - Address
           - Geo-coordinates (latitude, longitude)
        ✅ **Provide a detailed nutritional breakdown** for each meal, including:
           - Calories
           - Macronutrients (carbs, fat, protein)
           - Sodium, cholesterol, fiber, sugars, etc.
        ✅ **Use Unicode-based food icons** (🥗, 🍕, 🍣) for UI representation.
        
        🏪 Restaurant Information Extraction
        
        The restaurant name is \(place?.name ?? "") and address is \(place?.vicinity ?? "")
        Extract the restaurant's name from the menu if not provided.
        
        ✅ Ensure accuracy by extracting the most precise address details from the geo-coordinates when the menu lacks explicit information.
        
        ---
        
        ### **📜 Expected JSON Output Format**
        Ensure every meal from the menu is included in the response, with structured data as follows:
        
        ```json
        {
            "name": "Restaurant Name",
            "address": "Restaurant Address",
            "geoCoordinates": {
                "latitude": \(coordinates.latitude ?? 0.0),
                "longitude": \(coordinates.longitude ?? 0.0)
            },
            "meals": [
                {
                    "title": "Meal Name",
                    "calories": "~350",
                    "carbs": "~45g",
                    "fat": "~10g",
                    "protein": "~18g",
                    "icon": "🍽️",
                    "isSelected": true,
                    "alternatives": [
                        {
                            "title": "Alternative Meal Name",
                            "details": "A healthy substitute with similar taste and better nutritional value.",
                            "category": "Vegan",
                            "icon": "🥗"
                        }
                    ],
                    "activeIngredients": ["Ingredient1", "Ingredient2"],
                    "nutrition": {
                        "total_sugar": "~4.5g",
                        "calories": "~400",
                        "total_fat": {
                            "amount": "~25g",
                            "saturated_fat": "~10g",
                            "trans_fat": "~1g"
                        },
                        "cholesterol": "~75mg",
                        "sodium": "~600mg",
                        "total_carbohydrates": {
                            "amount": "~25g",
                            "dietary_fiber": "~1.5g",
                            "total_sugars": "~4.5g"
                        },
                        "protein": "~22.5g"
                    }
                },
                {
                    "title": "Another Meal",
                    "calories": "~450",
                    "carbs": "~55g",
                    "fat": "~15g",
                    "protein": "~20g",
                    "icon": "🍕",
                    "isSelected": false,
                    "alternatives": [
                        {
                            "title": "Low-Carb Cauliflower Pizza",
                            "details": "A lower-carb alternative made with cauliflower crust, ideal for weight loss.",
                            "category": "Keto-Friendly",
                            "icon": "🍕"
                        }
                    ],
                    "activeIngredients": ["IngredientA", "IngredientB"],
                    "nutrition": {
                        "calories": "~450",
                        "total_fat": {
                            "amount": "~20g",
                            "saturated_fat": "~5g",
                            "trans_fat": "~0g"
                        },
                        "cholesterol": "~50mg",
                        "sodium": "~700mg",
                        "total_carbohydrates": {
                            "amount": "~50g",
                            "dietary_fiber": "~2g",
                            "total_sugars": "~5g"
                        },
                        "protein": "~20g"
                    }
                }
            ]
        }
        
        
        ***This is the scanned food menu data***
        \(scannedMenuText)

        
            🚨 ERROR HANDLING
            
            🔴 If you cannot find any food menu related textual data from the text provided right above then respond in the following format:
            
            {
                "error": true,
                "message": "Provide a clear food menu image for processing."
            }
        
        """
    }


    static func generatePromptMeal(description: String) -> String {
        
        return """
        
        You are a highly advanced nutritional assistant specializing in meal analysis.
        Your task is to analyze the attached Base64-encoded meal image, extract detailed nutritional information, and recommend meals that align with the user’s dietary preferences and fitness goals.

        Here is the descripon of food: \(description)
        
        

        📜 Expected JSON Output Format

        You must return the extracted food details in this structured format, ensuring all key nutritional components are included:
        
            {
                "title": "Meal Name",
                "calories": "~350",
                "carbs": "~45g",
                "fat": "~10g",
                "protein": "~18g",
                "icon": "🍽️",
                "isSelected": true,
                "alternatives": [
                    {
                        "title": "Alternative Meal Name",
                        "details": "A healthy substitute with similar taste and better nutritional value.",
                        "category": "Vegan",
                        "icon": "🥗"
                    }
                ],
                "activeIngredients": ["Ingredient1", "Ingredient2"],
                "nutrition": {
                    "calories": "~400",
                    "total_fat": {
                        "amount": "~25g",
                        "saturated_fat": "~10g",
                        "trans_fat": "~1g"
                    },
                    "cholesterol": "~75mg",
                    "sodium": "~600mg",
                    "total_carbohydrates": {
                        "amount": "~25g",
                        "dietary_fiber": "~1.5g",
                        "total_sugars": "~4.5g"
                    },
                    "protein": "~22.5g"
                }
            
        }
        
        ✅ "title": Name of the meal.
        ✅ "calories", "carbs", "fat", "protein": Macronutrient values with approximations (~).
        ✅ "icon": Unicode icon representing the meal.
        ✅ "isSelected": Indicates whether this meal is recommended by you or not.
        ✅ "alternatives": Suggested alternative meals (if any).
        ✅ "activeIngredients": Key ingredients used in the meal.
        ✅ "nutrition": Detailed breakdown of fat, cholesterol, sodium, carbohydrates, and protein.
        
                
        🚨 ERROR HANDLING
                
        🔴 If there's somethihng wrong , return an error response in the following format:
                
        {
            "error": true,
            "message": "Provide a message here whats wrong "
        }
             
                
        
    
"""
    }
    
    
    static func personalizedPlanPrompt(user: User) -> String {
        let prompt = """
              I am a \(user.gender), \(user.age) years old, \(user.feet) feet \(user.inches) inches tall, weighing \(user.weight) lbs. 
              I follow a \(user.diet) diet and work out \(user.workout) times per week. 
              My goal is to \(user.goal) and to desired weight \(user.desiredWeight) lbs while maintaining proper nutrition. Provide my daily macronutrient needs (carbohydrates, fats, and protein with percentage 0 to 1) in JSON format, ensuring they align with my dietary goals. I don't need any explanation, just a JSON object for use in a Swift app.
              
        
        Output should be a JSON object:
         ```json       
        {
            "calories": estimated daily calorie intake (do not give in percentage),
            "protein":  estimated daily protein intake (do not give in percentage),
            "fat": estimated daily fat intake (do not give in percentage),
            "carbs": estimated daily carbohydrate intake (do not give in percentage),
            "maintainWeight": estimated weight (in lbs) that i should maintain to achieve the desired weight (Double Value)
        }
        ```json
        If a value cannot be determined, set it to 0.
        """
        
        return prompt
    }
}




    
