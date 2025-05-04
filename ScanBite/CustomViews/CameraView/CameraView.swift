//
//  CameraView.swift
//  ScanBite
//
//  Created by Syed Ahmad  on 02/05/2025.
//


import SwiftUI
import SwiftUI

import AVFoundation

struct CameraView: View {
    
    @StateObject private var cameraManager = CameraManager()
    @Binding var isPresented : Bool
    @State private var scanFrameSize: CGFloat = UIScreen.main.bounds.width
    @State private var scanFrameOffset: CGSize = .zero
    
    @State private var capturedImage: UIImage? = nil // Store captured image
    
    var didCaptureImage: (UIImage) -> Void
    var mediaSource: MediaSource = .camera

    var body: some View {
        ZStack {
            
            CameraPreview(session: cameraManager.session)
                .ignoresSafeArea()
            
            VStack {
                
                headerView
                
                Spacer()
                
//                if cameraManager.isCameraReady {
//                    self.scanningFrameView
//                }
                
                Spacer()
                
                HStack{
                    
                    captureButton
               
                }
              
            }
            
        }
        .background(Color.black.opacity(0.9).edgesIgnoringSafeArea(.all))
        .onAppear { cameraManager.startSession() }
        .onDisappear {
            self.cameraManager.stopSession()
        }
        .onChange(of: cameraManager.capturedImage) {
            DispatchQueue.main.async {
                
                guard let image = cameraManager.capturedImage else { return }
                didCaptureImage(image)
                
            }
        }
    }
}


// MARK: - Header View
private extension CameraView {
    
    var headerView: some View {
        
        HStack {
            
            closeButton
            
            Spacer()
            
            Text("MenuAI Scan")
                .font(.title3.bold())
                .foregroundColor(.white)
            
            Spacer()
            
            flashButton
        }
        .padding(.horizontal, 20)
        .padding(.top, 50)
    }
    
    var closeButton: some View {
        
        Button(action: {
            
            self.isPresented = false
            
        }) {
            
            Image(systemName: "xmark.circle.fill")
                .resizable()
                .frame(width: 32, height: 32)
                .foregroundColor(Color.white.opacity(0.7))
        }
    }
    
    var flashButton: some View {
        
        Button(action: { cameraManager.toggleFlash() }) {
            
            Image(systemName: cameraManager.isFlashOn ? "bolt.fill" : "bolt.slash.fill")
                .resizable()
                .frame(width: 32, height: 32)
                .foregroundColor(Color.white.opacity(0.7))
        }
    }
}

// MARK: - Scanning Frame
private extension CameraView {
    
    var scanningFrameView: some View {
        ScanningFrame(scanFrameSize: $scanFrameSize, scanFrameOffset: $scanFrameOffset)
            .frame(maxHeight: .infinity)
            .offset(scanFrameOffset)
        
    }
}

// MARK: - Capture Button
private extension CameraView {
    
    var captureButton: some View {
        
        Button(action: {
            cameraManager.capturePhoto(scanFrameSize: scanFrameSize, scanFrameOffset: scanFrameOffset)
//            cameraManager.stopSession()
  
        }) {
            
            Circle()
                .frame(height: 70)
                .foregroundColor(.white)
            
        }
        .padding(.bottom, 30)
    }
}

// MARK: - Scanning Frame
struct ScanningFrame: View {
    
    @Binding var scanFrameSize: CGFloat
    @Binding var scanFrameOffset: CGSize
    @State private var lastOffset: CGSize = .zero
    @State private var initialSize: CGFloat = 280
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .stroke(Color.white, lineWidth: 4)
            .frame(width: scanFrameSize, height: scanFrameSize * 1.5)
            .background(Color.black.opacity(0.001))
            .gesture(dragGesture)
            .gesture(magnificationGesture)
            .animation(.easeOut(duration: 0.5), value: scanFrameOffset)
    }
    
    private var dragGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                scanFrameOffset = CGSize(
                    width: lastOffset.width + value.translation.width,
                    height: lastOffset.height + value.translation.height
                )
            }
            .onEnded { value in
                lastOffset.width += value.translation.width
                lastOffset.height += value.translation.height
            }
    }
    
    private var magnificationGesture: some Gesture {
        MagnificationGesture()
            .onChanged { value in
                scanFrameSize = max(200, min(400, initialSize * value))
            }
            .onEnded { _ in
                initialSize = scanFrameSize
            }
    }
}

// MARK: - Camera Preview
struct CameraPreview: UIViewRepresentable {
    
    let session: AVCaptureSession
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.frame = view.frame
        view.layer.addSublayer(previewLayer)
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}

// MARK: - Preview
#Preview {
    CameraView(isPresented: .constant(true), didCaptureImage: {_ in })
}









