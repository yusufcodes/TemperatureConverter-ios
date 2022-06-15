//
//  ContentView.swift
//  TemperatureConverter
//
//  Created by Yusuf Chowdhury on 15/06/2022.
//

import SwiftUI

struct ContentView: View {
    enum Unit: String {
        case celsius = "Celsius"
        case farenheit = "Farenheit"
        case kelvin = "Kelvin"
    }
    let temperatureUnits: [Unit] = [.celsius, .farenheit, .kelvin]
    
    @State private var inputUnit: Unit = .celsius
    @State private var outputUnit: Unit = .farenheit
    @State private var userInput = 0.0
    @State private var error = false
    
    private var calculatedTemperature: Double {
        if (inputUnit == outputUnit) {
            error = true
            return 0
        }
        if (inputUnit == .celsius) {
            return outputUnit == .farenheit ? (userInput * (9/5)) + 32 : userInput + 273.15
        }
        if (inputUnit == .farenheit) {
            return outputUnit == .celsius ? (userInput-32)*5/9 : ((userInput-32)*5/9)+273.15
        }
        return outputUnit == .farenheit ? ((userInput-273.15)*9/5)+32 : userInput-273.15
    }
    
    var body: some View {
        // Select: Input unit
        Section {
            Picker("Temperature", selection: $inputUnit) {
                ForEach(temperatureUnits, id: \.self) {
                    Text($0.rawValue)
                }
            }
            .pickerStyle(.segmented)
            .padding([.bottom, .trailing, .leading], 20)
        } header: {
            Text("Select an input unit")
        }
        
        // Select: Output unit
        Section {
            Picker("Temperature", selection: $outputUnit) {
                ForEach(temperatureUnits, id: \.self) {
                    Text($0.rawValue)
                }
            }
            .pickerStyle(.segmented)
            .padding([.bottom, .trailing, .leading], 20)
        } header: {
            Text("Select an output unit")
        }
        
        // Input: Value
        TextField("Enter a temperature to convert", value: $userInput, format: .number)
            .textFieldStyle(.roundedBorder)
            .padding()
        
        // Text: Display output
        Section {
            Text("Converted temperature: \(calculatedTemperature)")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
