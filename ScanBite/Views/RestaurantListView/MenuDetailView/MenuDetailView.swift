//
//  MenuDetailView.swift
//  ScanBite
//
//  Created by Syed Ahmad  on 01/05/2025.
//

import SwiftUI

struct MenuDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    let restaurant: Restaurant
    var body: some View {
        screenView
            .padding(.horizontal)
    }
}

extension MenuDetailView{
    
    var screenView : some View {
        
        VStack{
            
            BackNavigation(title: "Menu Details") {
                self.presentationMode.wrappedValue.dismiss()
            }
            
            ScrollView(showsIndicators: false){
                
                VStack{
                    
                    Image(.mapMarkerRounded)
                    
                    VStack(spacing: 10){
                        
                        Text(restaurant.name)
                            .font(.bold(size: 19))
                        
                        Text(restaurant.address)
                            .font(.medium(size: 13))
                            .foregroundStyle(Color.gray)
                    }
                    
                    LazyVStack(spacing: 12) {
                        
                        ForEach(Array((restaurant.meals ?? []).enumerated()), id: \.1) { index, meal in
                            
                            AnimatedMealCardView(meal: meal, index: index)
                            
                        }
                    }
                    
                    
                }
            }
            
        }
    }
    
}

#Preview {
    MenuDetailView(restaurant: sampleRestaurant)
}

struct AnimatedMealCardView: View {
    let meal: Meal
    let index: Int
    
    @State private var show = false
    
    var body: some View {
        
        NavigationLink{
            
            MealDetailView(meal: meal)
                .navigationBarBackButtonHidden()
            
        }label: {
            MealCardView(meal: meal)
                .opacity(show ? 1 : 0)
                .offset(y: show ? 0 : 40)
                .animation(.easeOut.delay(Double(index) * 0.2), value: show)
                .onAppear {
                    show = true
                }
        }

    }
}
