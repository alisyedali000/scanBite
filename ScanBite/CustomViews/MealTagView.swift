//
//  MealTagView.swift
//  ScanBite
//
//  Created by Syed Ahmad  on 04/05/2025.
//


import SwiftUI

// MARK: - Macro Tag View
struct MealTagView: View {
    
    let mealCategory: MealTag
    
    var body: some View {
        
        Text(mealCategory.rawValue)
            .font(.medium(size: 12))
            .foregroundColor(.white)
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(mealCategory == .notKetoFriendly ? .red : .black)
            .cornerRadius(50)
    }
}

#Preview{
    MealTagView(mealCategory: .highFats)
}
