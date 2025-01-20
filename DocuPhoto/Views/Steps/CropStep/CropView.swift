//
//  CropView.swift
//  Passport Photo Maker App
//
//  Created by Lukman Makhaev on 14.12.2024.
//

import Foundation
import SwiftUI

struct CropView: View {
    @EnvironmentObject var viewModel: MainViewModel
    
    @State private var scale: CGFloat = 1
    @State private var lastScale: CGFloat = 0
    @State private var offset: CGSize = .zero
    @State private var lastStoredOffset : CGSize = .zero
    @GestureState private var isInteracting: Bool = false
    
    @Binding var topOffset: CGFloat
    @Binding var bottomOffset: CGFloat
    
    var onCrop: (UIImage?, Bool) -> ()
    
    var body: some View {
        VStack (spacing: 0) {
            ImageView()
                .background(viewModel.selectedDocument.details.backgroundColor)
                .padding(.vertical, 13)
            
            Spacer()
            
            Button(action: {
                viewModel.showingTemplatePopup.toggle()
            }) {
                HStack {
                    Text("Selected Template: \(Int(viewModel.selectedDocument.details.photoWidth)) x \(Int(viewModel.selectedDocument.details.photoHeight))")
                        .font(.system(size: 14))
                    
                    Image("arrow")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 12, height: 12)
                }
                .padding(10)
                .padding(.horizontal, 11)
                .background(Color(.systemGray5))
                .foregroundStyle(.gray)
                .cornerRadius(30)
            }
            
            Spacer()
            
            Text(verbatim: "\(Int(viewModel.cropWheelValue - 50))")
                .contentTransition(.numericText(value: Double(viewModel.cropWheelValue)))
                .animation(.snappy, value: viewModel.cropWheelValue)
                .frame(height: 32)
                .frame(minWidth: 30)
                .frame(maxWidth: 24)
                .padding(7)
                .bold()
                .background(.accent)
                .foregroundStyle(.black)
                .cornerRadius(25)
            
            WheelPicker2(count: $viewModel.cropWheelValue, from: 0, to: 100, steps: 5, style: .styleOne)
            
            
            Spacer()
            
            HStack {
                Button(action: {
                    viewModel.showingCropTutorial.toggle()
                }, label: {
                    Image("question-circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding(12)
                        .background(Circle().foregroundStyle(.accent))
                })
                .padding(.leading, 20)
                .sheet(isPresented: $viewModel.showingCropTutorial) {
                    CropTutorialView()
                        .presentationDetents([.height(812)])
                        .presentationCornerRadius(30)
                }
                
                
                
                
                Button(action: {
                    let renderer = ImageRenderer(content: ImageView(true))
                    renderer.scale = UIScreen.main.scale
                    renderer.proposedSize = .init(viewModel.cropSize)
                    if let image = renderer.uiImage {
                        onCrop(image, true)
                    } else {
                        onCrop(nil, false)
                    }
                    
                }) {
                    Text("Next Step")
                        .bold()
                        .frame(width: 165, height: 46)
                        .background(.accent)
                        .foregroundColor(.black)
                        .cornerRadius(25)
                    
                }
                .frame(maxWidth: .infinity)
                
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
            .onAppear {
                print(viewModel.cropSize)
            }
        }
    }
    
    @ViewBuilder
    func ImageView(_ hideGrids: Bool = false) -> some View {
        
        GeometryReader {
            let size = $0.size
            
            if let image = viewModel.selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .rotationEffect(.degrees(Double(viewModel.cropWheelValue - 50)))
                    .background(viewModel.selectedDocument.details.backgroundColor)
                    .overlay(content: {
                        GeometryReader { proxy in
                            let rect = proxy.frame(in: .named("CROPVIEW"))
                            
                            Color.clear
                                .onChange(of: isInteracting) { oldValue, newValue in
                                    withAnimation(.easeInOut(duration: 0.2)) {
                                        if rect.minX > 0 {
                                            offset.width = (offset.width - rect.minX)
                                            haptics(.medium)
                                        }
                                        if rect.minY > 0 {
                                            offset.height = (offset.height - rect.minY)
                                            haptics(.medium)
                                        }
                                        
                                        
                                        if rect.maxX < size.width {
                                            offset.width = (rect.minX - offset.width)
                                            haptics(.medium)
                                        }
                                        if rect.maxY < size.height {
                                            offset.height = (rect.minY - offset.height)
                                            haptics(.medium)
                                        }
                                    }
                                    
                                    if !newValue {
                                        lastStoredOffset = offset
                                    }
                                }
                        }
                    })
                    .frame(size)
                    .onChange(of: isInteracting) { oldValue, newValue in
                        if !newValue {
                            lastStoredOffset = offset
                        }
                    }
            }
        }
        .scaleEffect(scale)
        .offset(offset)
        .overlay(content: {
            if !hideGrids {
                Grids()
            }
        })
        .coordinateSpace(name: "CROPVIEW")
        .gesture(
            DragGesture()
                .updating($isInteracting, body: { _, out, _ in
                    out = true
                }).onChanged({ value in
                    let translation = value.translation
                    offset = CGSize(width: translation.width + lastStoredOffset.width, height: translation.height + lastStoredOffset.height)
                })
        )
        .gesture(
            MagnificationGesture()
                .updating($isInteracting, body: { _, out, _ in
                    out = true
                }).onChanged({ value in
                    let updatedScale = value + lastScale
                    
                    scale = (updatedScale < 1 ? 1 : updatedScale)
                }).onEnded({ value in
                    withAnimation(.easeOut(duration: 0.2)) {
                        if scale < 1 {
                            scale = 1
                            lastScale = 0
                        } else {
                            lastScale = scale - 1
                        }
                    }
                })
        )
        .frame(width: viewModel.cropSize.width, height: viewModel.cropSize.height)
        .cornerRadius(0)
        .animation(.easeInOut(duration: 0.3), value: viewModel.cropSize)
        .overlay(content: {
            if !hideGrids {
                ZStack {
                    RoundedRectangle(cornerRadius: 0)
                        .stroke(Color.accentColor, lineWidth: 2)
                    
                    GeometryReader { geometry in
                        let width = geometry.size.width
                        let height = geometry.size.height
                        
                        
                        CropGuideElement(isVertical: false)
                            .position(x: width / 2, y: 0)
                        
                        
                        CropGuideElement(isVertical: false)
                            .position(x: width / 2, y: height)
                        
                        
                        CropGuideElement(isVertical: true)
                            .position(x: 0, y: height / 2)
                        
                        
                        CropGuideElement(isVertical: true)
                            .position(x: width, y: height / 2)
                    }
                }
                .frame(width: viewModel.cropSize.width)
                .animation(.easeInOut(duration: 0.3), value: viewModel.cropSize)
            }
        })
    }
    
