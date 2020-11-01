//
//  ContentView.swift
//  MoonShot
//
//  Created by Shishira on 10/12/20.
//  Copyright © 2020 Shishira. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let astronaut : [Astronaut] = Bundle.main.decode("astronauts.json")
    let mission : [Mission] = Bundle.main.decode("missions.json")
    var body: some View {
        VStack {
            Text("\(astronaut.count)")
            Text("\(mission.count)")
        }
    }
}

struct User : Codable {
    var name : String
    var address : Address
}

struct Address : Codable {
    var street : String
    var city : String
}

struct decodeUsingCodable : View {
    var body: some View {
        Button("Decode JSON") {
            let input = """
            {
                "name" : "Taylor Swift",
                "address" : {
                    "street" : "489, Taylor Swift Avenue",
                    "city" : "Oklahoma City"
                    }
            }
            """
            
             let data = Data(input.utf8)
            let decoder = JSONDecoder()
            if let user = try? decoder.decode(User.self, from: data){
                print(user.address.street)
            }
        }
    }
}

struct Navigation : View {
    var body: some View {
        NavigationView {
            List(0..<100){ row in
                NavigationLink(destination: Text("Detail View")) {
                    Text("Row \(row)")
                }
            }
        .navigationBarTitle("SwiftUI")
        }
    }
}

struct CustomText : View {
    var text : String
    var body: some View {
        Text(text)
    }
    
    init(_ text: String) {
        print("Creating new custom text")
        self.text = text
    }
}

struct Scrolling : View {
    var body: some View {
        List {
//            VStack(alignment:.leading, spacing: 10){
                ForEach(0..<100){
                    CustomText("Item \($0)")
                        .font(.title)
                }
//            }
//            .frame(maxWidth:.infinity)
        }
    }
}

struct ImageResizing : View {
    var body: some View{
        VStack{
            GeometryReader{ geo in
            Image("sea")
            .resizable()
            .aspectRatio(contentMode: .fit)
                .frame(width: geo.size.width)
            .clipped()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
