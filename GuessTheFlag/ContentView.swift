//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Anwar Ruff on 11/2/22.
//

import SwiftUI

struct ContentView: View {
    let flagsPerChoice = 3
    
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State var randomChosenFlag : Int
    
    @State var score = 0
    @State var choiceMade = false
    @State var choiceOutcome = ""
    
    func generateNewQuestion() {
        randomChosenFlag = Int.random(in: 0..<3)
        countries = countries.shuffled()
        choiceMade = false
    }
    
    func flagSelectionHandler(choice: Int) {
        if choice == randomChosenFlag {
            choiceOutcome = "Correct"
            score += 1
        }
        else {
            choiceOutcome = "Incorrect"
        }
            
        choiceMade = true
    }
    
    
    init(){
        randomChosenFlag = Int.random(in: 0..<3)
        countries.shuffled()
        choiceMade = false
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                VStack {
                    Text("Pick the flag for \(countries[randomChosenFlag])")
                        .font(.subheadline.weight(.heavy))
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
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                        }
                    )
                    .alert(isPresented: $choiceMade) {
                        Alert(
                            title: Text(choiceOutcome),
                            message: Text("Your Current Score: \(score)"),
                            dismissButton:  .default(Text("OK")){generateNewQuestion()})
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
