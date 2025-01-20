//
//  EditTemplateView.swift
//  Passport Photo Maker App
//
//  Created by Lukman Makhaev on 18.12.2024.
//

import SwiftUI

struct EditTemplateFaceRuler: View {
    
    @Binding var topLineOffset: CGFloat
    @Binding var bottomLineOffset: CGFloat
    
    @State var lastTopLineOffset: CGFloat = 0
    @State var lastBottomLineOffset: CGFloat = 0
    
    @State var eyesFramePosition: CGFloat = 80
    @State var lastEyesFramePosition: CGFloat = 80
    
    @Binding var frameWidth: CGFloat
    @Binding var  frameHeight: CGFloat
    @Binding var selectedLine: SelectedLine
    
    let headHeightRatio: CGFloat = 0.132

    var headHeight: CGFloat {
        return cropSize.height * headHeightRatio
    }
    
    let availableWidth = UIScreen.main.bounds.width - 180
    
    @Binding var cropSize: CGSize
    
    
    @Binding var topPerc: CGFloat
    @Binding var bottomPerc: CGFloat
    
    var body: some View {
        HStack {
            GeometryReader { geometry in
                let scale = computeScale(
                    topLine: topLineOffset,
                    bottomLine: bottomLineOffset,
                    frameHeight: cropSize.height,
                    headHeight: headHeight
                )
                
                ZStack {
                    let mmPerPoint = frameHeight / cropSize.height

                    // Top Circle
                    let topPercentage = (topLineOffset / cropSize.height) * 100
                    let topDistanceMM = topLineOffset * mmPerPoint

                    // Bottom Circle
                    let bottomPercentage = (bottomLineOffset / cropSize.height) * 100
                    let bottomDistanceMM = bottomLineOffset * mmPerPoint
                    
                    
             
                    ZStack {
                        Image(uiImage: UIImage(named: "man") ?? UIImage())
                            .resizable()
                            .scaledToFit()
                            .frame(width: cropSize.width, height: cropSize.height)
                            .animation(.easeInOut(duration: 0.3), value: cropSize)
                            .scaleEffect(scale, anchor: .top)
                            .offset(y: computeImageOffset(
                                scale: scale,
                                topLine: topLineOffset,
                                headHeight: 0
                            ))
                        
                        Image("eyesframe")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 105, height: 32)
                            .position(x: cropSize.width / 2, y: eyesFramePosition)
                            .gesture(
                                  DragGesture()
                                      .onChanged { value in
                                          let newPosition = lastEyesFramePosition + value.translation.height
                                          if newPosition >= topLineOffset + 16 && newPosition <= bottomLineOffset - 16 {
                                              eyesFramePosition = newPosition
                                          }
                                      }
                                      .onEnded { _ in
                                          lastEyesFramePosition = eyesFramePosition
    
                                      }
                              )
                            
                        
                        // Верхняя линия
                        ZStack {
                            if selectedLine == .head {
                                Path { path in
                                    path.move(to: CGPoint(x: 0, y: 0))
                                    path.addLine(to: CGPoint(x: cropSize.width, y: 0))
                                }
                                .stroke(style: StrokeStyle(lineWidth: 1, dash: [8, 4]))
                                .fill(.accent)
                                .frame(height: 1)
                            }
        
                            
                            CurvedLine()
                                .stroke(selectedLine == .head ? .accent : .black, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                                .frame(width: 47, height: 1)
                                .padding(.top, 13)
                                .padding(.trailing, 3)
                        }
                        .position(x: cropSize.width / 2, y: topLineOffset)
                        
                        // Нижняя линия
                        ZStack {
                            if selectedLine == .chin {
                                Path { path in
                                    path.move(to: CGPoint(x: 0, y: 0))
                                    path.addLine(to: CGPoint(x: cropSize.width, y: 0))
                                }
                                .stroke(style: StrokeStyle(lineWidth: 1, dash: [8, 4]))
                                .fill(.accent)
                                .frame(height: 1)
                            }
                                
                            CurvedLine()
                                .stroke(selectedLine == .chin ? .accent : .black, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                                .rotationEffect(.degrees(180))
                                .frame(width: 47, height: 1)
                                .padding(.bottom, 13)
                                .padding(.trailing, 1.5)
                        }
                        .position(x: cropSize.width / 2, y: bottomLineOffset)
                    }
                    .frame(width: cropSize.width, height: cropSize.height)
                    .animation(.easeInOut(duration: 0.3), value: cropSize)
                    .background(.black.opacity(0.02))
                    .clipped()
                    
                    
                    
                    if selectedLine == .head {
                        Image("slider")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .position(x: 1, y: topLineOffset)
                            .gesture(
                                DragGesture()
                                    .onChanged { value in
                                        let newOffset = lastTopLineOffset + value.translation.height
                                        if newOffset >= 0 && newOffset <= eyesFramePosition - 15 {
                                            topLineOffset = newOffset
                                        }
                                    }
                                    .onEnded { _ in
                                        lastTopLineOffset = topLineOffset
                                    }
                            )
                    }
                    
                    
             
                    Circle()
                        .fill(.accent)
                        .frame(width: 6, height: 6)
                        .position(x: cropSize.width + 23, y: topLineOffset)
                    
                    VStack {
                        Text("\(Int(topPercentage.isFinite ? topPercentage : 25))%")
                            .font(.system(size: 10))
                            .frame(maxWidth: .infinity, alignment: .leading)

                        Text("\(String(format: "%.1f", topDistanceMM))mm")
                            .font(.system(size: 10))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(5)
                    .background(.darkAccent)
                    .cornerRadius(7)
                    .frame(width: 52, alignment: .leading)
                    .position(x: cropSize.width + 23 + 45, y: topLineOffset)

                    
                    Path { path in
                        path.move(to: CGPoint(x: cropSize.width + 23, y: topLineOffset))
                        path.addLine(to: CGPoint(x: cropSize.width + 23, y: bottomLineOffset))
                    }
                    .stroke(Color.accentColor, lineWidth: 1)
                    

                    // Bottom circle
                    Circle()
                        .fill(.accent)
                        .frame(width: 6, height: 6)
                        .position(x: cropSize.width + 23, y: bottomLineOffset)
                    
                    if selectedLine == .chin {
                        
                        Image("slider")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .position(x: 1, y: bottomLineOffset)
                            .gesture(
                                DragGesture()
                                    .onChanged { value in
                                        let newOffset = lastBottomLineOffset + value.translation.height
                                        if newOffset >= eyesFramePosition + 15 && newOffset <= cropSize.height {
                                            bottomLineOffset = newOffset
                                        }
                                    }
                                    .onEnded { _ in
                                        lastBottomLineOffset = bottomLineOffset
                                    }
                            )
                    
                    }
                    
                    VStack {
                        Text("\(Int(bottomPercentage.isFinite ? bottomPercentage : 25))%")
                            .font(.system(size: 10))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text("\(String(format: "%.1f", bottomDistanceMM))mm")
                            .font(.system(size: 10))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(5)
                    .background(.darkAccent)
                    .cornerRadius(7)
                    .frame(width: 52, alignment: .leading)
                    .position(x: cropSize.width + 23 + 45, y: bottomLineOffset)
                }
                
            }
            .frame(width: cropSize.width + 35, height: cropSize.height)
            .animation(.easeInOut(duration: 0.3), value: cropSize)
            .onChange(of: frameHeight) { old, new in
                updateCropSize()
            }
            .onChange(of: frameWidth) { old, new in
                updateCropSize()
            }
            .onChange(of: topLineOffset) { old, new in
                topPerc = (topLineOffset / cropSize.height)
            }
            .onChange(of: bottomLineOffset) { old, new in
                bottomPerc = 1 - (bottomLineOffset / cropSize.height)
            }
            .onAppear {
                topPerc = (topLineOffset / cropSize.height)
                bottomPerc = 1 - (bottomLineOffset / cropSize.height)
                updateCropSize()
            }
        }
    }
    

    private func computeScale(topLine: CGFloat, bottomLine: CGFloat, frameHeight: CGFloat, headHeight: CGFloat) -> CGFloat {
        let visibleHeight = bottomLine - topLine
        return visibleHeight / headHeight
    }
    
   
    private func computeImageOffset(scale: CGFloat, topLine: CGFloat, headHeight: CGFloat) -> CGFloat {
        let scaledHeadHeight = headHeight * scale
        let offset = topLine - scaledHeadHeight / 2
        return offset
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
    
    func updateCropSize() {
        cropSize = calculateCropSize(availableWidth: availableWidth, maxHeight: 186, targetWidth: frameWidth, targetHeight: frameHeight)
    }

}

#Preview {
    EditTemplateFaceRuler(topLineOffset: .constant(30), bottomLineOffset: .constant(130), frameWidth: .constant(35), frameHeight: .constant(45), selectedLine: .constant(.head), cropSize: .constant(CGSize(width: 350, height: 450)), topPerc: .constant(30), bottomPerc: .constant(20))
        .environmentObject(MainViewModel())

}
