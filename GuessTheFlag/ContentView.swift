//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Anwar Ruff on 11/2/22.
//

import SwiftUI

struct ContentView: View {
    let countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
    var randomStartPoint : Int
    var randomEndPoint : Int
    var randomFlag : Int
    
    
    init(){
        randomStartPoint = Int.random(in: 0...8)
        randomEndPoint = randomStartPoint + 2
        randomFlag = Int.random(in: randomStartPoint...randomEndPoint)
    }
    
    var body: some View {
        VStack(spacing: 30) {
            VStack {
                Text("Pick the flag for \(countries[randomFlag])")
            }
            ForEach(randomStartPoint...randomEndPoint, id: \.self) { i in
                Button(action: {print("clicked on \(countries[i])")}, label: {
                    Image("\(countries[i])")
                        .renderingMode(.original)
                        .border(.black)
                })
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
