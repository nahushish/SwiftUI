//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Shishira on 10/4/20.
//  Copyright © 2020 Shishira. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 10){
//      Text("Hello, World!")
//        .blur(radius: 0)
////        Button("Hello World!"){
////            print(type(of: self.body))
////        }
////        .frame(width: 200, height: 200)
////        .background(Color.red)
////        .padding()
////        .background(Color.red)
////        .padding()
////        .background(Color.blue)
////        .padding()
////        .background(Color.green)
////        .padding()
////        .background(Color.yellow)
        Text("Hello, World!")
//        Text("Hello, World!")
//        Text("Hello, World!")
//        }.blur(radius: 2)
//            CapsuleText(text: "First")
            .largeTitleStyle()
//            CapsuleText(text: "Third")
//            Text("Hello World").titleStyle()
//            Color.blue
//            .frame(width: 300, height: 300)
//            .waterMarked(with: "Hacking with Swift")
            
        }
        
    }
}

struct CapsuleText : View {
    var text : String
    var body: some View {
        Text(text)
        .font(.largeTitle)
        .padding()
        .foregroundColor(.white)
        .background(Color.blue)
        .clipShape(Capsule())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Title:ViewModifier {
    func body(content: Content) -> some View {
        content
        .font(.largeTitle)
        .padding()
        .foregroundColor(.white)
        .background(Color.blue)
        .clipShape(Capsule())
    }
}

struct Watermark: ViewModifier {
    var text : String
    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing){
            content
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding()
                .background(Color.black)
        }
    }
}

struct LargeTitles : ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}



extension View {
    func titleStyle() -> some View {
        self.modifier(Title())
    }
    
    func waterMarked(with text: String) -> some View {
        self.modifier(Watermark(text: text))
    }
    
    func largeTitleStyle() -> some View {
        self.modifier(LargeTitles())
    }
}

