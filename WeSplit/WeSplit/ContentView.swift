//
//  ContentView.swift
//  WeSplit
//
//  Created by Shishira on 9/30/20.
//  Copyright © 2020 Shishira. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = ""
    @State private var tipPercent = 2
    var tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople) ?? 1
        let tipSelection = Double(tipPercentages[tipPercent])
        let orderAmount = Double(checkAmount) ?? 0
        
        let tipValue = (orderAmount * tipSelection)/100
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal/peopleCount
        return amountPerPerson
    }
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount).keyboardType(.decimalPad)
//                    Picker("Number of People", selection: $numberOfPeople)
//                    {
//                        ForEach (2 ..< 100) {
//                            Text("\($0) people")
//                        }
//                    }
                    TextField("Number of People", text: $numberOfPeople).keyboardType(.numberPad)
                }
                Section(header:Text("How much Tip do you want to leave?")) {
                    Picker("Tip Percentage", selection: $tipPercent){
                        ForEach (0 ..< tipPercentages.count){
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section {
                    Text("Total amount $\(totalPerPerson*(Double(numberOfPeople) ?? 0), specifier:"%.2f")")
                }
                Section(header:Text("Amount Per Person")) {
                    // here $ represents Dollar amount. Eg: $39.99
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
            }
        .navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
