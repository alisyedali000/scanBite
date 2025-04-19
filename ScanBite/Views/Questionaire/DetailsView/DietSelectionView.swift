//
//  DietSelectionView.swift
//  ScanBite
//
//  Created by Syed Ahmad  on 18/04/2025.
//

import SwiftUI

struct DietSelectionView: View {
    @Binding var user : User
    @State private var appearedIndices: Set<Int> = []

    var action: () -> Void
    var body: some View {
        screenView
    }
}

extension DietSelectionView{
    
    var screenView : some View {
        
        VStack(spacing: 20){
            
            
            Text("What do you like?")
                .font(.bold(size: 22))
                .multilineTextAlignment(.center)
            
            
            Text("This is used to generate & Personalize \nresults for you.")
                .font(.medium(size: 15))
                .multilineTextAlignment(.center)
                .foregroundStyle(Color.gray)
            
        
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 108), spacing: 10)], spacing: 10) {
                
                ForEach(Array(diets.enumerated()), id: \.1.name) { index, diet in
                    dietGridButton(title: diet.name, image: diet.icon, isSelected: user.diet == diet.name) {
                        
                        user.diet = diet.name
                        
                    }
                    .opacity(appearedIndices.contains(index) ? 1 : 0)
                    .offset(y: appearedIndices.contains(index) ? 0 : 20)
                    .animation(.easeOut(duration: 0.4).delay(Double(index) * 0.1), value: appearedIndices)
                    .onAppear {
                        
                        appearedIndices.insert(index)
                        
                    }
                }
            }
            .padding(.top)
            
            Spacer()
            
            AppButton(title: "Next") {
                self.action()
            }
            .disabled(user.diet.isEmpty)
            .opacity(user.diet.isEmpty ? 0.4 : 1)
        }
        
    }
    
}

extension DietSelectionView{
    
    func dietGridButton(title: String, image: String, isSelected: Bool, action: @escaping () -> Void) -> some View {
        
        Button{
            
            action()
            
        }label: {
            
            RoundedRectangle(cornerRadius: 12)
                .frame(width: 108, height: 108)
                .foregroundStyle(Color(hex: "#F5F5F5"))
                .overlay {
                    
                    VStack(spacing: 15){
                        
                        Circle()
                            .frame(height: 38)
                            .foregroundStyle(Color.white)
                            .overlay {
                                Image(image)
                            }
                        
                        Text(title)
                            .font(.semiBold(size: 14))
                            .foregroundStyle(Color.black)
                    }
                    
                }
                .addStroke(radius: 12, color: .black, lineWidth: isSelected ? 1 : 0)
        }
        
        
    }
    

}

#Preview {
    DietSelectionView(user : .constant(User())){
        
    }
}
