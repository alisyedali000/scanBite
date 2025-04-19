//
//  RecommendedCaloriesView.swift
//  ScanBite
//
//  Created by Syed Ahmad  on 19/04/2025.
//

import SwiftUI
import Charts

struct RecommendedCaloriesView: View {
    @Binding var personalisedPlan : PersonalizedPlanModel
    var body: some View {
        screenView
            .padding(.horizontal)
    }
}

extension RecommendedCaloriesView{
    
    var screenView: some View {
        
        VStack(spacing: 20){
            

            headerText
            
            Image(.calories)
            
            recommendation
            
            nutrients
            
            maintainWeightBanner
            
            Spacer()
            
            AppButton(title: "Get Started") {
                
                
                
            }
            
        }
        
    }
    
}


extension RecommendedCaloriesView{
    
    var headerText: some View {
        
        
        VStack{
            
            Text("Congratulations!")
                .font(.bold(size: 28))
            
            Text("Your Personalized Plan Is Ready")
                .font(.medium(size: 16))
                .foregroundStyle(Color.gray)
        }
        
    }
    
    var recommendation: some View {
        
        VStack{
            
            HStack(alignment: .bottom, spacing: 0){
                
                Text("\(Int(personalisedPlan.calories))")
                    .font(.bold(size: 42.36))
                
                Text("cal")
                    .font(.medium(size: 42.36))
                    .offset(y: 5)
            }
            
            Text("Daily calories recommendations")
                .font(.medium(size: 14.93))
                .foregroundStyle(Color.gray)
            
        }
    }
    
    var nutrients: some View{
        
        HStack{
            
            nutrientCard(value: personalisedPlan.carbs, nutrient: .carbs)
            
            Spacer()
            
            nutrientCard(value: personalisedPlan.fat, nutrient: .fat)
            
            Spacer()
            
            nutrientCard(value: personalisedPlan.protein, nutrient: .protein)
        }
        
    }
    
}

extension RecommendedCaloriesView{
    
    func nutrientCard(value: Double, nutrient: NutrientType) -> some View {
        
        ZStack{
            
            VStack(alignment: .leading, spacing: 5){
                
                Image(nutrient.icon)
                
                Text("\(Int(value)) g")
                    .font(.semiBold(size: 15.02))
                
                Text("\(nutrient.rawValue) Intake")
                    .font(.medium(size: 10.44))
                    .foregroundStyle(Color.gray)
                
                switch nutrient{
                    
                case .carbs:
                    CustomProgressBar(progress : calculatePercentage(totalCalories: personalisedPlan.calories, nutrient: .carbs, grams: personalisedPlan.carbs), color: Color(hex: "#FFB700"))
                    
                case .fat:
                    CustomProgressBar(progress: calculatePercentage(totalCalories: personalisedPlan.calories, nutrient: .fat, grams: personalisedPlan.fat), color: Color(hex: "#F09F5B"))
                    
                case .protein:
                    CustomProgressBar(progress: calculatePercentage(totalCalories: personalisedPlan.calories, nutrient: .protein, grams: personalisedPlan.protein), color: Color(hex: "#2FBDDA"))
                    
                case .calories:
                    EmptyView()
                }
                
            }
            .padding()
            .background(
                
                RoundedRectangle(cornerRadius: 11.02)
                    .foregroundStyle(Color(hex: "#F5F5F5"))
                
            )
        }
        
    }
    
    var maintainWeightBanner: some View {
        
        RoundedRectangle(cornerRadius: 12)
            .foregroundStyle(Color(hex: "#F5F5F5"))
            .frame(height: 71)
            .overlay {
                
                VStack{
                    HStack{
                        
                        ImageName.gainWeight
                            .resizable()
                            .frame(width: 28, height: 28)
                        
                        HStack(alignment: .bottom, spacing: 0){
                            Text("\(Int(personalisedPlan.maintainWeight))")
                                .font(.medium(size: 22.17))
                            
                            Text("lbs")
                                .font(.medium(size: 16.33))
                        }
                        
                    }
                    
                    Text("Weight you should maintain")
                        .font(.medium(size: 12))
                        .foregroundStyle(Color.gray)
                    
                }
                
            }
        
    }
    
}

extension RecommendedCaloriesView{
    
    func calculatePercentage(totalCalories: Double, nutrient: NutrientType, grams: Double) -> Double {
        let caloriesPerGram: Double
        
        switch nutrient {
        case .carbs, .protein:
            caloriesPerGram = 4
        case .fat:
            caloriesPerGram = 9
        case .calories:
            return 0
        }
        
        let nutrientCalories = grams * caloriesPerGram
        let percentage = (nutrientCalories / totalCalories) //* 100
        return percentage // threshold is 0 to 1
    }

    
    
}

#Preview {
    RecommendedCaloriesView(personalisedPlan: .constant(PersonalizedPlanModel()))
}
