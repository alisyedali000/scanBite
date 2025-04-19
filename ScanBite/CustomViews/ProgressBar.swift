//
//  ProgressBar.swift
//  ScanBite
//
//  Created by Syed Ahmad  on 19/04/2025.
//

import SwiftUI

struct CustomProgressBar: View {
    var progress: CGFloat // 0.0 to 1.0
    var height: CGFloat?
    var color: Color
    var cornerRadius: CGFloat = 8
    @State var animatedProgress: CGFloat = 0.0
    
    var body: some View {
        
        GeometryReader { geo in
            
            ZStack(alignment: .leading) {
                
                RoundedRectangle(cornerRadius: 49.53)
                    .fill(color.opacity(0.15))
                    .frame(height: height)

                RoundedRectangle(cornerRadius: 49.53)
                    .fill(color)
                    .frame(width: geo.size.width * animatedProgress, height: height)
                    

            }
        }
        .frame(height: height ?? 5.94)
        .onAppear(){
            withAnimation(.easeInOut(duration: 0.9)) {
                animatedProgress = progress
            }

            
        }
    }
}

#Preview{
    
    CustomProgressBar(progress: 0.2, color: .blue)
    
}
