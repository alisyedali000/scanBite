//
//  OnboardingViewer.swift
//  ScanBite
//
//  Created by Syed Ahmad  on 14/04/2025.
//

import SwiftUI

struct OnboardingViewer: View {
    
    @State var selectedTab = 1
    @State var moveNext = false
    
    
    @State private var imageAnimation: Bool = false
    
    var body: some View {
        
        ZStack{
            
            curvedBGLines
            
            screenView
                .onAppear(){
                    viewDidLoad()
                }
                .padding(.horizontal)
            
        }
        .navigationDestination(isPresented: $moveNext) {
            
            QuestionaireView()
                .navigationBarBackButtonHidden()
            
        }
    }
}

extension OnboardingViewer{
    
    var screenView: some View {
        
        VStack(spacing: 20){
            
            ImageName.appHeader
            
            VStack{
                switch selectedTab{
                    
                case 1:
                    
                    Text(onboarding1Title)
                        .font(.bold(size: 27.22))
                        .multilineTextAlignment(.center)
                        .opacity(imageAnimation ? 1 : 0.3)
                    Text(onboarding1Description)
                        .font(.regular(size: 14.22))
                        .multilineTextAlignment(.center)
                        .opacity(imageAnimation ? 1 : 0.3)
                case 2:
                    
                    Text(onboarding2Title)
                        .font(.bold(size: 27.22))
                        .multilineTextAlignment(.center)
                    
                    Text(onboarding2Description)
                        .font(.regular(size: 14.22))
                        .multilineTextAlignment(.center)
                    
                case 3:
                    
                    Text(onboarding3Title)
                        .font(.bold(size: 27.22))
                        .multilineTextAlignment(.center)
                    
                    Text(onboarding3Description)
                        .font(.regular(size: 14.22))
                        .multilineTextAlignment(.center)
                default:
                    EmptyView()
                }
                
            }
            
            tabSelection
            
            VStack{
                switch selectedTab{
                    
                case 1:
                    ImageName.onboarding1
                    
                    
                case 2:
                    ImageName.onboarding2
                    
                case 3:
                    ImageName.onboarding3
                    
                    
                default:
                    EmptyView()
                }
            }
            .swipeAnimation(startAnimation: imageAnimation, xOffset: 1)

            
            Spacer()
            
            AppButton(title: "Continue") {
                
                withAnimation(.easeInOut(duration: 0.5)) {
                    
                    if selectedTab < 3 {
                        
                        selectedTab += 1
                        viewDidLoad()
                        
                    } else {
                        
                        moveNext.toggle()
                        
                    }
                }
            }
        }
        
    }
    
}

extension OnboardingViewer{
    
    var tabSelection: some View {
        
        HStack(spacing: -25) {
            
            ForEach(1..<4) { tab in
                
                RoundedRectangle(cornerRadius: 50)
                    .foregroundStyle(selectedTab == tab ? Color.black : Color.gray)
                    .frame(width: selectedTab == tab ? 32 : 10 , height: 10)
                    .padding()
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.5)) {  // Smooth transition
                            self.selectedTab = tab
                        }
                    }
            }
        }

    }
    
    var curvedBGLines: some View{
        
        VStack{
            
            HStack{
                
                Spacer()
                
                ImageName.rightCurvedLines
            }
            
            HStack{
                
                ImageName.leftCurvedLines
                
                Spacer()
            }

        }
        
    }
    
}

extension OnboardingViewer{
    
    func viewDidLoad() {
        debugPrint("pageOne")
        self.imageAnimation = false

        withAnimation(.easeOut(duration: 2)) {
            self.imageAnimation = true
        }
    }
    
}

#Preview {
    OnboardingViewer()
}
