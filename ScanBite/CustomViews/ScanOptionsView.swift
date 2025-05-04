//
//  ScanOptionsView.swift
//  ScanBite
//
//  Created by Syed Ahmad  on 02/05/2025.
//


import SwiftUI

struct ScanOptionsView: View {
    @Binding var showScanOption: Bool
    var onScanMenuTapped: (Bool) -> Void
    var onScanFoodTapped: (Bool) -> Void
    
    var body: some View {
        
        ZStack(alignment: .bottom){
            
            if showScanOption{
                
                Rectangle()
                    .foregroundStyle(Color.black.opacity(0.2))
                    .ignoresSafeArea()
                    .onTapGesture {
                        showScanOption = false
                    }
                
                
                VStack(spacing: 15) {
                    
                    scanButtonsRow
                }
                .padding(.bottom)
            }
        }
    }
}

// MARK: - UI Components
private extension ScanOptionsView {
    
    var scanButtonsRow: some View {
        
        HStack(spacing: 15) {
            
            scanButton(
                title: "Scan Menu",
                imageName: "scanIcon",
                action: onScanMenuTapped
            )
            
            scanButton(
                title: "Scan Food",
                imageName: "scanFood",
                action: onScanFoodTapped
            )
        }
    }
    
    func scanButton(title: String, imageName: String, action: @escaping (Bool) -> Void) -> some View {
        
        Button {
//            SubscriptionManager.shared.status(completion: { isPurchased in
//                
                action(true)
//
//            })

            self.showScanOption = false
            
            
        } label:{
            
            VStack(alignment: .center, spacing: 20) {
                
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.primaryBlue)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.primaryBlue.opacity(0.05))
                            .frame(width: 60, height: 60)
                    )
                
                Text(title)
                    .font(.semiBold(size: 14))
                    .foregroundColor(.black)
            }
            .padding(.top, 10)
            .frame(width: 160, height: 130)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.white)
                    .shadow(color: Color.primaryGray.opacity(0.1), radius: 5, x: 0, y: 3)
            )
        }
    }
}

// MARK: - Preview
#Preview {

    ScanOptionsView(showScanOption: .constant(true)){ isUserSubscribed in
        
    } onScanFoodTapped: { isUserSubscribed in
        
    }

}
