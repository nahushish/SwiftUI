//
//  ContentView.swift
//  Sample2
//
//  Created by Shishira on 10/4/20.
//  Copyright © 2020 Shishira. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAlert = false
    var body: some View {
//        VStack(alignment : .leading, spacing : 3){
////                Text("Hello, World!")
////                Text("This is a new World")
////                Text("Good Morning!")
//                HStack {
//                    Text("Hello, World!")
//                    Text("This is a new World")
//                }
//            HStack {
//                Text("Hello, World!")
//                Text("This is a new World")
//            }
//            HStack {
//                Text("Hello, World!")
//                Text("This is a new World")
//            }
//
//
                ZStack(alignment : .top){
                    Color(red: 0.5, green: 0.6, blue: 0.7).edgesIgnoringSafeArea(.all)
                    Text("Hello, World!")
                    Text("This")
                    .background(Color.secondary)
                    LinearGradient(gradient: Gradient(colors: [.white,.red, .black]), startPoint: .top, endPoint: .bottom)
                    RadialGradient(gradient: Gradient(colors: [.blue, .green]), center: .topTrailing, startRadius: 20, endRadius: 500)
                    AngularGradient(gradient: Gradient(colors: [.red,.purple,.blue, .green, .yellow, .orange, .red]), center: .center)
                    Button(action:{
                        print("Button was tapped")
                        self.showingAlert = true
                    }) {
                        HStack(spacing: 10) {
                        Text("Tap me!")
                            Image(systemName: "pencil").renderingMode(.original)
                        }.alert(isPresented:$showingAlert){
                            Alert(title: Text("Hello SwiftUI"), message: Text("This is an alert message"), dismissButton: .default(Text("OK")))
                        }
                    }
                }
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
