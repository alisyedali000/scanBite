//
//  CameraManager.swift
//  ScanBite
//
//  Created by Syed Ahmad  on 02/05/2025.
//


import Swift
import AVFoundation
import UIKit

// MARK: - Camera Manager
class CameraManager: NSObject, ObservableObject, AVCapturePhotoCaptureDelegate {
    let session = AVCaptureSession()
    private let output = AVCapturePhotoOutput()
    @Published var isFlashOn = false
    @Published var capturedImage: UIImage? = nil
    @Published var isCameraReady = false
    
    var scanFrameSize: CGFloat = .zero
    var scanFrameOffset: CGSize = .zero
    
    override init() {
        super.init()
        setupSession()
    }
    
    private func setupSession() {
        session.sessionPreset = .high // ⚡️ Optimized for speed
        guard let device = AVCaptureDevice.default(for: .video) else { return }
        
        do {
            let input = try AVCaptureDeviceInput(device: device)
            if session.canAddInput(input) { session.addInput(input) }
            if session.canAddOutput(output) { session.addOutput(output) }
            
            self.output.maxPhotoQualityPrioritization = .speed // ⚡️ Capture quickly
            self.output.isHighResolutionCaptureEnabled = false // ⚡️ No unnecessary high-res processing
            
            DispatchQueue.global(qos: .userInitiated).async {
                self.session.startRunning()
                DispatchQueue.main.async { self.isCameraReady = true }
            }
        } catch {
            print("Error setting up camera: \(error)")
        }
    }
    
    func startSession() {
        DispatchQueue.global(qos: .background).async {
            if !self.session.isRunning { self.session.startRunning() }
        }
    }
    
    func stopSession() {
        DispatchQueue.global(qos: .background).async {
            if self.session.isRunning { self.session.stopRunning() }
        }
    }
    
    func capturePhoto(scanFrameSize: CGFloat, scanFrameOffset: CGSize) {
        self.scanFrameSize = scanFrameSize
        self.scanFrameOffset = scanFrameOffset
        
        let settings = AVCapturePhotoSettings()
        settings.flashMode = isFlashOn ? .on : .off
        settings.photoQualityPrioritization = .speed // ⚡️ Faster capture
        settings.isHighResolutionPhotoEnabled = false // ⚡️ Avoid unnecessary processing
        
        output.capturePhoto(with: settings, delegate: self)
    }
    
    func toggleFlash() {
        isFlashOn.toggle()
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let imageData = photo.fileDataRepresentation(), let image = UIImage(data: imageData) else {
            print("Error capturing photo: \(error?.localizedDescription ?? "Unknown error while capturing")")
            return
        }
        
        stopSession()
        
        DispatchQueue.global(qos: .userInitiated).async {
            let croppedImage = self.cropCapturedImage(
                originalImage: image,
                scanFrameSize: self.scanFrameSize,
                scanFrameOffset: self.scanFrameOffset,
                previewSize: UIScreen.main.bounds.size
            )
            
            DispatchQueue.main.async {
                self.capturedImage = croppedImage
            }
        }
    }
    
    func cropCapturedImage(originalImage: UIImage, scanFrameSize: CGFloat, scanFrameOffset: CGSize, previewSize: CGSize) -> UIImage? {
        guard let cgImage = originalImage.cgImage else { return nil }
        
        let imageSize = CGSize(width: cgImage.width, height: cgImage.height)
        let scaleX = imageSize.width / previewSize.width
        let scaleY = imageSize.height / previewSize.height
        
        let cropRect = CGRect(
            x: (scanFrameOffset.width + (previewSize.width - scanFrameSize) / 2) * scaleX,
            y: (scanFrameOffset.height + (previewSize.height - scanFrameSize * 1.5) / 2) * scaleY,
            width: scanFrameSize * scaleX,
            height: scanFrameSize * 1.5 * scaleY
        )
        
        let validCropRect = cropRect.intersection(CGRect(origin: .zero, size: imageSize))
        guard let croppedCGImage = cgImage.cropping(to: validCropRect) else { return nil }
        
        return UIImage(cgImage: croppedCGImage, scale: originalImage.scale, orientation: originalImage.imageOrientation)
    }
}
