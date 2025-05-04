//
//  NutrientView.swift
//  ScanBite
//
//  Created by Syed Ahmad  on 01/05/2025.
//


import SwiftUI

// MARK: - Nutrient View
struct NutrientView: View {
    let amount: String
    let label: String
    let color: Color

    var body: some View {
        HStack {
            
            RoundedRectangle(cornerRadius: 53.76)
                .foregroundStyle(color)
                .frame(width : 6.45, height: 27.96)
            
            Text("\(label):")
                .font(.medium(size: 12.74))
                .foregroundColor(.gray)
            
            Text("\(Int(amount.extractDouble))")
                .font(.medium(size: 15.73))
                .foregroundColor(color)
            
            +
            
            Text("g")
                .font(.medium(size: 13.31))
                .foregroundStyle(Color.gray)


        }
    }
}
#Preview{
    NutrientView(amount: "231", label: "Burger", color: Color.blue)
}
