//
//  ImportPhotoStep.swift
//  Passport Photo Maker App
//
//  Created by Lukman Makhaev on 09.12.2024.
//

import SwiftUI
import PhotosUI
import Vision

struct ImportPhotoStep: View {
    @EnvironmentObject var viewModel: MainViewModel
    @State var buttonAlignment: Alignment = .center
    @State private var isPresentingCamera = false
    
    @State private var photoPickerItem: PhotosPickerItem?
    
    @State private var isFilePickerPresented: Bool = false

    
    var body: some View {
        ZStack {
            VStack (spacing: 0) {
                
                ProgressIndicator(currentStep: $viewModel.currentStep)
                    .padding(.horizontal)
                    .padding(.top, 26)
                
                Button(action: {
                    viewModel.showingInstructions.toggle()
                }, label: {
                    
                    HStack {
                        
                        Text("Instruction")
                            .foregroundStyle(Color(.systemGray2))
                        
                        Image("info-circle")
                            .resizable()
                            .frame(width: 16, height: 16)
                    }
                    .padding(9)
                    .padding(.horizontal, 5)
                    .background(Color(.systemGray5))
                    .cornerRadius(30)
                    .padding(.top, 20)
                })
                .sheet(isPresented: $viewModel.showingInstructions) {
                    InstructionsView()
                        .presentationDetents([.height(812)])
                        .presentationCornerRadius(30)
                }
                
                Text("Import Photo")
                    .font(.system(size: 24))
                    .foregroundColor(.black)
                    .bold()
                    .padding(.top, (viewModel.selectedImage != nil) ? 25 : 90)
                
                if let image = viewModel.selectedImage {
                    ZStack (alignment: .topTrailing) {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.black.opacity(0.5), lineWidth: 2) // Add stroke with color and width
                            )
                        
                        Button(action: {
                            viewModel.selectedImage = nil
                        }, label: {
                            Image(systemName:"xmark.circle.fill")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundStyle(.black.opacity(0.5))
                        })
                        .padding(8)
                        
                    }
                    .cornerRadius(16)
                    .frame(maxHeight: 370)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 12)
                    .padding(.top, 20)
                    
                } else {
                    VStack (spacing: 10) {
                        PhotosPicker(selection: $photoPickerItem, label: {
                            ImportButtonLabel(image: "gallery-add", text: "Select from Gallery")
                                .shadow(color: .primary.opacity(0.09), radius: 4, x: 0, y: 4)
                        })
                        .onChange(of: photoPickerItem) { oldValue, newValue in
                            Task {
                                if let data = try? await newValue?.loadTransferable(type: Data.self),
                                   let uiImage = UIImage(data: data) {
                                    viewModel.checkForFaces(in: uiImage) { hasFaces in
                                        if hasFaces {
                                            viewModel.selectedImage = uiImage
                                        } else {
                                            // Show an alert or other UI feedback
                                            viewModel.showAlert = true
                                            print("No faces detected in the selected photo.")
                                        }
                                    }
                                }
                            }
                        }
                        
                        
                        Button(action: {
                            
                            isFilePickerPresented = true
                            
                        }, label: {
                            ImportButtonLabel(image: "folder-add", text: "Select from Files")
                                .shadow(color: .primary.opacity(0.09), radius: 4, x: 0, y: 4)
                        })
                        .sheet(isPresented: $isFilePickerPresented) {
                            FIlePicker { img in
                                if let selectedImage = img {
                                    viewModel.checkForFaces(in: selectedImage) { hasFaces in
                                        if hasFaces {
                                            viewModel.selectedImage = selectedImage
                                        } else {
                                            // Show an alert or other UI feedback
                                            viewModel.showAlert = true
                                            print("No faces detected in the selected photo.")
                                        }
                                    }
                                }
                            }
                        }
                        
                        Button(action: {
                            isPresentingCamera = true
                        }, label: {
                            ImportButtonLabel(image: "camera", text: "Make a Photo")
                                .shadow(color: .primary.opacity(0.09), radius: 4, x: 0, y: 4)
                        })
                        .fullScreenCover(isPresented: $isPresentingCamera) {
                            ZStack{
                                ImagePicker(selectedImage: $viewModel.selectedImage) { image in
                                    viewModel.checkForFaces(in: image) { hasFaces in
                                        if hasFaces {
                                            viewModel.selectedImage = image
                                        } else {
                                            viewModel.showAlert = true
                                            print("No faces detected in the photo taken.")
                                            // Optionally, show an alert or feedback to the user here
                                        }
                                    }
                                }
                                Image(.kontur)
                                    .resizable()
                                    .scaledToFit()
                                
                            }
                            .background(.black)
                        }
                    }
                    .frame(width: 195)
                    .foregroundStyle(.primary)
                    .padding(.top, 40)
                }
                
