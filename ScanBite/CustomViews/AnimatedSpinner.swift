//
//  SwiftUIView.swift
//  ScanBite
//
//  Created by Syed Ahmad  on 19/04/2025.
//

import SwiftUI

struct AnimatedSpinner: View {
    @State private var degree:Int = 270
    @State private var spinnerLength = 0.6
    
    // MARK: - Body
    var body: some View {
    
        Circle()
            .trim(from: 0.0,to: spinnerLength)
            .stroke(LinearGradient(colors: [.black,.gray.opacity(0.7)], startPoint: .topLeading, endPoint: .bottomTrailing),style: StrokeStyle(lineWidth: 9.0,lineCap: .round,lineJoin:.round))
            .animation(Animation.easeIn(duration: 1.5).repeatForever(autoreverses: true))
            .frame(width: 80,height: 80)
            .rotationEffect(Angle(degrees: Double(degree)))
            .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
            .onAppear{
                degree = 270 + 360
                spinnerLength = 0
            }
        
        
        
    }
}

#Preview {
    AnimatedSpinner()
}
