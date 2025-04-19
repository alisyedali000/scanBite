//
//  AgeSelection.swift
//  ScanBite
//
//  Created by Syed Ahmad  on 17/04/2025.
//

import SwiftUI

struct AgeSelectionView: View {
    @Binding var user : User

    var action : () -> Void
    var body: some View {
        screenView

    }
}

extension AgeSelectionView{
    
    var screenView: some View{
        
        VStack(spacing: 20){
            
            Text("What’s your age?")
                .font(.bold(size: 22))
            
            
            Text("We’ll use this to calculate your metabloic rate")
                .font(.medium(size: 15))
                .foregroundStyle(Color.gray)
            
            
            Spacer()
            
            HStack{
                
                CustomPickerView(selection: $user.birthMonth , range: months, unit: "")
                
                CustomPickerView(selection: $user.birthDay , range: days, unit: "")
                
                CustomPickerView(selection: $user.birthYear , range: years.map({String($0)}), unit: "")
            }
            
            if let age = calculatedAge{
                HStack(alignment: .bottom, spacing: 0){
                    Text("\(age)")
                        .font(.semiBold(size: 49.89))
                    
                    Text("Yrs")
                        .font(.semiBold(size: 23.7))
                        .foregroundStyle(Color.gray)
                }
            }
            Spacer()
            
            AppButton(title: "Next") {

                    action()
                
            }
            
        }
        
    }
    
}

extension AgeSelectionView{
    
    var days: [String] {
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        let dateString = "\(user.birthMonth) \(user.birthYear)"
        
        if let date = dateFormatter.date(from: dateString),
           let range = calendar.range(of: .day, in: .month, for: date) {
            return range.map { String($0) }
        }
        
        return (1...31).map { String($0) } // fallback
    }
    
    var calculatedAge: Int? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d yyyy"
        let dateString = "\(user.birthMonth) \(user.birthDay) \(user.birthYear)"
        
        guard let birthDate = dateFormatter.date(from: dateString) else {
            return nil
        }
        
        let now = Date()
        let ageComponents = Calendar.current.dateComponents([.year], from: birthDate, to: now)
        DispatchQueue.main.async {
            self.user.age = "\(ageComponents.year ?? 0)"
        }
       
        return ageComponents.year
    }

    
}

#Preview {
    AgeSelectionView(user: .constant(User())){
        
    }
}
