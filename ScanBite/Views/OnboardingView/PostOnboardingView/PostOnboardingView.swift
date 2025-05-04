//
//  PostOnboardingViewer.swift
//  ScanBite
//
//  Created by Syed Ahmad  on 20/04/2025.
//

import SwiftUI

struct PostOnboardingView1: View {
    @State var moveNext = false
    var body: some View {
        screenView
            .navigationDestination(isPresented: $moveNext) {
                
                PostOnboardingView2()
                    .navigationBarBackButtonHidden()
                
            }
    }
}

extension PostOnboardingView1{
    
    var screenView : some View {
        
        ZStack(alignment: .bottom){
            
            ZStack{
                
                
                Image(.postOnboarding1)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width)
                    .ignoresSafeArea()
                    .offset(y: -70)
                    .blur(radius: 4)
                
                Rectangle()
                    .foregroundStyle(Color.black.opacity(0.2))
                
                Image(.postOnboarding1Top)
                    .offset(y: -60)
            }

            
            modal
            
        }
        .ignoresSafeArea()
        
    }
    
}

extension PostOnboardingView1{
    
    var modal: some View {
        
        VStack {
            
            Spacer()
            
            ZStack {
                
                Color.white
                    .cornerRadius(30, corners: [.topLeft, .topRight])
                    .ignoresSafeArea(.container, edges: .bottom)

                VStack(spacing: 20) {
                    
                    Text("Scan Menu’s For Instant \nTracking")
                        .font(.bold(size: 26))
                        .multilineTextAlignment(.center)
                        .padding(.top, 40)

                    Text("Use AI to scan restaurant menus and get calorie and macro info instantly.")
                        .font(.medium(size: 14))
                        .foregroundStyle(Color.gray)
                        .multilineTextAlignment(.center)

                    Spacer()

                    AppButton(title: "Next") {
                        self.moveNext = true
                    }
                }
                .padding(.horizontal)
            }
            .frame(height: UIScreen.main.bounds.height * 0.30)
        }
    }

    
}

#Preview {
    PostOnboardingView1()
}
