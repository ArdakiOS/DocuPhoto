//
//  WheelPicker2.swift
//  Passport Photo Maker App
//
//  Created by Lukman Makhaev on 17.12.2024.
//

import SwiftUI
import Combine

struct WheelPicker2: View {
    var segmentWidth: CGFloat = 1.0
    @Binding var count: Int
    var values: ClosedRange<Int>
    var spacing: Double
    var steps: Int
    @State var isScrolling: Bool = false
    @State private var isLoaded: Bool = false
    var style: SegmentStyle
    
    public init(count: Binding<Int>, from: Int, to: Int, spacing: Double = 9.0, steps: Int, style: SegmentStyle) {
        _count = count
        self.values = from...(style == .styleOne ? (to) : to)
        self.spacing = spacing
        self.steps = steps
        self.style = style
    }
    
    
    public var body: some View {
        
        ZStack {
            GeometryReader { geo in
                ScrollViewReader { proxy in
                    ScrollView(.horizontal) {
                        ZStack {
                            WheelViewOffsetReader {
                                isScrolling = true
                            } onScrollingFinished: {
                                isScrolling = false
                            }
                            
                            HStack(spacing: spacing) {
                                SegmentView(values: values, steps: steps, segmentWidth: segmentWidth, style: style)
                            }
                            .frame(height: geo.size.height)
                            .scrollTargetLayout()
                        }
                    }
                    .overlay {
                        VStack (spacing: 3) {
                            Circle()
                                .frame(width: 5, height: 5)
                            
                            Rectangle()
                                .frame(width: 2, height: 23)
                                .padding(.bottom, 0)
                        }
                        .padding(.top, 5)
                        .foregroundStyle(.accent)
                        .shadow(color: .accent, radius: 3)
                    }
                    .scrollIndicators(.hidden)
                    .safeAreaPadding(.horizontal, geo.size.width / 2.0)
                    .scrollTargetBehavior(.viewAligned)
                    .scrollPosition(
                        id: .init(get: {
                            return count
                        }, set: { value, transition in
                            if let value {
                                count = value
                            }
                        })
                    )
                    .onAppear {
                        if !isLoaded {
                            let middleIndex = values.count / 2
                            proxy.scrollTo(middleIndex, anchor: .center)
                            count = middleIndex // Update the count to reflect the current position
                        }
                    }
                    .onChange(of: isScrolling, {oldValue, newValue in
                        if newValue == false && style == .styleTwo {
                            let indexValue: Double = Double(count) / Double(steps)
                            let nextItem = indexValue.rounded()
                            let newIndex = nextItem * Double(steps)
                            withAnimation {
                                if count != Int(newIndex) {
                                    count = Int(newIndex)
                                }
                            }
                        }
                    })
                }
            }
        }
        .frame(height: 50)
    }
}

#Preview {
    WheelPicker2(count: .constant(0), from: 0, to: 10, steps: 5, style: .styleTwo)
}

public enum SegmentStyle {
    case styleOne
    case styleTwo
}

struct SegmentView: View {
    let values: ClosedRange<Int>
    let steps: Int
    let segmentWidth: CGFloat
    let style: SegmentStyle
    
    var body: some View {
        ForEach(values, id: \.self) { index in
            let isPrimary = (index % steps == .zero)
            let middleSteps = Double(steps) / 2
            let isMiddle = (Double(index) - middleSteps).truncatingRemainder(dividingBy: Double(steps)) == .zero
            Rectangle()
                .frame(width: segmentWidth,
                       height: isPrimary ? 13.0 : (isMiddle ? 7.0 : 7.0)
                )
                .frame(maxHeight: 20.0, alignment: .bottom)
                .foregroundStyle((isPrimary || isMiddle) ? .gray : .gray)
//                .overlay {
//                    if isPrimary {
//                        Text("\(style == .styleOne ? index : (index / steps))")
//                            .font(.system(size: 14, design: .monospaced))
//                            .fixedSize()
//                            .offset(y: 20)
//                    }
//                }
        }
    }
}



struct WheelViewOffsetReader: View {
    private let onScrollingStarted: () -> Void
    private let onScrollingFinished: () -> Void
    private let detector: CurrentValueSubject<CGFloat, Never>
    private let publisher: AnyPublisher<CGFloat, Never>
    @State private var scrolling: Bool = false
    
    @State private var lastValue: CGFloat = 0
    
    init() {
        self.init(onScrollingStarted: {}, onScrollingFinished: {})
    }
    
    init (
        onScrollingStarted: @escaping () -> Void,
        onScrollingFinished: @escaping () -> Void
    ) {
        self.onScrollingStarted = onScrollingStarted
        self.onScrollingFinished = onScrollingFinished
        let detector = CurrentValueSubject<CGFloat, Never>(0)
        self.publisher = detector
            .debounce(for: .seconds(0.2), scheduler: DispatchQueue.main)
            .eraseToAnyPublisher()
        self.detector = detector
    }
    
    var body: some View {
        GeometryReader { g in
            Rectangle()
                .frame(width: 0, height: 0)
                .onChange(of: g.frame(in: .global).origin.x) { oldValue, newValue in
                    if !scrolling {
                        scrolling = true
                        onScrollingStarted()
                    }
                    detector.send(newValue)
                }
                .onReceive(publisher) {
                    scrolling = false
                    
                    guard lastValue != $0 else { return }
                    lastValue = $0
                    
                    onScrollingFinished()
                }
        }
    }
    
    func onScrollingStarted(_ closure: @escaping () -> Void) -> Self {
        .init(onScrollingStarted: closure,
              onScrollingFinished: onScrollingFinished
        )
    }
    
    func onScrollingFinished(_ closure: @escaping () -> Void) -> Self {
        .init(onScrollingStarted: onScrollingStarted,
              onScrollingFinished: closure
        )
    }
}
