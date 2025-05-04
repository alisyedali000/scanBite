//
//  Modifiers.swift
//  ScanBite
//
//  Created by Syed Ahmad  on 14/04/2025.
//

import Foundation
import SwiftUI
import StoreKit

extension View {
    
    var addBackground: some View {
        modifier(Background())
    }
    
    var addRoundedBackground: some View {
        modifier(AddRoundedBackground())
    }

    func addBgImage(image: Image) -> some View {
        modifier(AddBGImage(image: image))
    }

    
    func addStroke(radius: CGFloat, color : Color, lineWidth: CGFloat) -> some View {
        modifier(AddStroke(radius: radius, color: color, lineWidth: lineWidth))
    }
    
    
    var addDoneButton: some View {
        
        modifier(DoneButton())
        
    }
}

struct Background: ViewModifier {
    
    func body(content: Content) -> some View {
        
        ZStack {
            Rectangle()
                .foregroundStyle(Color.tabBarBlue)
                .ignoresSafeArea(.all)
            
            content
        }
    }
}



struct AddRoundedBackground : ViewModifier {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: horizontalSizeClass == .compact ? 21 : 56.8)
                    .foregroundStyle(Color.tabBarBlue)
            )
            
    }
}

struct AddBGImage : ViewModifier {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    var image: Image
    func body(content: Content) -> some View {
        content
            .background(
                VStack{
                    image
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.65)
                        .scaledToFill()
                        .ignoresSafeArea()
                    
                    Spacer()
                }
                    
                    
            )
            
    }
}


struct AddStroke : ViewModifier {
    
    var radius: CGFloat
    var color: Color
    var lineWidth: CGFloat
    
    func body(content: Content) -> some View {
        content
            .overlay {
                RoundedRectangle(cornerRadius: radius)
                    .stroke(color, lineWidth: lineWidth)
            }
    }
}


extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}



extension Date{
    
    func toString(_ format: String) -> String{
        
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
        
    }
}


struct DoneButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()

                    Button("Done") {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
                    .foregroundStyle(.blue)
                    .padding(.trailing, 20)
                }
            }
    }
}

extension UIApplication {
    
    func removeResponder() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}


extension String {
    // Function to extract integer from a string (e.g., "~12g" -> 12)
    var extractInt: Int {
        let filtered = self.filter { $0.isNumber } // Keep only digits
        return Int(filtered) ?? 0
    }
    
   
}

extension String {
    // Function to extract a Double from a string (e.g., "~12.5g" -> 12.5)
    var extractDouble: Double {
        let filtered = self.filter { $0.isNumber || $0 == "." } // Keep only digits & decimal point
        return Double(filtered) ?? 0.0
    }
}


extension Double {
    func formattedGrams() -> String {
        if self < 1 {
            return String(format: "~%.3fg", self) // Keep 3 decimal places for small numbers
        } else {
            return String(format: "~%.0fg", self) // Round for larger numbers
        }
    }

}

extension UIImage: @retroactive Identifiable {
    public var id: String { UUID().uuidString }
}



// MARK: - Cropping Function
extension UIImage {
    func crop(to rect: CGRect) -> UIImage? {
        guard let cgImage = self.cgImage?.cropping(to: rect) else { return nil }
        return UIImage(cgImage: cgImage)
    }
}


extension UIImage {
    func toData() -> Data? {
        return self.jpegData(compressionQuality: 0.8) // Adjust quality as needed
    }
}

extension Data {
    func toImage() -> UIImage? {
        return UIImage(data: self)
    }
}
