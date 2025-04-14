//
//  Fonts.swift
//  ScanBite
//
//  Created by Syed Ahmad  on 14/04/2025.
//

import Foundation
import SwiftUI

extension Font {
    
    
    //MARK: Poppins
    static func bold(size: CGFloat) -> Font {
        self.custom("Raleway-Bold", size: size)
    }
    
    static func semiBold(size: CGFloat) -> Font {
        self.custom("Raleway-SemiBold", size: size)
    }
    
    static func medium(size: CGFloat) -> Font {
        self.custom("Raleway-Medium", size: size)
    }
    
    static func regular(size: CGFloat) -> Font {
        self.custom("Raleway-Regular", size: size)
    }
    
    static func light(size: CGFloat) -> Font {
        self.custom("Raleway-Light", size: size)
    }
    
    
}
