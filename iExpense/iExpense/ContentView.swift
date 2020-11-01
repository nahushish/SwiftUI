//
//  ContentView.swift
//  iExpense
//
//  Created by Shishira on 10/10/20.
//  Copyright © 2020 Shishira. All rights reserved.
//

import SwiftUI

class User : ObservableObject {
   @Published var firstName = "Bilbo"
   @Published var lastName = "Baggins"
}

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet{
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let items = UserDefaults.standard.data(forKey: "Items") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([ExpenseItem].self, from: items){
                self.items = decoded
                return
            }
        }
        self.items = []
    }
}

struct user : Codable {
    var firstName : String
    var lastName : String
}

struct SecondView : View {
    @Environment (\.presentationMode) var presentationMode
    var name : String
    var body: some View {
        Button("Dismiss"){
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct ContentView: View {
    @ObservedObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            List{
                ForEach(expenses.items){item in
                    HStack {
                        VStack(alignment: .leading){
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                                .font(.subheadline)
                        }
                        Spacer()
                        Text("$\(item.amount)")
                            .modifier(style(amount: item.amount))
                        
                    }
                }
            .onDelete(perform: removeItems)
            }
            .navigationBarTitle("iExpense")
            .navigationBarItems(leading: EditButton(), trailing: Button(action: {
                        self.showingAddExpense.toggle()
                }) {
                    Image(systemName: "plus")
                })
            .sheet(isPresented: $showingAddExpense){
                AddView(expenses: self.expenses)
            }
            
        }
    }
    
    func removeItems(atoffsets: IndexSet) {
        self.expenses.items.remove(atOffsets: atoffsets)
    }
}

struct userDefaultsView : View {
    @State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")
    @State private var User = user(firstName:"Shishira", lastName: "Shastri")
    var body: some View {
        Group {
            Button("Tap me, Count = \(tapCount)"){
                self.tapCount += 1
                UserDefaults.standard.set(self.tapCount, forKey: "Tap")
            }
            
            TextField("Enter your first name", text: $User.firstName)
            TextField("Enter your last name", text: $User.lastName)
            
            Button("Save User"){
                let encoder = JSONEncoder()
                if let data = try? encoder.encode(self.User){
                    UserDefaults.standard.set(data, forKey: "Userdata")
                }
            }
        }
    }
}

struct deleteFromList : View {
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(numbers, id:  \.self) {
                        Text("\($0)")
                    }
                .onDelete(perform: removeRows)
                }
                
                Button("Add number") {
                    self.numbers.append(self.currentNumber)
                    self.currentNumber += 1
                }
                
            }
        .navigationBarItems(leading: EditButton())
        }
    }
    
    func removeRows(at offsets: IndexSet){
        numbers.remove(atOffsets: offsets)
    }
}

// Sheet presenting along with working with classes
struct sheeetView : View {
    @State private var isSheetShown = false
    @ObservedObject var user = User()
    var body: some View {
        VStack {
            Text("Your name is \(user.firstName) \(user.lastName).")
            TextField("First Name", text: $user.firstName)
            TextField("Last Name", text: $user.lastName)
            
            Button("show sheet"){
                self.isSheetShown.toggle()
            }
            .sheet(isPresented: $isSheetShown) {
                SecondView(name: "Shishira")
            }
        }
    }
}

struct style: ViewModifier {
    var amount : Int
    func body(content: Content) -> some View {
        if amount < 10 {
            return content.font(.headline)
        }
        else if amount < 100 {
            return content.font(.body)
        }
        else {
            return content.font(.largeTitle)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
