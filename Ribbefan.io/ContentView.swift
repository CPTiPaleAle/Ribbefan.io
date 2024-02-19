//
//  ContentView.swift
//  Ribbefan.io
//
//  Created by Arin Aksberg-Kristensen on 16/02/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var servingTime = Date()
    @State private var ribbeSteg: [RibbeSteg] = []

    var body: some View {
        VStack {
            DatePicker(
                "Velg serveringstid:",
                selection: $servingTime,
                displayedComponents: .hourAndMinute
            )
            .datePickerStyle(.wheel)
            .padding()

            Button("Beregn Tider") {
                beregnTilberedningstider()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)

            List(ribbeSteg, id: \.tidspunkt) { steg in
                VStack(alignment: .leading) {
                    Text(steg.beskrivelse)
                        .font(.headline)
                    Text("\(steg.tidspunkt, formatter: itemFormatter)")
                        .font(.subheadline)
                }
            }
        }
        .padding()
    }

    func beregnTilberedningstider() {
        let calendar = Calendar.current

        let coolingTime = calendar.date(byAdding: .minute, value: -40, to: servingTime)!
        let temperatureIncreaseTime = calendar.date(byAdding: .minute, value: -45, to: coolingTime)!
        let roastingTime = calendar.date(byAdding: .hour, value: -18, to: temperatureIncreaseTime)!
        let steamingTime = calendar.date(byAdding: .minute, value: -60, to: roastingTime)!
        let soakingTime = calendar.date(byAdding: .minute, value: -60, to: steamingTime)!

        ribbeSteg = [
            RibbeSteg(tidspunkt: soakingTime, beskrivelse: "Start utvanning"),
            RibbeSteg(tidspunkt: steamingTime, beskrivelse: "Start damping"),
            RibbeSteg(tidspunkt: roastingTime, beskrivelse: "Start steking"),
            RibbeSteg(tidspunkt: temperatureIncreaseTime, beskrivelse: "Start øking av temperatur"),
            RibbeSteg(tidspunkt: coolingTime, beskrivelse: "Start avkjøling"),
            RibbeSteg(tidspunkt: servingTime, beskrivelse: "Serveringstid")
        ]
    }
}

let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .none
    formatter.timeStyle = .short
    return formatter
}()

