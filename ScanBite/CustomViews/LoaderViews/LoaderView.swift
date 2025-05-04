//
//  PreparingPlanView.swift
//  ScanBite
//
//  Created by Syed Ahmad  on 02/05/2025.
//


import SwiftUI

struct LoaderView: View {
    var body: some View {
        
        ZStack{
            
            Rectangle()
                .foregroundStyle(Color.white)
                .ignoresSafeArea()
            
            VStack(spacing: 10){
                
                AnimatedSpinner()
                    .padding(.bottom, 40)
                
                Text("Analysing your meals...")
                    .font(.semiBold(size: 21))
                
                Text("Please wait while we're analysing everything for you.")
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
    LoaderView()
}
