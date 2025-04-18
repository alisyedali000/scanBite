//
//  WheelPicker.swift
//  ScanBite
//
//  Created by Syed Ahmad  on 17/04/2025.
//


import SwiftUI
import AudioToolbox

struct SliderRuler: View {
    
    @State var offset: CGFloat = 0
    
    @Binding var returnValue: Int
    private var startPoint: Int
    private var endPoint: Int
    
    init(returnValue: Binding<Int>, startPoint: Int, endPoint: Int) {
        
        self._returnValue = returnValue
        self.startPoint = startPoint
        self.endPoint = endPoint
    }
    
    var body: some View {
        
        VStack {
            
            let pickerCount = (endPoint - startPoint) / 5
            
            CustomSlider(offSet: $offset, pickerCount: pickerCount) {
                
                HStack(spacing: 0) {
                    
                    ForEach(1...pickerCount, id: \.self) { index in
                        
                        VStack {
                            
                            Rectangle()
                                .fill(.black)
                                .frame(width: 1, height: 30)
                                
                            
                            Text("\((startPoint - 5) + (index * 5))")
                                .font(.light(size: 10))
                                .foregroundStyle(.black)
                        }

                        .frame(width: 20)

                        ForEach(1...4, id: \.self) { subIndex in
                            
                            Rectangle()
                                .fill(.black)
                                .frame(width: 1, height: 15)
                                .frame(width: 20)
                        }
                    }
                    
                    VStack(spacing: 10) {
                        
                        Rectangle()
                            .fill(.black)
                            .frame(width: 1, height: 30)
                        
                        Text("\(endPoint)")
                            .font(.light(size: 10))
                            .foregroundStyle(.black)
                    }
                    .frame(width: 20)
                }
                
                .offset(x: (getRect().width - 30) / 2)
                .padding(.trailing, getRect().width - 30)
            }
            .frame(height: 50)
            .overlay(content: {
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 3, height: 50)
                    .offset(x: 0.4, y: -9)
                    .padding(.bottom)
            })
        }
        .onChange(of: offset) {
            getWeight()
        }
    }
    
    func getWeight() {
        
        let startWeight = startPoint
        
        let progress = offset / 20

        let totalWeight = startWeight + (Int(progress) * 1)
        
        self.returnValue = totalWeight
    }
}

#Preview {
    SliderRuler(returnValue: .constant(80), startPoint: 30, endPoint: 150)
}

func getRect() -> CGRect {
    return UIScreen.main.bounds
}

struct CustomSlider<Content: View> : UIViewRepresentable {
    
    private var content: Content
    private var pickerCount: Int
    @Binding private var offSet: CGFloat
    
    init(offSet: Binding<CGFloat>,
         pickerCount: Int,
         @ViewBuilder content:  @escaping () -> Content) {
        self.content = content()
        self._offSet = offSet
        self.pickerCount = pickerCount
    }
    
    func makeCoordinator() -> Coordinator {
        return CustomSlider.Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> UIScrollView {
        
        let scrollView = UIScrollView()
        
        let swiftUIView = UIHostingController(rootView: content).view!
        
        let width = CGFloat((pickerCount * 5) * 20) + ( getRect().width - 30)
        
        swiftUIView.frame = CGRect(x: 0, y: 0, width: width, height: 50)
        
        swiftUIView.backgroundColor = UIColor.clear
        
        scrollView.contentSize = swiftUIView.frame.size
        scrollView.addSubview(swiftUIView)
        
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        
        scrollView.delegate = context.coordinator
        
        return scrollView
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        
    }
    
    // Delegate methods for offset
    class Coordinator : NSObject, UIScrollViewDelegate {
        
        private var parent: CustomSlider
        
        init(parent: CustomSlider) {
            self.parent = parent
        }
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            
            parent.offSet = scrollView.contentOffset.x
        }
        
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            
            let offSet = scrollView.contentOffset.x
            
            let value = (offSet / 20).rounded(.toNearestOrAwayFromZero)
            
            scrollView.setContentOffset(CGPoint(x: value * 20, y: 0), animated: false)

            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
            
            AudioServicesPlayAlertSound(1157)
        }
        
        func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
            
            if !decelerate {
                
                let offSet = scrollView.contentOffset.x
                
                let value = (offSet / 20).rounded(.toNearestOrAwayFromZero)
                
                scrollView.setContentOffset(CGPoint(x: value * 20, y: 0), animated: false)

                AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)

                AudioServicesPlayAlertSound(1157)
            }
        }
    }
}
