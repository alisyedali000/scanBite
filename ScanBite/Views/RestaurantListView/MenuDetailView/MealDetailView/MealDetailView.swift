//
//  MealDetailView.swift
//  ScanBite
//
//  Created by Syed Ahmad  on 04/05/2025.
//

import SwiftUI

struct MealDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var mealTags = [MealTag]()
    @State var meal : Meal
    @State var portionSize: Double = 100
    @State var previousPortionSize: Double = 100
    
    var body: some View {
        
        screenView
            .padding(.horizontal)
            .onAppear(){
                //                self.user = UserDefaultManager.shared.get() ?? User()
                setMealTags()
            }
        
    }
}

extension MealDetailView{
    
    var screenView : some View{
        
        VStack(alignment: .leading){
            
            BackNavigation(title: "Detail") {
                
                self.presentationMode.wrappedValue.dismiss()
                
            }
            
            ScrollView(showsIndicators: false){
                
                VStack(spacing: 20){
                    
                    headerView
                    
                    macros
                    
                    activeIngredients
                    
                    portionControl
                    
                    nutritionFacts
                }
            }
            
            AppButton(title: "Log Macros") {
                
            }
            
        }
        
    }
    
}

extension MealDetailView{
    
    var headerView: some View{
        
        VStack(alignment: .leading, spacing: 10){
            
            scanStatus
            
            Text(meal.title)
                .font(.semiBold(size: 21))
            
            HStack{
                
                Image(systemName: "flame.fill")
                
                Text(meal.calories ?? "")
                    .font(.medium(size: 12))
                    .foregroundStyle(Color.gray)
            }
            
            macroTagsView
            
        }
        .padding()
        .background(
            
            RoundedRectangle(cornerRadius: 18)
                .fill(Color(hex: "#F5F5F5"))
            
        )
        
    }
    
    var macros: some View {
        
        HStack{
            
            VerticalProgressBar(totalCalories: meal.calories?.extractDouble ?? 0.0, nutrient: .protein, grams: meal.protein?.extractDouble ?? 0.0, width: 109 ,color: Color(hex: "#FFB701"), image: Image(.proteinBarIcon))
            
            Spacer()
            
            VerticalProgressBar(totalCalories: meal.calories?.extractDouble ?? 0.0, nutrient: .fat, grams: meal.fat?.extractDouble ?? 0.0, width: 109 ,color: Color(hex: "#08CD9F"), image: Image(.fatsBarIcon))
            
            Spacer()
            
            VerticalProgressBar(totalCalories: meal.calories?.extractDouble ?? 0.0, nutrient: .carbs, grams: meal.carbs?.extractDouble ?? 0.0, width: 109 ,color: Color(hex: "#8E99F8"), image: Image(.carbsBarIcon))
            
        }
        
    }
    
    var activeIngredients: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            
            if let ingredients = meal.activeIngredients, !ingredients.isEmpty {
                
                let ingredientString = ingredients.joined(separator: ", ")
                
                
                HStack{
                    
                    Text("Active Ingredients")
                        .font(.semiBold(size: 16))
                    
                    Spacer()
                }
                Text(ingredientString)
                    .font(.regular(size: 14))
                    .foregroundColor(.textGray)
                    .transition(.opacity)
                    .multilineTextAlignment(.leading)
                
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color(hex: "#F5F5F5"))
        )
    }
    
    var portionControl: some View {
        
        VStack(alignment: .leading){
            
            HStack{
                Text("Portion Size")
                    .font(.semiBold(size: 16))
                
                Spacer()
                
                Text("\(Int(portionSize))%")
                    .font(.regular(size: 13.86))
            }
            Slider(value: $portionSize, in: 0...100, step: 10)
                .accentColor(.black) // Active track & thumb color
                .frame(height: 30)
                .padding(.horizontal,5)
                .onChange(of: portionSize) { _ , newValue in
                    
                    if newValue == 0 {
                        portionSize = 10 // Reset to minimum
                    } else {
                        adjustMealValues(newValue: newValue)
                    }
                    
                }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color(hex: "#F5F5F5"))
        )
        
    }
    
    
    var nutritionFacts: some View {
        
        VStack(alignment: .leading, spacing: 20){

            Text("Nutrition Facts")
                .font(.semiBold(size: 16))
            
            Divider()
            
            NutritionInfoRow(title: "Total Fat", value: meal.nutrition?.totalFat?.amount ?? "", icon: ImageName.fats)
            
            NutritionInfoRow(title: "Saturated Fat", value: meal.nutrition?.totalFat?.saturatedFat ?? "", icon: ImageName.fats)
            
            NutritionInfoRow(title: "Trans Fat", value: meal.nutrition?.totalFat?.transFat ?? "", icon: ImageName.fats)
            
            NutritionInfoRow(title: "Cholestrol", value: meal.nutrition?.cholesterol ?? "", icon: ImageName.cholestrol)
            
            NutritionInfoRow(title: "Sodium", value: meal.nutrition?.sodium ?? "", icon: ImageName.sodium)
            
            NutritionInfoRow(title: "Total Carbs", value: meal.nutrition?.totalCarbohydrates?.amount ?? "", icon: ImageName.carbs)
            
            NutritionInfoRow(title: "Dietry Fiber", value: meal.nutrition?.totalCarbohydrates?.dietaryFiber ?? "", icon: ImageName.Fibers)
            
            NutritionInfoRow(title: "Total Sugar", value: meal.nutrition?.totalSugar ?? "", icon: ImageName.sugars)
            
            NutritionInfoRow(title: "Protein", value: meal.nutrition?.protein ?? "", icon: ImageName.protein)
            
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color(hex: "#F5F5F5"))
        )
        
        
    }
    
    
}

