//
//  AppButton.swift
//  ScanBite
//
//  Created by Syed Ahmad  on 14/04/2025.
//

import SwiftUI

struct AppButton: View {
    
    var title : String
    var action: () -> Void

    var body: some View {
       screenView
    }
}

extension AppButton{
    
    var screenView: some View {

            Button{
                self.action()
            }label:{
               
                RoundedRectangle(cornerRadius: 65)
                    .foregroundStyle(Color.black)
                    .frame(height: 48)
                    .overlay {
                        Text(title)
                            .font(.semiBold(size: 17.22))
                            .foregroundStyle(Color.white )
                    }
                
            }
        
    }
    
}

#Preview {
    AppButton(title: "Next", action: {
        
    })
}
