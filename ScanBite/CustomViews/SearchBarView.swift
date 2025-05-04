//
//  SearchBarView.swift
//  ScanBite
//
//  Created by Syed Ahmad  on 02/05/2025.
//


import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchText: String
    
    var body: some View {
        
        HStack {

            HStack {
                
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                
                TextField("Scanned Search Menu", text: $searchText)
                    .font(.regular(size: 11))
                    .foregroundColor(.black)

            }
            .padding(.horizontal, 10)
            .frame(height: 50)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(25)
            
            
        }
    }
}

#Preview {
    
    SearchBarView(searchText: .constant(""))

}
