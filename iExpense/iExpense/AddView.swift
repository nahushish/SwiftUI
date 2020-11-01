//
//  AddView.swift
//  iExpense
//
//  Created by Shishira on 10/11/20.
//  Copyright © 2020 Shishira. All rights reserved.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var expenses : Expenses
    
    @Environment (\.presentationMode) var presentationMode
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    @State private var showingAlert = false
    static let types = ["Business","Personal"]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text:$name)
                Picker("Type", selection: $type){
                    ForEach(Self.types, id: \.self){
                        Text($0)
                    }
                }
                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
            }
        .navigationBarTitle("Add new expense")
            .navigationBarItems(trailing: Button("Save") {
                if let expenseAmount = Int(self.amount) {
                    let expenseItem = ExpenseItem(name: self.name, type: self.type, amount: expenseAmount)
                    self.expenses.items.append(expenseItem)
                    self.presentationMode.wrappedValue.dismiss()
                }
                else{
                    self.showingAlert = true
                }
            })
                .alert(isPresented: $showingAlert){
                    Alert(title: Text("Invalid input"), message: Text("Please enter a valid number"), dismissButton: .default(Text("OK")))
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
