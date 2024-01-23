//
//  OffsetModifier.swift
//  EVChargingNepal
//
//  Created by Alin Khatri on 20/08/2023.
//

import SwiftUI

struct OffsetModifier: ViewModifier {
    @Binding var offset: CGFloat
    
    // Optional to retrun value from 0
    var returnFromStart: Bool = true
    @State var startValue: CGFloat = 0
    
    func body(content: Content) -> some View {
        content
            .overlay {
                GeometryReader{proxy in
                    Color.clear
                        .preference(key: OffsetKey.self, value: proxy.frame(in: .named("SCROLL")).minY)
                        .onPreferenceChange(OffsetKey.self) { value in
                            if startValue == 0{
                                startValue = value
                            }
                            
                            offset = (value - (returnFromStart ? startValue : 0))
                            print(value)
                            
                        }
                }
            }
    }
}

// MARK: Preference Key
struct OffsetKey: PreferenceKey{
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
