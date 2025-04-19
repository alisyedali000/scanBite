//
//  QuestionaireView.swift
//  ScanBite
//
//  Created by Syed Ahmad  on 17/04/2025.
//

import SwiftUI

struct QuestionaireView: View {
    @StateObject var vm = OnboardingViewModel()
    @State var totalIndex = 7
    @State var selectedIndex = 1
    @State var moveNext = false
    var body: some View {
        
        ZStack{
            
            screenView
                .padding(.horizontal)
            
            if vm.showLoader{
                PreparingPlanView()
            }
        }
        .navigationDestination(isPresented: $moveNext) {
            
            RecommendedCaloriesView(personalisedPlan: $vm.plan)
                .navigationBarBackButtonHidden()
            
        }
    }
}

extension QuestionaireView{
    
    var screenView : some View {
        
        VStack{
            
            
            topBar
                .padding(.bottom, 40)
            
            switch selectedIndex{
                
            case 1:
                GenderSelectionView(user: $vm.userDetails){
                    self.selectedIndex = 2
                }
                
            case 2:
                AgeSelectionView(user: $vm.userDetails){
                    self.selectedIndex = 3
                }
                
            case 3:
                HeightWeightView(user: $vm.userDetails){
                    self.selectedIndex = 4
                }
                
            case 4:
                GoalSelectionView(user: $vm.userDetails){
                    
                    if vm.userDetails.goal != Goal.maintain.rawValue{
                        self.selectedIndex = 5
                    } else {
                        self.selectedIndex = 6
                    }
                    
                }
                
            case 5:
                DesiredWeightView(user: $vm.userDetails){
                    self.selectedIndex = 6
                }
                
            case 6:
                
                WorkoutDetailView(user: $vm.userDetails){
                    self.selectedIndex = 7
                }
                
            case 7:
                DietSelectionView(user: $vm.userDetails){
                    debugPrint(vm.userDetails)
                    Task{
                        await vm.preparePersonalizedPlan()
                        self.moveNext = true
                    }
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
            
            BackNavigation {
                withAnimation {
                    if selectedIndex > 1 {
                        if selectedIndex == 6 && vm.userDetails.goal == Goal.maintain.rawValue {
                            
                            selectedIndex = 4
                        } else {
                            selectedIndex -= 1
                        }
                    }
                }
            }
            
            
        }
        
    }
    
}

#Preview {
    QuestionaireView()
}
