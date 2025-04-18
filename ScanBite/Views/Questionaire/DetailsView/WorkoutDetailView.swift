//
//  WorkoutDetailView.swift
//  ScanBite
//
//  Created by Syed Ahmad  on 17/04/2025.
//

import SwiftUI

struct WorkoutDetailView: View {
    @State var desiredWeight = 128
    @State var workoutSelection = ""
    var action : () -> Void
    var body: some View {
        screenView
    }
}

extension WorkoutDetailView{
    
    var screenView : some View {
        
        
        VStack(spacing: 20){
            
            Text("How many workouts do you \ncomplete each day?")
                .font(.bold(size: 22))
                .multilineTextAlignment(.center)
            
            
            Text("This is used to generate & Personalize \nresults for you.")
                .font(.medium(size: 15))
                .multilineTextAlignment(.center)
                .foregroundStyle(Color.gray)
            
            VStack(spacing: 20){
                
                workoutButton(image: ImageName.dumbBell, title: "0-2", description: "Occasional Workouts", isSelected: workoutSelection == "0-2") {
                    
                    withAnimation {
                        self.workoutSelection = "0-2"
                    }

                }
                
                workoutButton(image: ImageName.dumbBell, title: "3-5", description: "Occasional Workouts", isSelected: workoutSelection == "3-5") {
              
                    withAnimation {
                        
                        self.workoutSelection = "3-5"
                    }
                }
                
                workoutButton(image: ImageName.dumbBell, title: "6+", description: "Occasional Workouts", isSelected: workoutSelection == "6+") {
                    
                    withAnimation {
                        
                        self.workoutSelection = "6+"
                        
                    }

                   
                    
                }
                
            }
            .padding(.top)
            
            Spacer()
           
            AppButton(title: "Next") {
                
                withAnimation {
                    action()
                }
                
            }
            .disabled(workoutSelection.isEmpty)
            .opacity(workoutSelection.isEmpty ? 0.4 : 1)
            
        }
        
    }
    
}

extension WorkoutDetailView{
    
    func workoutButton(image: Image, title: String, description: String, isSelected: Bool , action: @escaping () -> Void ) -> some View {
        

            Button{
                
                action()
                
            }label: {
                
                RoundedRectangle(cornerRadius: 13)
                    .foregroundStyle(Color(hex: "#F5F5F5"))
                    .frame(height: 64)
                    .addStroke(radius: 13, color: .black, lineWidth: isSelected ? 1 : 0)
                    .overlay {
                        
                        HStack{
                            
                            Circle()
                                .frame(height: 40)
                                .foregroundStyle(Color.white)
                                .overlay{
                                    image
                                }
                            
                            
                            VStack(alignment: .leading){
                                Text(title)
                                    .font(.semiBold(size: 16))
                                    .foregroundStyle(Color.black)
                                
                                Text(description)
                                    .font(.medium(size: 12))
                                    .foregroundStyle(Color.gray)
                            }
                            
                            Spacer()
                            
                            Image(systemName: "circle")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .foregroundStyle(Color.black)
                                .overlay {
                                    if isSelected{
                                        Circle()
                                            .frame(height: 15)
                                            .foregroundStyle(Color.black)
                                    }
                                }
                            
                            
                        }
                       
                        .padding(.horizontal)
                        
                        
                    }
                
            }
        
        
    }
    
}

#Preview {
    WorkoutDetailView(){
        
    }
}
