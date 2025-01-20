//
//  FinishStep.swift
//  Passport Photo Maker App
//
//  Created by Lukman Makhaev on 11.12.2024.
//

import SwiftUI
import Photos

struct FinishStep: View {
    @EnvironmentObject var viewModel: MainViewModel
    @EnvironmentObject var subscriptionManager: ApphudSubsManager
    @State private var isShowingShareSheet = false
    @State var isSubsPresented = false
    var body: some View {
        VStack (spacing: 0){
            ProgressIndicator(currentStep: $viewModel.currentStep)
                .padding(.horizontal)
                .padding(.top, 26)
            
            Spacer()
            
            Button(action: {
                viewModel.startOver()
            }) {
                HStack (spacing: 5) {
                    
                    Text("Start over")
                        .foregroundColor(.black)
                        .bold()
                    
                    Image("refresh")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                    
                }
                .frame(width: 145, height: 46)
                .background(.accent)
                .cornerRadius(30)
            }
            .padding(.vertical, 20)
            
            Spacer()
            
            if let image = viewModel.croppedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: 350)
                    .padding(.horizontal, 50)
                    .shadow(color: .black.opacity(0.16), radius: 2, x: 2, y: 0)
            }
            
            Spacer()
            
            HStack (spacing: 0) {
                Text("Your photo is ready!")
                    .foregroundStyle(.white)
                
                Image("success")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .scaledToFit()
                    .padding(.leading, 15)
            }
            .padding(9)
            .padding(.horizontal, 5)
            .background(.green)
            .cornerRadius(30)
            .padding(.vertical, 20)
            
            Spacer()
            
            HStack (spacing: 15) {
                
                Button(action: {
                    if !subscriptionManager.hasSubscription {
                        isSubsPresented = true
                    } else {
                        isShowingShareSheet = true
                    }
                }) {
                    Text("Export")
                        .bold()
                        .frame(height: 46)
                        .frame(maxWidth: .infinity)
                        .background(.darkAccent)
                        .foregroundColor(.black)
                        .cornerRadius(25)
                    
                }
                .sheet(isPresented: $isShowingShareSheet) {
                    if let croppedImage = viewModel.croppedImage,
                       let resizedImage = croppedImage.resized(toMMWidth: 40, heightMM: 45, dpi: 600) {
                        ShareSheet(activityItems: [resizedImage], excludedActivityTypes: [.print])
                    }
                }
                
                Button(action: {
                    if !subscriptionManager.hasSubscription {
                        isSubsPresented = true
                    } else {
                        if let croppedImage = viewModel.croppedImage {
                            printImage(croppedImage, widthMM: CGFloat(viewModel.selectedDocument.details.photoWidth), heightMM: CGFloat(viewModel.selectedDocument.details.photoHeight), dpi: 600)
                        }
                    }
                
                }) {
                    Text("Print")
                        .bold()
                        .frame(height: 46)
                        .frame(maxWidth: .infinity)
                        .background(.accent)
                        .foregroundColor(.black)
                        .cornerRadius(25)
                    
                }
                .sheet(isPresented: $isShowingShareSheet) {
                    if let croppedImage = viewModel.croppedImage,
                       let resizedImage = croppedImage.resized(toMMWidth: 40, heightMM: 45, dpi: 600) {
                        ShareSheet(activityItems: [resizedImage], excludedActivityTypes: [.print])
                        .presentationDetents([.medium, .large])                    }
                }
            }
            .padding(.horizontal, 35)
            .padding(.bottom, 25)
        }
        .sheet(isPresented: $isSubsPresented) {
            PaywallView(paywallId: ApphudPaywallIds.inapp.rawValue)
                .presentationDetents([.height(768)])
                .presentationCornerRadius(30)
                .environmentObject(subscriptionManager)
        }
        .onChange(of: subscriptionManager.hasSubscription, { oldValue, newValue in
            isSubsPresented = false
        })
        .frame(maxHeight: .infinity)
        .background(viewModel.gradient)
    }
    
    private func printImage(_ image: UIImage, widthMM: CGFloat, heightMM: CGFloat, dpi: CGFloat) {
      
        guard let resizedImage = image.resized(toMMWidth: widthMM, heightMM: heightMM, dpi: dpi),
              let imageData = resizedImage.pngData() else {
            print("Failed to resize or get image data")
            return
        }


        let printInfo = UIPrintInfo(dictionary: nil)
        printInfo.jobName = "Print Image"
        printInfo.outputType = .photo

        let printController = UIPrintInteractionController.shared
        printController.printInfo = printInfo

       
        printController.printingItem = imageData

       
        printController.present(animated: true) { (controller, completed, error) in
            if let error = error {
                print("Printing failed: \(error.localizedDescription)")
            } else if completed {
                print("Printing completed successfully")
            } else {
                print("Printing canceled")
            }
        }
    }
}

#Preview {
    FinishStep()
        .environmentObject(MainViewModel())
}

struct ShareSheet: UIViewControllerRepresentable {
    let activityItems: [Any]
    let excludedActivityTypes: [UIActivity.ActivityType]?

    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        controller.excludedActivityTypes = excludedActivityTypes
        return controller
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

extension UIImage {
    func resized(toMMWidth widthMM: CGFloat, heightMM: CGFloat, dpi: CGFloat) -> UIImage? {
       
        let widthPixels = (widthMM / 25.4) * dpi
        let heightPixels = (heightMM / 25.4) * dpi
        
    
        let newSize = CGSize(width: widthPixels, height: heightPixels)
        
    
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: CGRect(origin: .zero, size: newSize))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resizedImage
    }
}