//MARK: HeaderView

extension MealDetailView{
    
    var scanStatus: some View {
        
        HStack{
            
            Text(meal.isSelected ? "Recommended" : "Not Recommended")
                .font(.medium(size: 11))
                .foregroundStyle(meal.isSelected ? Color(hex: "#0FCA6C") : Color(hex: "#F53333"))
                .padding(10)
                .background(
                    RoundedRectangle(cornerRadius: 60)
                        .fill(Color(hex: "#0FCA6C").opacity(0.04))
                )
        }
        
    }
    
    var macroTagsView: some View {
        
        Group {
            
            ScrollView(.horizontal, showsIndicators: false) {
                
                HStack(spacing: 10) {
                    
                    ForEach(self.mealTags, id:\.self) { tag in
                        
                        MealTagView(mealCategory: tag)
                    }
                }
                .padding(.horizontal, 5)
            }
        }
    }
    
}
extension MealDetailView{
    
    func setMealTags() {
        
        let isKetoUser = UserDefaultManager.shared.get()?.diet.lowercased() == "keto diet" ? true : false
        
        if meal.carbs?.extractInt ?? 0 < 4 && meal.protein?.extractInt ?? 0 > 10 && meal.fat?.extractInt ?? 0 > 1 {
            mealTags.append(.keto)
        }
        
        if meal.fat?.extractInt ?? 0 > 15 && meal.protein?.extractInt ?? 0 > 15 {
            mealTags.append(.highFats)
        }
        
        if meal.protein?.extractInt ?? 0 > 25 {
            mealTags.append(.highProtein)
        }
        
        if isKetoUser && ((meal.carbs?.extractInt ?? 0) > 5) {
            mealTags.append(.notKetoFriendly)
        }
        
    }
    
    func adjustMealValues(newValue: Double) {
        
        let reductionFactor = newValue / previousPortionSize
        
        meal.carbs = updateNutrient(meal.carbs, reductionFactor)
        meal.fat = updateNutrient(meal.fat, reductionFactor)
        meal.protein = updateNutrient(meal.protein, reductionFactor)
        meal.calories = updateNutrient(meal.calories, reductionFactor)
        
        previousPortionSize = newValue
    }
    
    func updateNutrient(_ value: String?, _ factor: Double) -> String? {
        
        guard let value = value, let doubleValue = Double(value.filter("0123456789.".contains)) else { return nil }
        
        let updatedValue = doubleValue * factor
        
        return String(format: "~%.1fg", updatedValue) // Rounds to nearest whole number
    }
    
}
#Preview {
    MealDetailView(
        meal: Meal(
            title: "Tavern Burger",
            calories: "~800 Calories",
            carbs: "~25g",
            fat: "~25g",
            protein: "~22g",
            icon: "burger",
            isSelected: true,
            alternatives: [
                AlternativeItem(title: "Fruit Bowl", details:  "A healthy mix of seasonal fruits.", category: "Breakfast", icon: "🍇"),
                AlternativeItem(title: "Oatmeal", details:  "Warm oatmeal with honey and nuts.", category: "Healthy Grains", icon: "🥣")
            ],
            activeIngredients: ["Bibb lettuce", "8-ounce Angus burger patty"]
        )
    )
}
