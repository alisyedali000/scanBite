//
//  QuestionaireView.swift
//  ScanBite
//
//  Created by Syed Ahmad  on 17/04/2025.
//

import SwiftUI

struct QuestionaireView: View {
    @State var totalIndex = 7
    @State var selectedIndex = 1
    
    var body: some View {
        screenView
            .padding(.horizontal)
    }
}

extension QuestionaireView{
    
    var screenView : some View {
        
        VStack{
            
            
            topBar
                .padding(.bottom, 40)
            
            switch selectedIndex{
                
            case 1:
                GenderSelectionView(){
                    self.selectedIndex += 1
                }
                
            case 2:
                AgeSelectionView(){
                    self.selectedIndex += 1
                }
                
            case 3:
                HeightWeightView(){
                    self.selectedIndex += 1
                }
                
            case 4:
                GoalSelectionView(){
                    self.selectedIndex += 1
                }
                
            case 5:
                WorkoutDetailView(){
                    self.selectedIndex += 1
                }
                
            case 6:
                DesiredWeightView(){
                    self.selectedIndex += 1
                }
                
            case 7:
                DietSelectionView(){
                    self.selectedIndex += 1
                }
            default:
                EmptyView()
            }

        }
        
    }
    
}

extension QuestionaireView{
    
    var topBar: some View {
        
        ZStack{
            
            HStack{
                
                ForEach(1...totalIndex, id: \.self) { index in
                    RoundedRectangle(cornerRadius: 40)
                        .fill(index <= selectedIndex ? Color.black : Color.gray.opacity(0.3))
                        .frame(width: 32, height: 7)
                }
            }
            
            BackNavigation(){
                withAnimation {
                    self.selectedIndex -= 1
                }

            }
            
        }
        
    }
    
}

#Preview {
    QuestionaireView()
}
