//
//  GenderSelectionView.swift
//  ScanBite
//
//  Created by Syed Ahmad  on 17/04/2025.
//

import SwiftUI

struct GenderSelectionView: View {
    @State var gender = ""
    var onContinue : () -> Void
    var body: some View {
        screenView
    }
}

extension GenderSelectionView{
    
    var screenView : some View{
        
        VStack(spacing: 20){
            
            Text("What’s your gender?")
                .font(.bold(size: 22))
            
            
            Text("We’ll use this to calculate your metabloic rate")
                .font(.medium(size: 15))
                .foregroundStyle(Color.gray)
            
            
            VStack{
                
                ForEach(genders, id: \.self) { gender in
                    genderSelectionButton(title: gender, isSelected: self.gender == gender){
                        self.gender = gender
                    }
                }
                
                
            }
            
            Spacer()
            
            AppButton(title: "Next"){
                
                withAnimation(.easeInOut, {
                    onContinue()
                })
            }
            .disabled(self.gender.isEmpty)
            .opacity(self.gender.isEmpty ? 0.5 : 1)
        }
        


        
    }
    
}

extension GenderSelectionView{
    
    func genderSelectionButton(title: String, isSelected : Bool, action: @escaping () -> Void) -> some View {
        
        Button{
            
            action()
            
        }label: {
            
            RoundedRectangle(cornerRadius: 70)
                .foregroundStyle(isSelected ? .black : .white)
                .frame(height: 54)
                .overlay {
                    Text(title)
                        .font(.semiBold(size: 16))
                        .foregroundStyle(isSelected ? .white : .gray)
                }
                .addStroke(radius: 70, color: .gray, lineWidth: 1)
            
        }
        
    }
    
}

#Preview {
    GenderSelectionView(){
        
    }
}
