//
//  Images.swift
//  ScanBite
//
//  Created by Syed Ahmad  on 14/04/2025.
//

import Foundation
import SwiftUI



enum ImageName: String {
    
    
    //MARK: Main Screen Images
    
    case setting = "appHeaderIcon"
    
    
    //MARK: OnboardingViewer
    
    static var appHeader: Image {
        
        Image("appHeaderIcon")
    }
    
    static var onboarding1: Image {
        
        Image("onboarding1")
    }
    
    static var onboarding2: Image {
        
        Image("onboarding2")
    }
    
    static var onboarding3: Image {
        
        Image("onboarding3")
    }
    
    static var rightCurvedLines: Image {
        
        Image("rightSideVinyl")
    }
    
    static var leftCurvedLines: Image {
        
        Image("leftSideVinyls")
    }
    
    
}
