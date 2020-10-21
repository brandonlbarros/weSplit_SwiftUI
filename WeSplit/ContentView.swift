//
//  ContentView.swift
//  WeSplit
//
//  Created by Brandon Barros on 4/30/20.
//  Copyright © 2020 Brandon Barros. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var checkTotal = ""
    @State private var tipPercent = 2
    @State private var people = ""
    
    let tipPercents = [10, 15, 20, 25, 0]
    
    var total: Double {
        let tipSelect = Double(tipPercents[tipPercent])
        let checkValue = Double(checkTotal) ?? 0
        return((checkValue * ((tipSelect / 100.0) + 1)))
    }
    var totalPerPerson: Double {
        let toNum = Double(people) ?? 0
        if (toNum < 1) {
            return 0.0
        }
        return(total / toNum)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Check Amount", text: $checkTotal)
                        .keyboardType(.decimalPad)
                    
                    
                    TextField("Number of people", text: $people)
                        .keyboardType(.numberPad)
                    
                }
                
                Section(header: Text("How much of a tip do you want to leave?")) {
                    Picker("Tip percentage", selection: $tipPercent) {
                        ForEach(0 ..< tipPercents.count) {
                            Text("\(self.tipPercents[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Amount owed after tip")) {
                    Text("$\(total, specifier: "%.2f")")
                        .foregroundColor((self.tipPercent == 4) ? Color.red: Color.black)
                }
                
                Section(header: Text("Amount you should each pay")) {
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
