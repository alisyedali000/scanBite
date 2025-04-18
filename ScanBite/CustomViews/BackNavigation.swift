//
//  BackNavigation.swift
//  ScanBite
//
//  Created by Syed Ahmad  on 17/04/2025.
//

import SwiftUI

struct BackNavigation: View {
    
    var title : String?
    var action: () -> Void
    
    var body: some View {
        screenView
    }
}

extension BackNavigation{
    
    var screenView: some View {
        
        ZStack(alignment: .leading){
            
            Button{
                
                self.action()
                
            }label: {
                
                Image(systemName: "chevron.left")
                    .foregroundStyle(Color.black)
            }
            
            
            
            HStack{
                
                Spacer()
                
                Text(title ?? "")
                    .font(.semiBold(size: 20))
                
                Spacer()
                
            }
            
            
            
        }
        
    }
    
}

#Preview {
    
    BackNavigation(title: "Edits Workouts", action: {
        
    })
}
