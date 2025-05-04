//
//  VerticalProgressBar.swift
//  ScanBite
//
//  Created by Syed Ahmad  on 21/04/2025.
//

import SwiftUI

struct VerticalProgressBar: View {
    @State var progress = 0.0
    @State var animatedProgress: CGFloat = 0.0
    var totalCalories: Double
    var nutrient: NutrientType
    var grams : Double
    var width: CGFloat?
    var color: Color
    var cornerRadius: CGFloat = 8

    
    var body: some View {
        
                
                VStack{
                    
                    ZStack(alignment: .bottom) {
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .foregroundStyle(Color(hex: "#F5F5F5"))
                            .frame(width: width, height: 140)
                            .overlay(
                                RoundedRectangle(cornerRadius: cornerRadius)
                                    .stroke(Color.gray.opacity(0.2), lineWidth: 0) // optional border
                            )

                        RoundedRectangle(cornerRadius: cornerRadius)
                            .fill(color)
                            .frame(width: width, height: 140 * animatedProgress)
                            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                    }

                    
                    VStack{
                        
                        Text("\(nutrient.rawValue)")
                            .font(.medium(size: 15))
                            .foregroundStyle(Color.black)
                        
                        Text("\(Int(grams))g")
                            .font(.semiBold(size: 20))
                            .foregroundStyle(Color.black)
                    }
                    
                }
            
            .frame(width: width ?? 5.94)
            
        .onAppear(){
            

            calculatePercentage()
            
        }
    }
}

extension VerticalProgressBar{
    
    func calculatePercentage() {
        
        let caloriesPerGram: Double
        
        switch nutrient {
            
        case .carbs, .protein:
            caloriesPerGram = 4
            
        case .fat:
            caloriesPerGram = 9
            
        case .calories:
            return
        }
        
        let nutrientCalories = grams * caloriesPerGram
        let percentage = (nutrientCalories / totalCalories) //* 100
        progress = percentage
        withAnimation(.easeInOut(duration: 0.9)) {
            animatedProgress = progress
        }
        // threshold is 0 to 1
    }
    
}

#Preview{
    
    VerticalProgressBar(totalCalories: 100, nutrient: .carbs, grams: 2, width: 109, color: .blue)
    
}
