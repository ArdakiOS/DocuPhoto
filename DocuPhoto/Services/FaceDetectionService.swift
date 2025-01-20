//
//  FaceDetectionService.swift
//  Passport Photo Maker App
//
//  Created by Lukman Makhaev on 18.12.2024.
//

import UIKit
import Vision

final class FaceDetectionService {
    /// Detects if any faces are present in the given image.
    /// - Parameters:
    ///   - image: The image to be analyzed.
    ///   - completion: Completion handler returning a Bool indicating if faces were found.
    func detectFaces(in image: UIImage, completion: @escaping (Bool) -> Void) {
        guard let cgImage = image.cgImage else {
            completion(false)
            return
        }
        
        // Create a face detection request
        let request = VNDetectFaceRectanglesRequest { request, error in
            if let error = error {
                print("Face Detection Error: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            // Check if any faces were detected
            if let results = request.results as? [VNFaceObservation], !results.isEmpty {
                completion(true)
            } else {
                completion(false)
            }
        }
        
        // Perform the request
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                try handler.perform([request])
            } catch {
                print("Failed to perform face detection: \(error.localizedDescription)")
                completion(false)
            }
        }
    }
    
    func detectFrontalFace(in image: UIImage, completion: @escaping (Bool) -> Void) {
        guard let cgImage = image.cgImage else {
            completion(false)
            return
        }

        // Create a face detection request with landmark tracking
        let request = VNDetectFaceRectanglesRequest { request, error in
            if let error = error {
                print("Face Detection Error: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            guard let results = request.results as? [VNFaceObservation], !results.isEmpty else {
                completion(false)
                return
            }

            // Check each detected face for "straightness"
            for face in results {
                if let yaw = face.yaw?.doubleValue, let roll = face.roll?.doubleValue {
                    // Threshold for detecting frontal face
                    if abs(yaw) < 0.1 && abs(roll) < 0.1 {
                        completion(true)
                        return
                    }
                }
            }

            completion(false) // No frontal face detected
        }

        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                try handler.perform([request])
            } catch {
                print("Failed to perform face detection: \(error.localizedDescription)")
                completion(false)
            }
        }
    }
    
    func detectFrontalFaceAndEyeGaze(in image: UIImage, completion: @escaping (Bool) -> Void) {
        guard let cgImage = image.cgImage else {
            completion(false)
            return
        }

        // Request to detect face landmarks
        let request = VNDetectFaceLandmarksRequest { request, error in
            if let error = error {
                print("Face Landmark Detection Error: \(error.localizedDescription)")
                completion(false)
                return
            }

            guard let results = request.results as? [VNFaceObservation] else {
                completion(false)
                return
            }

            // Analyze each detected face
            for face in results {
                if self.isFaceFrontal(face),
                   let landmarks = face.landmarks,
                   let leftPupil = landmarks.leftPupil,
                   let rightPupil = landmarks.rightPupil {
                    if self.arePupilsCentered(face: face, leftPupil: leftPupil, rightPupil: rightPupil) {
                        completion(true)
                        return
                    }
                }
            }
            completion(false) // No valid face with centered pupils found
        }

        performVisionRequest(request, with: cgImage)
    }

    /// Determines if the face is looking straight (frontal) based on yaw and roll.
    private func isFaceFrontal(_ face: VNFaceObservation) -> Bool {
        guard let yaw = face.yaw?.doubleValue, let roll = face.roll?.doubleValue else { return false }
        return abs(yaw) < 0.1 && abs(roll) < 0.1
    }

    /// Checks if pupils are centered and symmetrical within the bounding box of the face.
    private func arePupilsCentered(face: VNFaceObservation, leftPupil: VNFaceLandmarkRegion2D, rightPupil: VNFaceLandmarkRegion2D) -> Bool {
        // Face bounding box size
        _ = face.boundingBox

        // Calculate normalized x-positions of the pupils
        let leftPupilX = leftPupil.normalizedPoints.map { $0.x }.average
        let rightPupilX = rightPupil.normalizedPoints.map { $0.x }.average

        // Pupils should be near the horizontal center of the face
        let pupilCenterThreshold: CGFloat = 0.2 // Adjust based on testing
        let faceCenterX: CGFloat = 0.5

        let leftPupilDistance = abs(leftPupilX - faceCenterX)
        let rightPupilDistance = abs(rightPupilX - faceCenterX)

        // Check if both pupils are close to the horizontal center
        return leftPupilDistance < pupilCenterThreshold && rightPupilDistance < pupilCenterThreshold
    }

    /// Helper function to perform Vision requests.
    private func performVisionRequest(_ request: VNRequest, with cgImage: CGImage) {
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                try handler.perform([request])
            } catch {
                print("Vision Request Error: \(error.localizedDescription)")
            }
        }
    }
}

extension Collection where Element == CGFloat {
    var average: CGFloat {
        return isEmpty ? 0 : reduce(0, +) / CGFloat(count)
    }
}