    @ViewBuilder
    func Grids() -> some View {
        ZStack {
            
            let totalWidth = viewModel.cropSize.width * 0.9
            let totalHeight = viewModel.cropSize.height * 0.6
            let lineSize: CGFloat = 7
            let spacing: CGFloat = 7
            let verticalLineNumber = Int((totalWidth + spacing) / (lineSize + spacing))
            let horizontalLineNumber = Int((totalHeight + spacing) / (lineSize + spacing))
      
            HStack(spacing: spacing) {
                ForEach(0..<horizontalLineNumber.makeEven(), id: \.self) { _ in
                    Rectangle()
                        .fill(.accent)
                        .frame(width: lineSize, height: 1)
                }
            }
            .frame(width: totalWidth)
            
            
            VStack(spacing: spacing) {
                ForEach(0..<verticalLineNumber.makeEven(), id: \.self) { _ in
                    Rectangle()
                        .fill(.accent)
                        .frame(width: 1, height: lineSize)
                }
            }
            .frame(width: totalWidth)
            
            
            VStack {
                CurvedLine()
                    .stroke(Color.accentColor, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                    .frame(width: 47, height: 3)
                    .padding(.top, viewModel.topOffset)

       
                Spacer()
            
                
                CurvedLine()
                    .stroke(Color.accentColor, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                    .frame(width: 47, height: 3)
                    .rotationEffect(.degrees(180))
                    .padding(.bottom, viewModel.bottomOffset)

       
            }
            .frame(height: viewModel.cropSize.height)
        }
    }
}

#Preview {
    CropStep()
        .environmentObject(MainViewModel())
}


struct CurvedLine: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let startPoint = CGPoint(x: 0, y: rect.height / 2)
        let endPoint = CGPoint(x: rect.width, y: rect.height / 2)
        let controlPoint1 = CGPoint(x: rect.width / 3, y: rect.height / 2 - 7)
        let controlPoint2 = CGPoint(x: rect.width * 2 / 3, y: rect.height / 2 - 7)
        
        path.move(to: startPoint)
        path.addCurve(to: endPoint, control1: controlPoint1, control2: controlPoint2)
        
        return path
    }
}
