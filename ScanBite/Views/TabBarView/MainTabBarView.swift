//
//  MainTabBarView.swift
//  ScanBite
//
//  Created by Syed Ahmad  on 25/04/2025.
//


import SwiftUI

struct TabBarView: View {
    @StateObject var vm = ScanViewModel()
//    @State var showPaywall = false
    @State private var selectedTab = 1
    @State var showLoader = false
    @State var showScanOptions = false
    
//    @AppStorage("showPaywall") var showPaywall = true
    init() {
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = UIColor(Color(hex: "#EDEDED"))
        tabBarAppearance.stackedLayoutAppearance.selected.iconColor = UIColor(Color.black)
        tabBarAppearance.stackedLayoutAppearance.normal.iconColor = UIColor(Color.gray)
        tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor(Color.gray)]
        tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor(Color.black)]
        tabBarAppearance.shadowImage = nil
        tabBarAppearance.shadowColor = UIColor(Color.gray.opacity(0.2))
        
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        
        
        
    }
    
    var body: some View {
        ZStack{
            
            screenView

            if vm.showLoader{
                LoaderView()
            }
//            LoadingMenuView(isLoading: $vm.showLoader, option: $vm.selectedScanOption)
        }

//        .fullScreenCover(isPresented: $showPaywall) {
//            SubscriptionScreen()
//                .onDisappear(){
//                    self.showPaywall = false
//                }
//            
//        }
//        .onAppear(){
//            
//            SubscriptionManager.shared.status(completion: { isPurchased in
//                
//                if isPurchased {
//                    showPaywall = false
//                }
//                
//            })
//            
//
//        }
        
    }
}

extension TabBarView{
    
    
    var screenView: some View{
        
        ZStack(alignment: .bottom){

            TabView(selection: $selectedTab) {
                
//                MenuListView(isPresentedPreparingMenuView: $showLoader)
//                MenuListView(vm: self.vm, showScanOptions: $showScanOptions, showPaywall: $showPaywall)
                RestaurantListView(vm: self.vm, showScanOptions: $showScanOptions)
                    .tabItem {
                        
                        Image(systemName: "fork.knife")
                            .renderingMode(.template)
                        
                        Text("Track Meal")
                        
                    }
                    .tag(1)
                
//                LoggedMacroView()
                Text("Logged Macro View")
                    .tabItem{
                        Image(systemName: "flame.fill")
                            .renderingMode(.template)
                    }
                    .tag(2)
                
                
                
                
            }

            centerButton


        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        
        
        
    }
    
}

extension TabBarView{
    
    var centerButton: some View {
    
            HStack {
                
                Spacer()
                
                Button {
                    
                    self.selectedTab = 1
                    withAnimation{
                        self.showScanOptions.toggle()
                    }
                }label: {
                    
                    ZStack{
                        
                        Circle()
                            .fill(.white)
                            .frame(height: 80)
                        
                        Image(.scanner)
                            .padding(15)
                            .background(
                                
                                Circle()
                                    .fill(Color.black)
                                
                            )
                        
                    }
                }
  
                
                Spacer()
            }
            .offset(y: -15)
        
        
    }
    
}
#Preview {
    TabBarView()
}
