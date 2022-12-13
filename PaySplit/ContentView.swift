//
//  ContentView.swift
//  PaySplit
//
//  Created by Wiljo de Ruiter on 13/12/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    var grandTotal: Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        return checkAmount + tipValue
    }
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    var totalPerCouple: Double {
        return 2 * totalPerPerson
    }
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount,
                              format: .currency( code: Locale.current.currency?.identifier ?? "EUR"))
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                            ForEach(2 ..< 40) {
                                Text("\($0) people")
                            }
                        }
                } header: {
                    Text("Enter the value to split")
                }
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach( 0 ..< 25 ) {
                            Text( $0, format: .percent )
                        }
                    }
                } header: {
                    Text("How much tip do you want to leave?")
                }
                Section {
                    Text(grandTotal, format: .currency(code: Locale.current.currency?.identifier ?? "EUR"))
                } header: {
                    Text("Grand total")
                }
                Section {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "EUR"))
                } header: {
                    Text("For each person")
                }
                Section {
                    Text(totalPerCouple, format: .currency(code: Locale.current.currency?.identifier ?? "EUR"))
                } header: {
                    Text("For each couple")
                }
            }
            .navigationTitle("Pay Split")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
