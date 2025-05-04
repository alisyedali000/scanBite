//
//  RestaurantCard.swift
//  ScanBite
//
//  Created by Syed Ahmad  on 01/05/2025.
//

import SwiftUI

struct RestaurantCard: View {
    let restaurant: Restaurant
    var body: some View {
        screenView
    }
}

extension RestaurantCard{
    
    var screenView: some View {
        
        
        HStack(spacing: 15){
            
            Image(.roundedLocationIcon)
            
            VStack(alignment: .leading, spacing : 10){
                
                Text(restaurant.name)
                    .font(.bold(size: 14))
                
                Text(restaurant.address)
                    .font(.regular(size: 11))
                
            }
            
            Spacer()
            
            Image(.roundedIcon)
            
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(hex: "#F5F5F5"))
        )
        
    }
    
}

#Preview {
    RestaurantCard(restaurant: sampleRestaurant)
}
