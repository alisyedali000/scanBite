//
//  NutritionRow.swift
//  ScanBite
//
//  Created by Syed Ahmad  on 11/05/2025.
//
import SwiftUI

struct NutritionInfoRow: View {
    let title: String
    let value: String
    let icon : Image
    var body: some View {
        HStack {
            
            icon
            
            Text(title)
                .font(.regular(size: 13))
                .foregroundColor(.black)
            
            Spacer()
            
            Text(value.replacingOccurrences(of: "~", with: ""))
                .font(.semiBold(size: 14))
        }
        .frame(height: 20)
    }
}

// MARK: - Preview
#Preview {
    NutritionInfoRow(title: "hello", value: "547 KCAL" , icon: ImageName.carbs)
}
