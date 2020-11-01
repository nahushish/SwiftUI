//
//  ContentView.swift
//  BetterRest
//
//  Created by Shishira on 10/5/20.
//  Copyright © 2020 Shishira. All rights reserved.
//

import SwiftUI
import CoreML

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    @State private var alertMessage = ""
    @State private var alertTitle = ""
    @State private var showingAlert = false
    
    static var defaultWakeTime : Date{
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    
    
    var body: some View {
        NavigationView {
            Form{
//                VStack(alignment: .leading, spacing: 0) {
                Section(header: Text("When do you want to wake up?")) {
//                    Text("When do you want to wake up?")
                        
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .datePickerStyle(WheelDatePickerStyle())
                }.font(.subheadline)
                
//                VStack(alignment: .leading, spacing: 0) {
                Section(header:Text("Desired amount of Sleep")){
//                    Text("Desired amount of Sleep")
                        
                    Stepper(value:$sleepAmount, in: 4...12, step: 0.25) {
                        Text("\(sleepAmount, specifier: "%g") hours")
                    }
                }.font(.subheadline)
                
//                VStack(alignment: .leading, spacing: 0) {
                Section(header:Text("Daily Coffee intake")) {
//                    Text("Daily Coffee intake")
                        
//                    Stepper(value: $coffeeAmount, in: 1...20){
//                        if coffeeAmount == 1 {
//                            Text("1 Cup")
//                        }
//                        else
//                        {
//                            Text("\(coffeeAmount) Cups")
//                        }
//                    }
                    
                    Picker("Number of Cups", selection: $coffeeAmount){
                        ForEach (0..<21) {
                            if $0 > 0
                            {
                                Text("\($0) Cups")
                            }
                        }
                    }
                }.font(.subheadline)
                
            }
            .alert(isPresented: $showingAlert){
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
            .navigationBarTitle("Better Rest")
            .navigationBarItems(trailing: Button(action: calculateBedTime){
                Text("Calculate")
            })
        }
    }
    
    func calculateBedTime() {
        let model = SleepCalculator()
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        
        do {
            let prediction = try model.prediction(wake: Double(hour+minute),estimatedSleep: sleepAmount,coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
            
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            alertMessage = formatter.string(from: sleepTime)
            alertTitle = "Your ideal bedtime is"
        } catch  {
            alertTitle = "Error"
            alertMessage = "Sorry, there was problem calculating your bedtime."
        }
        showingAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
