//
//  DesiredWeightView.swift
//  ScanBite
//
//  Created by Syed Ahmad  on 17/04/2025.
//

import SwiftUI

struct DesiredWeightView: View {
    @State var desiredWeight = 0
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
                    
                    Text(desiredWeight > 0 ? "\(desiredWeight)" : "-- ")
                        .font(.semiBold(size: 49.89))
                    
                    Text("lbs")
                        .font(.semiBold(size: 23.7))
                        .foregroundStyle(Color.gray)
                }
                
                
                
                SliderRuler(returnValue: $desiredWeight, startPoint: 44, endPoint: 331)
            }
            Spacer()
            
            AppButton(title: "Next") {
                action()
            }
            .disabled(desiredWeight == 0)
            .opacity(desiredWeight == 0 ? 0.4 : 1)

        }
        
    }
    
}

#Preview {
    DesiredWeightView(){
        
    }
}
