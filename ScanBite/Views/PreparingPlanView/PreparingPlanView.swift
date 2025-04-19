//
//  PreparingPlanView.swift
//  ScanBite
//
//  Created by Syed Ahmad  on 19/04/2025.
//

import SwiftUI

struct PreparingPlanView: View {
    var body: some View {
        
        ZStack{
            
            Rectangle()
                .foregroundStyle(Color.white)
                .ignoresSafeArea()
            
            VStack(spacing: 10){
                
                AnimatedSpinner()
                    .padding(.bottom, 40)
                
                Text("Preparing personalized plan...")
                    .font(.semiBold(size: 21))
                
                Text("Please wait We're preparing everything for you to get started.")
                    .font(.regular(size: 14.8))
                    .foregroundStyle(Color.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    PreparingPlanView()
}
