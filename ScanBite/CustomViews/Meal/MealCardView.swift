//
//  MealCardView.swift
//  ScanBite
//
//  Created by Syed Ahmad  on 01/05/2025.
//


import SwiftUI

// MARK: - Updated MealCardView
struct MealCardView: View {
    
    let meal: Meal
    var body: some View {
        
        screenView
        
    }
}

extension MealCardView{
    
    var screenView: some View {
        
        VStack(alignment: .leading, spacing: 20) {
            
            HStack(alignment: .top){
                
                mealIcon
                
                titleAndTotal
                
                
                Spacer()
                
            }
            
            macros
            
            Divider()
            
            HStack{
                
                scanStatus
                
                Spacer()
                
                Image(.roundedIcon)
            }
            
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15.05)
                .fill(Color(hex: "#F2F4F4"))
        )
        
    }
    
}

extension MealCardView{
    
    var mealIcon: some View {
        
        Text(meal.icon ?? "")
            .scaledToFit()
            .frame(width: 40, height: 40)
            .clipShape(Circle())
        
    }
    
    var titleAndTotal: some View {
        
        VStack(alignment: .leading, spacing: 2) {
            
            Text(meal.title)
                .font(.semiBold(size: 17.21))
                .multilineTextAlignment(.leading)
                .foregroundStyle(Color.black)
            
            HStack{
                
                Image(systemName: "flame.fill")
                
                Text("\(meal.calories?.replacingOccurrences(of: "~", with: "") ?? "")Kcal")
                    .font(.regular(size: 14))
                    .foregroundColor(.gray)
            }
        }
        
    }
    
    
    var macros: some View {
        
        HStack {
            
            NutrientView(amount: meal.carbs ?? "", label: "Carbs", color: Color(hex: "#8E99F8"))
            
            Spacer()
            
            NutrientView(amount: meal.protein ?? "", label: "Protein", color: Color(hex: "#FFB701"))
            
            
            Spacer()
            
            NutrientView(amount: meal.fat ?? "", label: "Fat", color: Color(hex: "#08CD9F"))
            
        }
        
    }
    
    var scanStatus: some View {
        
        HStack{
            
            Text("Status:")
                .font(.medium(size: 13))
            
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
    
}

#Preview {
    MealCardView(
        meal: Meal(
            title: "Gourmet Charcuterie Breakfast",
            calories: "~650",
            carbs: "~35g",
            fat: "~30g",
            protein: "~25g",
            icon: "salad",
            isSelected: true
        )
    )
}
