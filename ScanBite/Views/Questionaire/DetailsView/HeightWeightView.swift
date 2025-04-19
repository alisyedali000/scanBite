//
//  HeightWeightView.swift
//  ScanBite
//
//  Created by Syed Ahmad  on 17/04/2025.
//

import SwiftUI

struct HeightWeightView: View {
    @Binding var user : User

    var action: () -> Void
    var body: some View {
        screenView
    }
}

extension HeightWeightView{
    
    var screenView: some View {
        
        VStack(spacing: 20){
            
            
            
            Text("What’s your height And weight?")
                .font(.bold(size: 22))
            
            
            Text("We’ll use this to calculate your metabloic rate")
                .font(.medium(size: 15))
                .foregroundStyle(Color.gray)
            
            Spacer()
            
            HStack{
                
                heightSelection
                
                weightSelection
                
            }
            
            Spacer()
            
            AppButton(title: "Next") {
                

                    action()
                

            }
            
        }
        
    }
    
}

extension HeightWeightView{
    
    var heightSelection : some View {
        
        VStack{
            
            Text("Height")
                .font(.semiBold(size: 14))
            
            HStack{
                
                CustomPickerView(selection: $user.feet, range: feetRange.map({String($0)}), unit: "ft")
                
                CustomPickerView(selection: $user.inches, range: inchesRange.map({String($0)}), unit: "in")
                
            }
            
        }
        
    }
    
    var weightSelection : some View {
        
        VStack{
            
            Text("Weight")
                .font(.semiBold(size: 14))
            
            CustomPickerView(selection: $user.weight, range: (44...331).map { "\($0)" }, unit: "lbs")
            
        }
        
    }
    
}

#Preview {
    HeightWeightView(user: .constant(User())){
        
    }
}
