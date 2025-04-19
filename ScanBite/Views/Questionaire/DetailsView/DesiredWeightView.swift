//
//  DesiredWeightView.swift
//  ScanBite
//
//  Created by Syed Ahmad  on 17/04/2025.
//

import SwiftUI

struct DesiredWeightView: View {
    @Binding var user : User
    var action : () -> Void
    var body: some View {
        screenView
    }
}

extension DesiredWeightView{
    
    var screenView : some View {
        
        VStack(spacing: 20){
            
            Text("What is your desired weight?")
                .font(.bold(size: 22))
                .multilineTextAlignment(.center)
            
            
            Text("This is used to generate & Personalize \nresults for you.")
                .font(.medium(size: 15))
                .multilineTextAlignment(.center)
                .foregroundStyle(Color.gray)
            
            Spacer()
            
            VStack(spacing : 40){
                
                HStack(alignment: .bottom, spacing: 0){
                    
                    Text(user.desiredWeight > 0 ? "\(user.desiredWeight)" : "-- ")
                        .font(.semiBold(size: 49.89))
                    
                    Text("lbs")
                        .font(.semiBold(size: 23.7))
                        .foregroundStyle(Color.gray)
                }
                
                
                
                SliderRuler(returnValue: $user.desiredWeight, startPoint: 44, endPoint: 331)
            }
            Spacer()
            
            AppButton(title: "Next") {
                action()
            }
            .disabled(user.desiredWeight == 0)
            .opacity(user.desiredWeight == 0 ? 0.4 : 1)

        }
        
    }
    
}

#Preview {
    DesiredWeightView(user: .constant(User())){
        
    }
}
