//
//  GoalSelectionView.swift
//  ScanBite
//
//  Created by Syed Ahmad  on 17/04/2025.
//

import SwiftUI

struct GoalSelectionView: View {
    
    @State var goal : Goal = .none
    @State private var imageAnimation: Bool = false
    var action: () -> Void
    var body: some View {
        screenView
            .onAppear(){
                viewDidLoad()
            }
    }
}

extension GoalSelectionView{
    
    var screenView : some View {
        
        VStack(spacing: 20){
            
            
            Text("What’s your height and weight?")
                .font(.bold(size: 22))
            
            
            Text("We’ll use this to calculate your metabloic rate")
                .font(.medium(size: 15))
                .foregroundStyle(Color.gray)
            
            Spacer()
            
            VStack{
                
                goalSelectionButton(image: ImageName.loseWeight, title: "Lose Weight", isSelected: goal == .lose, alignment: .trailing){
                    
                    self.goal = .lose
                    
                }
                .swipeAnimation(startAnimation: imageAnimation, xOffset: 1)
                
                goalSelectionButton(image: ImageName.maintainWeight, title: "Maintain Weight", isSelected: goal == .maintain, alignment: .leading){
                    
                    self.goal = .maintain
                }
                .swipeAnimation(startAnimation: imageAnimation, xOffset: -1)
                
                goalSelectionButton(image: ImageName.gainWeight, title: "Gain Weight", isSelected: goal == .gain, alignment: .trailing){
                    
                    self.goal = .gain
                }
                .swipeAnimation(startAnimation: imageAnimation, xOffset: 1)
                
            }
            
            Spacer()
            
            AppButton(title: "Next") {
                withAnimation {
                    self.action()
                }
                
            }
            .opacity(goal == .none ? 0.4 : 1)
            .disabled(goal == .none)
            
        }
        
    }
    
}

extension GoalSelectionView{
    
    func goalSelectionButton(image: Image, title: String, isSelected: Bool, alignment: Alignment, action: @escaping () -> Void) -> some View {
        
        Button{
            
            action()
            
        }label: {
            
            HStack(spacing: -30) {
                
                if alignment == .leading {
                    
                    labelBox(title: title, isSelected: isSelected)
                    
                    iconCircle(image: image, isSelected: isSelected)
                        .zIndex(1)
                    Spacer()
                    
                } else {
                    
                    Spacer()
                    
                    iconCircle(image: image, isSelected: isSelected)
                        .zIndex(1)
                    
                    labelBox(title: title, isSelected: isSelected)
                }
            }
            .offset(x: alignment == .leading ? -20 : 20)
        }
        
           
        }

        func labelBox(title: String, isSelected: Bool) -> some View {
            
            Text(title)
                .font(.semiBold(size: 20))
                .foregroundStyle(Color.black)
                .frame(width: 260, height: 70)
                .background(Color(hex: "#F5F5F5"))
                .overlay(
                    RoundedRectangle(cornerRadius: 0)
                        .stroke(Color.black, lineWidth: isSelected ? 1 : 0)
                )
        }

    func iconCircle(image : Image, isSelected: Bool) -> some View {
        
        ZStack{
            
            Circle()
                .frame(width: 89, height: 89)
                .foregroundStyle(Color(hex: "#EDEDED"))
                .overlay(
                    
                    Circle()
                        .stroke(Color.black, lineWidth: isSelected ? 1 : 0)
                    
                )
            
            image
        }
    }
    
}

extension GoalSelectionView{
    
    func viewDidLoad() {
        debugPrint("pageOne")
        self.imageAnimation = false

        withAnimation(.easeOut(duration: 2)) {
            self.imageAnimation = true
        }
    }
    
}

#Preview {
    GoalSelectionView(){
        
    }
}
