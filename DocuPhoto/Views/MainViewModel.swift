//
//  MainViewModel.swift
//  Passport Photo Maker App
//
//  Created by Lukman Makhaev on 09.12.2024.
//

import Foundation
import SwiftUI
import UIKit
import Vision
import CoreImage
import CoreImage.CIFilterBuiltins



final class MainViewModel: ObservableObject {
    let gradient = LinearGradient(colors: [.background1, .background2], startPoint: .top, endPoint: .bottom)
    
    @Published var errorMessage: String?
    @Published var currentStep = 1
    
    // MARK: - Import Step Properties
    @Published var isLoading: Bool = false
    @Published var selectedImage: UIImage? = nil
    
    @Published var hasFaces: Bool = false
//    @Published var isFaceFrontal: Bool = false
//    @Published var isLookingAtCamera: Bool = false
    
    @Published var showAlert: Bool = false
    

    @Published var showingSettings = false
    private let faceDetectionService = FaceDetectionService()
    
    // MARK: - Edit Step Properties
    @Published var editedImage: UIImage? = nil
    
    // MARK: - Crop Step Properties
    let availableWidth = UIScreen.main.bounds.width - 40
    
    @Published var cropSize: CGSize = CGSize(width: 350, height: 450)
    @Published var cropWheelValue: Int = 0
    @Published var topOffset: CGFloat = 70
    @Published var bottomOffset: CGFloat = 70

    @Published var showingCropTutorial = false
    @Published var showingInstructions = false
    @Published var showingEditTemplate = false
    @Published var showingTemplatePopup = false
    
    @Published var countries: [Country] = DocumentDataProvider.countries
    @Published var selectedCountry: Country = Country(name: "Afghanistan", flag: "🇦🇫", documentTypes: [
        DocumentType(type: .passport, details: DocumentDetails(photoWidth: 40, photoHeight: 45, backgroundColor: .white, dpi: 600)),
        DocumentType(type: .visa, details: DocumentDetails(photoWidth: 35, photoHeight: 45, backgroundColor: .white, dpi: 600))
    ])
    @Published var selectedDocument: DocumentType = DocumentType(type: .passport, details: DocumentDetails(photoWidth: 40, photoHeight: 45, backgroundColor: .white, dpi: 600))
    
    // MARK: - Finish Step Properties
    @Published var croppedImage: UIImage? = nil
    
    
    init() {
        updateCropSize(typeDetails: selectedDocument.details)
    }
    
    // MARK: - Import Step Functions
    
//    func checkIfLookingAtCamera(in image: UIImage) {
//         faceDetectionService.detectFrontalFaceAndEyeGaze(in: image) { [weak self] result in
//             DispatchQueue.main.async {
//                 self?.isLookingAtCamera = result
//             }
//         }
//     }
//    
//    func checkForFrontalFace(in image: UIImage) {
//        faceDetectionService.detectFrontalFace(in: image) { [weak self] result in
//            DispatchQueue.main.async {
//                self?.isFaceFrontal = result
//            }
//        }
//    }
    
    func checkForFaces(in image: UIImage, completion: @escaping (Bool) -> Void) {
        faceDetectionService.detectFaces(in: image) { [weak self] result in
            DispatchQueue.main.async {
                self?.hasFaces = result
                completion(result)
            }
        }
    }
    
    @MainActor
    func removeBg() async {
        isLoading = true
        guard let image = selectedImage,
              let inputImage = CIImage(image: image) else {
            print("Failed to create CIImage or no selected image")
            return
        }

        let originalOrientation = image.imageOrientation // Capture the original orientation
        
        do {
            // Perform background task for mask creation (with try await)
            let maskImage = try await createMask(from: inputImage)
            
            // Apply mask and generate final output.
            guard let outputImage = applyMask(mask: maskImage, to: inputImage),
                  let finalImage = convertToUIImage(ciImage: outputImage, originalOrientation: originalOrientation) else {
                print("Failed to process image")
                return
            }
            
            // Update UI (since we are already on MainActor).
            selectedImage = finalImage
            isLoading = false
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    private func createMask(from inputImage: CIImage) async throws -> CIImage {
        let request = VNGenerateForegroundInstanceMaskRequest()
        let handler = VNImageRequestHandler(ciImage: inputImage)
        
        try handler.perform([request])
        
        guard let result = request.results?.first else {
            throw NSError(domain: "MaskCreationError", code: 1, userInfo: [NSLocalizedDescriptionKey: "No mask result found."])
        }
        
        let mask = try result.generateScaledMaskForImage(forInstances: result.allInstances, from: handler)
        return CIImage(cvPixelBuffer: mask)
    }
    
    private func applyMask(mask: CIImage, to image: CIImage) -> CIImage? {
        let filter = CIFilter.blendWithMask()
        filter.inputImage = image
        filter.maskImage = mask
        filter.backgroundImage = CIImage.empty()
        return filter.outputImage
    }
    
    private func convertToUIImage(ciImage: CIImage, originalOrientation: UIImage.Orientation) -> UIImage? {
        guard let cgImage = CIContext().createCGImage(ciImage, from: ciImage.extent) else { return nil }
        return UIImage(cgImage: cgImage, scale: 1.0, orientation: originalOrientation)
    }
    
    // MARK: - Crop Step Functions
    
    func selectCountry(country: Country) {
        selectedCountry = country
        selectedDocument = country.documentTypes[0]
        selectDocument(document: selectedDocument)
    }
    func selectDocument(document: DocumentType) {
        selectedDocument = document
        updateCropSize(typeDetails: document.details)
    }
    func updateCropSize(typeDetails: DocumentDetails) {
        cropSize = calculateCropSize(availableWidth: availableWidth, maxHeight: 290, targetWidth: CGFloat(typeDetails.photoWidth), targetHeight: CGFloat(typeDetails.photoHeight))
    }
    private func calculateCropSize(availableWidth: CGFloat, maxHeight: CGFloat, targetWidth: CGFloat = 50, targetHeight: CGFloat = 60) -> CGSize {
        let aspectRatio = targetWidth / targetHeight
        var width = availableWidth
        var height = width / aspectRatio
    
        if height > maxHeight {
            height = maxHeight
            width = height * aspectRatio
        }
        return CGSize(width: width, height: height)
    }
    
    // MARK: - Finish Step Functions
    func startOver() {
        currentStep = 1
        selectedImage = nil
        editedImage = nil
        croppedImage = nil
        cropWheelValue = 0
        topOffset = 70
        bottomOffset = 70
    }
}
