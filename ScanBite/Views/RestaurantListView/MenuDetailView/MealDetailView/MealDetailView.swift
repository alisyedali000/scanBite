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
        
        VStack{
            
            BackNavigation(title: "Detail") {
                
                self.presentationMode.wrappedValue.dismiss()
                
            }
            
            ScrollView(showsIndicators: false){
                
                VStack(spacing: 20){
                    
                    headerView
                    
                    macros
                    
                    activeIngredients
                }
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
            
            VerticalProgressBar(totalCalories: meal.calories?.extractDouble ?? 0.0, nutrient: .protein, grams: meal.protein?.extractDouble ?? 0.0, width: 109 ,color: Color(hex: "#FFB701"))
            
            Spacer()
            
            VerticalProgressBar(totalCalories: meal.calories?.extractDouble ?? 0.0, nutrient: .fat, grams: meal.fat?.extractDouble ?? 0.0, width: 109 ,color: Color(hex: "#08CD9F"))
            
            Spacer()
            
            VerticalProgressBar(totalCalories: meal.calories?.extractDouble ?? 0.0, nutrient: .carbs, grams: meal.carbs?.extractDouble ?? 0.0, width: 109 ,color: Color(hex: "#8E99F8"))
            
        }
        
    }
    
    var activeIngredients: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            
            if let ingredients = meal.activeIngredients, !ingredients.isEmpty {
                
                let ingredientString = ingredients.joined(separator: ", ")

                    
                    Text("Active Ingredients")
                        .font(.semiBold(size: 16))
                    
                    Text(ingredientString)
                        .font(.regular(size: 14))
                        .foregroundColor(.textGray)
                        .transition(.opacity)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity)
                
            }
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
            activeIngredients: ["Bibb lettuce", "8-ounce Angus burger patty", "Red onion", "Tomato", "American cheese", "Secret sauce"]
        )
    )
}
//
//  MealDetailView.swift
//  MenuAI
//
//  Created by Syed Ahmad  on 26/02/2025.
//
//
//import SwiftUI
//
//struct MealDetailView: View {
//    @Environment(\.presentationMode) var presentationMode
//    @StateObject var vm = ViewModel()
//    @State var meal: Meal // Accepts a Meal object
//    @State var mealTags = [MealTag]()
//    @State var portionSize: Double = 100
//    @State var isFavorite: Bool = false
//    @State var showIngredients: Bool = true
//
//    @State var user = User()
//
//    @State var previousPortionSize: Double = 100
//
//    var body: some View {
//
//        screenView
//            .padding(.horizontal)
//            .onAppear(){
//                self.user = UserDefaultManager.shared.get() ?? User()
//                setMealTags()
//            }
//            .alert("MenuAI", isPresented: $vm.showError) {
//                Button("OK"){
//                    self.presentationMode.wrappedValue.dismiss()
//                }
//            } message: {
//
//                Text(vm.errorMessage)
//            }
//
//
//    }
//}
//
//
//extension MealDetailView{
//
//    var screenView: some View{
//
//        VStack(alignment: .leading){
//            BackNavigation {
//
//                self.presentationMode.wrappedValue.dismiss()
//
//            }
//            ScrollView(showsIndicators: false){
//
//                VStack(alignment: .leading, spacing: 20) {
//
//                    VStack{
//
//                        mealHeaderView
//
//                        calorieAndMacrosView
//
//                    }
//                    macroTagsView
//
//                    ingredientsSection
//
//                    portionControlView
//
////                    macroBreakdownView
//
//                    if meal.nutrition != nil {
//
////                        NutritionInfoView(nutritionInfo: meal.nutrition ?? FullNutritionInformation())
//
//                    }
//
////                    alternativesView
//                }
//
//            }
//            .edgesIgnoringSafeArea(.bottom)
//        }
//    }
//
//}
//// MARK: - Meal Header
//private extension MealDetailView {
//
//    var mealHeaderView: some View {
//
//        HStack {
//
//            Text(meal.title)
//                .font(.bold(size: 28))
//            +
//            Text(meal.icon ?? "🍽️") // Placeholder emoji, can be dynamic
//                .font(.bold(size: 28))
//
//            Spacer()
//
//            logMacrosButton
//        }
//    }
//}
//
//// MARK: - Calories & Macros Button
//private extension MealDetailView {
//
//    var calorieAndMacrosView: some View {
//
//        HStack {
//
//            Text(meal.calories ?? "N/A Calories")
//                .font(.regular(size: 12))
//                .foregroundColor(.textGray)
//
//            Spacer()
//
//
//        }
//    }
//
//    var logMacrosButton: some View{
//
//        Button{
//
//            UserDefaultManager.shared.logMacors(meal: meal)
//            vm.showAlert(message: "Macros Logged!")
//
//        }label:{
//
//            Text("Log Macros")
//                .font(.medium(size: 14))
//                .foregroundColor(.primaryBlue)
//                .padding(.horizontal, 10)
//                .padding(.vertical, 3)
//                .overlay(
//                    RoundedRectangle(cornerRadius: 20)
//                        .stroke(Color.primaryBlue, lineWidth: 1)
//                )
//        }
//
//    }
//
//    var macroTagsView: some View {
//
//        Group {
//            ScrollView(.horizontal, showsIndicators: false) {
//                HStack(spacing: 10) {
//                    ForEach(self.mealTags, id:\.self) { tag in
//                        MealTagView(mealCategory: tag)
//                    }
//                }
//                .padding(.horizontal, 5)
//            }
//        }
//    }
//
//}
//
//
//
//
//// MARK: - Ingredients Section
//private extension MealDetailView {
//
//    var ingredientsSection: some View {
//
//        VStack(alignment: .leading, spacing: 8) {
//
//            HStack {
//
//                Text("Active")
//                    .font(.semiBold(size: 18))
//
//                +
//
//                Text(" Ingredients")
//                    .font(.semiBold(size: 18))
//                    .foregroundColor(.primaryBlue)
//
//                Spacer()
//
//                Button(action: {
//                    withAnimation {
//                        showIngredients.toggle()
//                    }
//                }) {
//                    Image(systemName: showIngredients ? "chevron.up" : "chevron.down")
//                        .resizable()
//                        .frame(width: 14, height: 8)
//                        .foregroundColor(.primaryBlue)
//                }
//            }
//
//            if showIngredients, let ingredients = meal.activeIngredients, !ingredients.isEmpty {
//                Text(ingredients.joined(separator: ", "))
//                    .font(.regular(size: 14))
//                    .foregroundColor(.textGray)
//                    .transition(.opacity)
//            }
//        }
//    }
//}
//
//// MARK: - Portion Control
//private extension MealDetailView {
//
//    var portionControlView: some View {
//
//        VStack(alignment: .leading, spacing: 8) {
//
//            Text("Portion ")
//                .font(.semiBold(size: 18))
//            +
//            Text("Control:")
//                .font(.semiBold(size: 18))
//                .foregroundColor(.primaryBlue)
//
//            Slider(value: $portionSize, in: 0...100, step: 10)
//                .accentColor(.primaryBlue) // Active track & thumb color
//                .padding(.horizontal, 20)
//                .frame(height: 30)
//                .onChange(of: portionSize) { _ , newValue in
//
//                    if newValue == 0 {
//                        portionSize = 10 // Reset to minimum
//                    } else {
////                        adjustMealValues(newValue: newValue)
//                    }
//
//                }
//
//            HStack(alignment: .center){
//
//                Spacer()
//
//                Text("\(Int(portionSize))% of Serving")
//                    .font(.regular(size: 14))
//                    .foregroundColor(.textGray)
//
//                Spacer()
//            }
//        }
//    }
//}
//
//// MARK: - Macro Breakdown
//private extension MealDetailView {
//
////    var macroBreakdownView: some View {
////
////        HStack {
////
////            NutritionBreakdownView(amount: meal.carbs ?? "N/A", label: "Carbs")
////
////            Spacer()
////
////            NutritionBreakdownView(amount: meal.fat ?? "N/A", label: "Fat")
////
////            Spacer()
////
////            NutritionBreakdownView(amount: meal.protein ?? "N/A", label: "Protein")
////        }
////        .padding()
////        .background(
////            RoundedRectangle(cornerRadius: 15)
////                .fill(Color.textGray.opacity(0.1))
////        )
////    }
//
//
//}
//
//
//extension MealDetailView{
//
//    func setMealTags() {
//
//        let isKetoUser = UserDefaultManager.shared.get()?.diet.lowercased() == "keto diet" ? true : false
//
//        if meal.carbs?.extractInt ?? 0 < 4 && meal.protein?.extractInt ?? 0 > 10 && meal.fat?.extractInt ?? 0 > 1 {
//            mealTags.append(.keto)
//        }
//
//        if meal.fat?.extractInt ?? 0 > 15 && meal.protein?.extractInt ?? 0 > 15 {
//            mealTags.append(.highFats)
//        }
//
//        if meal.protein?.extractInt ?? 0 > 25 {
//            mealTags.append(.highProtein)
//        }
//
//        if isKetoUser && ((meal.carbs?.extractInt ?? 0) > 5) {
//            mealTags.append(.notKetoFriendly)
//        }
//
//    }
//
//}
//
//
//// MARK: - Nutrition Breakdown View
//
//
//// MARK: - Preview
//#Preview {
//    MealDetailView(
//        meal: Meal(
//            title: "Tavern Burger",
//            calories: "~800 Calories",
//            carbs: "~25g",
//            fat: "~25g",
//            protein: "~22g",
//            icon: "burger",
//            isSelected: true,
//            alternatives: [
//                AlternativeItem(title: "Fruit Bowl", details:  "A healthy mix of seasonal fruits.", category: "Breakfast", icon: "🍇"),
//                AlternativeItem(title: "Oatmeal", details:  "Warm oatmeal with honey and nuts.", category: "Healthy Grains", icon: "🥣")
//            ],
//            activeIngredients: ["Bibb lettuce", "8-ounce Angus burger patty", "Red onion", "Tomato", "American cheese", "Secret sauce"]
//        )
//    )
//}
//
//
//
