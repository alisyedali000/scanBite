//
//  CustomPickerView.swift
//  ScanBite
//
//  Created by Syed Ahmad  on 17/04/2025.
//

import SwiftUI

struct CustomPickerView: View {
    @Binding var selection: String
    var range: [String]
    var unit: String
    
    var body: some View {
        screenView
    }
}

extension CustomPickerView {
    var screenView: some View {
        
        VStack {
            
            Picker(selection: $selection, label: EmptyView()) {
                
                ForEach(range, id: \.self) { value in
                    
                        Text("\(value)")
                            .font(.regular(size: 14))
                            .fontWeight(value == selection ? .bold : .regular)
                            .foregroundStyle(value == selection ? .black : .gray)
                        
                        + Text(" \(unit)")
                            .font(.regular(size: 14))
                            .foregroundColor(value == selection ? Color.black : .gray)
                    
                }
            }
            .pickerStyle(WheelPickerStyle())
            .colorMultiply(.white)
        }
    }
}

#Preview {
    CustomPickerView(selection: .constant("12"), range: (1...30).map { String($0) }, unit: "lb")
}
