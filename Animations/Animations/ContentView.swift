//
//  ContentView.swift
//  Animations
//
//  Created by Shishira on 10/10/20.
//  Copyright © 2020 Shishira. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let letters = Array("Hello SwiftUI")
    @State private var enabled = false
    @State private var dragAmount = CGSize.zero
    
    @State private var isShowingRed = false
    var body: some View {
        
// Moves the text in an snake like pattern
        
        
//        HStack (spacing: 0) {
//            ForEach(0 ..< letters.count) { num in
//                Text(String(self.letters[num]))
//                .padding(5)
//                .font(.title)
//                .background(self.enabled ? Color.red : Color.blue)
//                .offset(self.dragAmount)
//                .animation(Animation.default.delay(Double(num)/20))
//            }
//        }
//        .gesture(
//            DragGesture()
//                .onChanged{ self.dragAmount = $0.translation }
//                .onEnded {_ in
//                    withAnimation(.spring()){
//                        self.dragAmount = .zero
//                        self.enabled.toggle()
//                    }
//                }
//        )
   
//
//       Transition Example
        
        VStack {
            Button("Tap me"){
                withAnimation(){
                    self.isShowingRed.toggle()
                }
            }

            if isShowingRed {
            Rectangle()
                .fill(Color.red)
                .frame(width: 300, height: 200)
//                .transition(.asymmetric(insertion: .scale, removal: .opacity))
                .transition(.pivot)
            }
        }
        
        
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CornerRotateModifier : ViewModifier {
    let amount : Double
    let anchor : UnitPoint
    
    func body(content: Content) -> some View {
        content.rotationEffect(.degrees(amount), anchor: anchor).clipped()
    }
}

extension AnyTransition {
    static var pivot : AnyTransition {
        .modifier(active: CornerRotateModifier(amount: -90, anchor: .topLeading), identity: CornerRotateModifier(amount: 0, anchor: .topLeading))
    }
    
}
