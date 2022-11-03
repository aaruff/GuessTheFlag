//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Anwar Ruff on 11/2/22.
//

import SwiftUI

struct ContentView: View {
    let countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
    
    var body: some View {
        VStack(spacing: 30) {
            UITextView("Instructions")
            ForEach(0..<3, id: \.self) { i in
                Button(action: {print("clicked on \(countries[i])")}, label: {
                    Image("\(countries[i])")
                        .renderingMode(.original)
                        .border(.black)
                })
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