                Spacer()
                
                if viewModel.isLoading {
                    ProgressView("Removing background...")
                        .padding()
                } else if viewModel.selectedImage != nil {
                    Button(action: {
                        Task {
                            await viewModel.removeBg()
                        }
                    }) {
                        Text("Remove Background")
                            .font(.system(size: 14))
                            .foregroundStyle(Color(hex: "#A9A9A9"))
                            .fontWeight(.medium)
                            .padding(9)
                            .padding(.horizontal, 44)
                            .background(Color(hex: "#E2E2E2"))
                            .cornerRadius(30)
                    }
                    .foregroundStyle(.primary)
                    .padding(.vertical, 20)
                }
                
                //            Text(viewModel.hasFaces ? "Faces Detected ✅" : "No Faces Detected ❌")
                //                .font(.headline)
                //            Text(viewModel.isFaceFrontal ? "Face Looking Straight ✅" : "Face Not Straight ❌")
                //                .font(.headline)
                //            Text(viewModel.isLookingAtCamera ? "Looking at Camera ✅" : "Not Looking at Camera ❌")
                //                .font(.headline)
                
                HStack {
                    
                    if viewModel.selectedImage != nil {
                        
                        Button(action: {}, label: {
                            Image("question-circle")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .padding(12)
                                .background(Circle().foregroundStyle(.accent))
                        })
                        .padding(.leading, 20)
                        .disabled(viewModel.currentStep >= 3 ? true : false)
                        .opacity(viewModel.currentStep >= 3 ? 1 : 0)
                        
                        
                        Button(action: {
                            viewModel.currentStep += 1
                        }) {
                            Text("Next Step")
                                .bold()
                                .frame(width: 165, height: 46)
                                .background(.accent)
                                .foregroundColor(.black)
                                .cornerRadius(25)
                            
                        }
                        .frame(maxWidth: .infinity)
                    }
                    
                    Button(action: {
                        viewModel.showingSettings = true
                    }, label: {
                        Image("settings")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .padding(12)
                            .background(Circle().foregroundStyle(.accent))
                    })
                    .padding(.trailing, 20)
                    
                }
                .padding(.bottom, 25)
                
            }
            .frame(maxHeight: .infinity)
            
            CustomAlert(showAlert: $viewModel.showAlert, content: {
                ZStack {
                    VStack (spacing: 20) {
                        Text("The photo is not suitable for documents. Upload a photo with a frontal face position")
                            .font(.system(size: 14))
                            .fontWeight(.medium)
                        
                        Button(action: {
                            viewModel.showAlert = false
                
                        }, label: {
                            Text("OK")
                                .frame(height: 46)
                                .frame(maxWidth: .infinity)
                                .background(.accent)
                                .foregroundColor(.black)
                                .cornerRadius(25)
                                .padding(.horizontal, 66)
                        })
                    }
                    .padding()
                    .background(.white)
                    .cornerRadius(24)
                    .padding(20)
                }
            })
        }
        .background(viewModel.gradient)
        .animation(.easeInOut, value: viewModel.showAlert)
    }
}

#Preview {
    ImportPhotoStep()
        .environmentObject(MainViewModel())
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    var onFaceCheck: ((UIImage) -> Void)?
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        
        init(parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[.originalImage] as? UIImage {
                // Check for faces before assigning the image
                parent.onFaceCheck?(image)
            }
            picker.dismiss(animated: true)
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = context.coordinator
        picker.cameraCaptureMode = .photo
        picker.cameraDevice = .rear
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}
