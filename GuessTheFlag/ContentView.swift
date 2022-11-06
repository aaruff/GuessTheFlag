//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Anwar Ruff on 11/2/22.
//

import SwiftUI

struct ContentView: View {
    let flagsPerChoice = 3
    
    var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    var randomChosenFlag : Int
    
    @State var score = 0
    @State var choiceMade = false
    @State var choiceOutcome = ""
    
    func generateNewQuestion() {
        countries.shuffled()
        choiceMade = false
    }
    
    func flagSelectionHandler(choice: Int) {
        if choice == randomChosenFlag {
            choiceOutcome = "Correct"
        }
        else {
            choiceOutcome = "Incorrect"
        }
            
        choiceMade = true
    }
    
    
    init(){
        randomChosenFlag = Int.random(in: 0..<3)
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                VStack {
                    Text("Pick the flag for \(countries[randomChosenFlag])")
                }
                ForEach(0..<flagsPerChoice, id: \.self) { i in
                    Button(
                        action: {
                            flagSelectionHandler(choice: i)
                        },
                        label: {
                        Image("\(countries[i])")
                            .renderingMode(.original)
                            .border(.black)
                        }
                    )
                    .alert(choiceOutcome, isPresented: $choiceMade) {
                        Button("OK", role: .cancel){
                            choiceMade = false
                        }
                    }
                }
                .navigationBarTitle("Guess The Flag")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
