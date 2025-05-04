//
//  RestaurantListView.swift
//  ScanBite
//
//  Created by Syed Ahmad  on 01/05/2025.
//

import SwiftUI
import SwiftData

struct RestaurantListView: View {
    @Environment(\.modelContext) var modelContext
    
    @Query(sort: \RestaurantEntity.createdAt, order: .reverse) var menus: [RestaurantEntity]
    
    @ObservedObject var vm : ScanViewModel
    @State var searchQuery = ""
    @State var showCamera = false
    @Binding var showScanOptions : Bool
    var body: some View {
        ZStack{
            
            screenView
                .padding(.horizontal)
            
            scanOptionsView
        }
        .onAppear(){
            
            Task{
                LocationManager.shared.requestLocation { result in
                    
                    switch result {
                        
                    case .success(let location):
                        
                        vm.location = location
                        
                    case .failure(let error):
                        
                        if error.localizedDescription == LocationError.accessDenied.errorDescription {
                            
                            DispatchQueue.main.async {
                                
                                vm.showAlert(message: "Access was denied! Please enable location services in Settings.")
                                
                            }
                        }
                    }
                }
            }
            
        }
        .fullScreenCover(isPresented: $showCamera) {
            

                if vm.selectedScanOption == .scanMenu{
                    
                    cameraForScanMenuView
                    
                } else {
                    
//                    ScanFoodView(vm: self.vm, isPresented: $showCamera){
//                        
//                        toggleFoodDetailSheet = true
//                        
//                    }
                }
                
            
            
            
            
        }
    }
}

extension RestaurantListView{
    
    var screenView : some View {
        
        
        VStack{
            
            SearchBarView(searchText: $searchQuery)
                .padding(.vertical)
            
            ScrollView(showsIndicators: false){
                
                VStack(alignment: .leading){
                    
                    Text("Scanned Menus")
                        .font(.semiBold(size: 18))
                    
                    ForEach(menus, id: \.id) { restaurant in
                        
                        
                        NavigationLink{
                            
                            MenuDetailView(restaurant: restaurant.menu)
                                .navigationBarBackButtonHidden()
                            
                        } label: {
                            
                            RestaurantCard(restaurant: restaurant.menu)
                        }
                        
                    }
                    
//                    NavigationLink{
//                        
//                        MenuDetailView(restaurant: sampleRestaurant)
//                            .navigationBarBackButtonHidden()
//                        
//                    } label: {
//                        
//                        RestaurantCard(restaurant: sampleRestaurant)
//                    }
                    
                }
                
            }
        }
    }
}

extension RestaurantListView{
    
    var scanOptionsView: some View {

            ScanOptionsView(
                showScanOption: $showScanOptions,
                onScanMenuTapped: { isUserSubscribed in
                    
                    DispatchQueue.main.async {
                        vm.selectedScanOption = .scanMenu

                    }
                    
                    
                    if isUserSubscribed{
                        self.showCamera = true
                    } else {
                        self.showCamera = true
                    }
                    
                },
                onScanFoodTapped: { isUserSubscribed in
                    
                    DispatchQueue.main.async {
                        vm.selectedScanOption = .scanFood
                        

                    }
                    
                    if isUserSubscribed{
                        self.showCamera = true
                    } else {
                        self.showCamera = true
                    }
                }
            )
        
    }
    
    
    var cameraForScanMenuView: some View {
        
        CameraView(isPresented: $showCamera, didCaptureImage: { image in
            
            self.showCamera = false
            
            vm.ocr(image: image){
                
                debugPrint(vm.scannedMenuText)
                
                Task{
                    
                    await vm.scanMenu(){
                        modelContext.insert(RestaurantEntity(id: UUID(), menu: vm.menu))
                        try?modelContext.save()
                        
                    }
                    
                }
            }
            
        })
        
    }
    
}

#Preview {
    RestaurantListView(vm: ScanViewModel(), showScanOptions: .constant(false))
}
