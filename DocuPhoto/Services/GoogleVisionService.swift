//
//  GoogleVisionService.swift
//  Passport Photo Maker App
//
//  Created by Lukman Makhaev on 18.12.2024.
//

import Foundation
import UIKit

struct FaceDetectionResult {
    let isFrontal: Bool
    let eyesLookingStraight: Bool
}

final class GoogleVisionService {
    private let apiKey = "AIzaSyC-jTL4CfQ8IJggysfiJyenbHVZwPXi2bI"
    private let endpoint = "https://vision.googleapis.com/v1/images:annotate"

    /// Detects facial attributes (frontal face and eye gaze) using Google Vision API
    func detectFaceAttributes(image: UIImage, completion: @escaping (FaceDetectionResult?) -> Void) {
        guard let base64Image = image.toBase64() else {
            completion(nil)
            return
        }
        
        let requestPayload: [String: Any] = [
            "requests": [
                [
                    "image": ["content": base64Image],
                    "features": [["type": "FACE_DETECTION"]]
                ]
            ]
        ]
        
        // Prepare HTTP request
        guard let url = URL(string: "\(endpoint)?key=\(apiKey)") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: requestPayload)

        // Perform API call
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
                return
            }
            
            do {
                let result = try JSONDecoder().decode(GoogleVisionResponse.self, from: data)
                let isFrontal = self.isFaceFrontal(result: result)
                let eyesLookingStraight = self.areEyesLookingStraight(result: result)
                
                let detectionResult = FaceDetectionResult(isFrontal: isFrontal, eyesLookingStraight: eyesLookingStraight)
                completion(detectionResult)
            } catch {
                print("JSON Parsing Error: \(error.localizedDescription)")
                completion(nil)
            }
        }.resume()
    }
    
    /// Determines if the face is frontal based on headEulerAngle
    private func isFaceFrontal(result: GoogleVisionResponse) -> Bool {
        guard let face = result.responses.first?.faceAnnotations?.first else { return false }
        return abs(face.panAngle ?? 0) < 10 && abs(face.rollAngle ?? 0) < 10
    }

    private func areEyesLookingStraight(result: GoogleVisionResponse) -> Bool {
        guard let face = result.responses.first?.faceAnnotations?.first else { return false }
        
        let leftEye = face.landmarks?.first { $0.type == "LEFT_EYE" }
        let rightEye = face.landmarks?.first { $0.type == "RIGHT_EYE" }

        if let leftY = leftEye?.position.y, let rightY = rightEye?.position.y {
            return abs(leftY - rightY) < 10
        }
        return false
    }
}

// MARK: - Google Vision API Response Structures
struct GoogleVisionResponse: Codable {
    let responses: [FaceAnnotationsResponse]
}

struct FaceAnnotationsResponse: Codable {
    let faceAnnotations: [FaceAnnotation]?
}

struct FaceAnnotation: Codable {
    let panAngle: Double? // Yaw: left-right
    let rollAngle: Double? // Roll: tilt
    let landmarks: [Landmark]?
}

struct Landmark: Codable {
    let type: String
    let position: LandmarkPosition
}

struct LandmarkPosition: Codable {
    let x: Double
    let y: Double
    let z: Double
}

// MARK: - UIImage Extension
extension UIImage {
    func toBase64() -> String? {
        return self.jpegData(compressionQuality: 0.8)?.base64EncodedString()
    }
}
