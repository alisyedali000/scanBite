//
//  PostOnboardingView2.swift
//  ScanBite
//
//  Created by Syed Ahmad  on 21/04/2025.
//

import SwiftUI
import Charts

struct PostOnboardingView2: View {
    @State var moveNext = false
    var body: some View {
        screenView
            .navigationDestination(isPresented: $moveNext) {
                
                TabBarView()
                    .navigationBarBackButtonHidden()
                
            }
    }
}

extension PostOnboardingView2{
    
    var screenView : some View {
        
        ZStack(alignment: .bottom){
            
            ZStack{
                
                Image(.postOnboarding2)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width)
                    .ignoresSafeArea()
                
                HStack{
                    
                    macro(title: "Proteins", grams: 27.3, percentage: 33.7, color: Color(hex: "#CBB1F2"))
                    
                    Spacer()
                    
                    macro(title: "Carbs", grams: 15, percentage: 41.6, color: Color(hex: "#CCE56C"))
                    Spacer()
                    
                    macro(title: "Fats", grams: 20, percentage: 24.7, color: Color(hex: " #F5D557"))
                }
                .padding(.horizontal)
                .frame(height: 140)
//                .fixedSize()
            }

            
            modal
            
            
        }
        .ignoresSafeArea()
        
        
    }
    
}

extension PostOnboardingView2{

    var modal: some View {
        
        VStack {
            
            Spacer()
            
            ZStack {
                
                Color.white
                    .cornerRadius(30, corners: [.topLeft, .topRight])
                    .ignoresSafeArea(.container, edges: .bottom)

                VStack(spacing: 20) {
                    
                    Text("Snap a Photo & Let AI Do \nthe Work")
                        .font(.bold(size: 26))
                        .multilineTextAlignment(.center)
                        .padding(.top, 40)

                    Text("Take a quick photo of your meal, and we'll analyze the calories and macros for you.")
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

    func macro(title: String, grams: Double, percentage : Double, color: Color) -> some View {
        
        RoundedRectangle(cornerRadius: 19.2)
            .frame(width: 105, height: 131.54)
            .foregroundStyle(color)
            
            .overlay {
                
                VStack{
                    
                    Chart() {
                        
                        SectorMark(
                            angle: .value("", percentage),
                            innerRadius: .ratio(0.78),
                            outerRadius: .inset(8)
                        )
                        .foregroundStyle(Color.black)
                        
                        SectorMark(
                            angle: .value("", 100 - percentage),
                            innerRadius: .ratio(0.78),
                            outerRadius: .inset(8)
                        )
                        .foregroundStyle(Color.gray.opacity(0.4))
                        
                    }
                    .frame(width: 60, height: 60)
                    .animation(.linear(duration: 1), value: percentage)
                    
                    Text("\(Int(grams))g")
                        .font(.semiBold(size: 18.22))
                        .foregroundStyle(Color.black)
                    
                    Text(title)
                        .font(.regular(size: 14.22))
                        .foregroundStyle(Color.gray)
                    
                }
            }
            

        
        
    }
    
}

#Preview {
    PostOnboardingView2()
}
