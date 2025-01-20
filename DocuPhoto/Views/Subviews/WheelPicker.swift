//
//  CustomSlider.swift
//  Passport Photo Maker App
//
//  Created by Lukman Makhaev on 10.12.2024.
//

import SwiftUI

struct WheelPicker: View {
    var config: Config
    @Binding var value: CGFloat
    
    @State private var isLoaded: Bool = false
    
    var body: some View {
        
        GeometryReader {
            let size = $0.size
            let horizontalPadding = size.width / 2
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: config.spacing) {
                    let totalSteps = config.count * config.steps
                    
                    ForEach(0..<totalSteps, id: \.self) { index in
                        let remainder = index % config.steps
                        
                        Divider()
                            .background(.gray)
                            .frame(width: 0, height: remainder == 0 ? 13 : 7, alignment: .center)
                            .frame(maxHeight: 20, alignment: .bottom)
                            .overlay(alignment: .bottom) {
                                if remainder == 0 && config.showsText {
                                    Text("\((index / config.steps) * config.multiplier)")
                                        .font(.caption)
                                        .fontWeight(.semibold)
                                        .textScale(.secondary)
                                        .fixedSize()
                                        .offset(y: 20)
                                }
                            }
                            
                    }
                }
                .frame(height: size.height)
                .scrollTargetLayout()
            }
            .scrollIndicators(.hidden)
            .scrollTargetBehavior(.viewAligned)
            .scrollPosition(id: .init(get: {
                let position: Int? = isLoaded ? Int(value * CGFloat(config.steps)) / config.multiplier : nil
                return position
            }, set: { newValue in
                if let newValue {
                    value = (CGFloat(newValue) / CGFloat(config.steps)) * CGFloat(config.multiplier)
                }
            }))
            .onAppear {
                if !isLoaded {
                    DispatchQueue.main.async {
                        let middleValue = CGFloat(config.count / 2)
                        value = middleValue * CGFloat(config.multiplier)
                        isLoaded = true
                    }
                }
            }
            .overlay(alignment: .center, content: {
                
                VStack (spacing: 3) {
                    Circle()
                        .frame(width: 5, height: 5)
                    
                    Rectangle()
                        .frame(width: 1, height: 23)
                        .padding(.bottom, 0)
                }
                .foregroundStyle(.accent)
 
            })
            .safeAreaPadding(.horizontal, horizontalPadding)
            .onAppear {
                if isLoaded { isLoaded = true }
                
            }
        }
    }
    
    struct Config: Equatable {
        var count: Int
        var steps: Int = 5
        var spacing: CGFloat = 9
        var multiplier: Int = 1
        var showsText: Bool = false
    } 
}

#Preview {
    WheelPicker(config: .init(count: 10), value: .constant(5))
}
