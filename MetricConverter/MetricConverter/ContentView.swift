//
//  ContentView.swift
//  MetricConverter
//
//  Created by Shishira on 10/1/20.
//  Copyright © 2020 Shishira. All rights reserved.
//

import SwiftUI

enum LengthMetric : Int {
    case meter = 0
    case kilometer
    case feet
    case yard
    case mile
}

struct ContentView: View {
    @State private var fromLength = ""
    @State private var fromMetric = LengthMetric.meter.rawValue
    @State private var toMetric = LengthMetric.kilometer.rawValue
    
    var lengthMetricNames = ["meter", "kilometer", "feet", "yard", "mile"]
    var valueToBeConverted : Double = 0
    var afterConversion : Double {
        let value = Double(fromLength) ?? 0
        let millimeter = Measurement(value: value, unit: UnitLength.feet)
        switch toMetric {
        case LengthMetric.meter.rawValue : return millimeter.converted(to: UnitLength.meters).value
        case LengthMetric.kilometer.rawValue : return millimeter.converted(to: UnitLength.kilometers).value
        case LengthMetric.feet.rawValue : return millimeter.converted(to: UnitLength.feet).value
        case LengthMetric.yard.rawValue : return millimeter.converted(to: UnitLength.yards).value
        case LengthMetric.mile.rawValue : return millimeter.converted(to: UnitLength.miles).value
        default:
            return 0
        }
    }
    var body: some View {
        NavigationView{
            Form {
                Section {
                    TextField("Enter the value", text: $fromLength).keyboardType(.decimalPad)
                }
                Section {
                    Text("Convert from")
                        Picker("Select metric", selection: $fromMetric) {
                            ForEach (0 ..< self.lengthMetricNames.count) {
                                Text("\(self.lengthMetricNames[$0])")
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                    
                }
                Section {
                    Text("Convert to")
                    Picker("Select metric", selection: $toMetric) {
                            ForEach (0 ..< self.lengthMetricNames.count) {
                                Text("\(self.lengthMetricNames[$0])")
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                }
            
                Section {
                    Text("\(fromLength) \(self.lengthMetricNames[fromMetric]) = \(self.afterConversion) \(self.lengthMetricNames[toMetric])")
                }
            }
            .navigationBarTitle("Metric Conversion")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
