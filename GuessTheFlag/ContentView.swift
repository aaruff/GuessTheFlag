//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Anwar Ruff on 11/2/22.
//

import SwiftUI

struct ContentView: View {
    let flagsPerRound = 3
    let totalRounds = 8
    let scoreMultiplier = 2
    
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State var randomChosenFlag : Int
    
    @State var guessCount = 0
    @State var correctCount = 0
    @State var flagSelected = 0
    @State var choiceMade = false
    @State var outcomeTitle = ""
    @State var outcomeMessage = ""
    
    @State var finalScore = 0
    @State var finalCorrect = 0
    @State var showEndgameSheet = false
    
    @State var round: Int
    
    func generateNewQuestion() {
        if round < totalRounds {
            round += 1
            guessCount += 1
        }
        else {
            round = 1
            guessCount = 0
            correctCount = 0
        }
        
        randomChosenFlag = Int.random(in: 0..<flagsPerRound)
        countries = countries.shuffled()
        choiceMade = false
    }
    
    func flagSelectionHandler(choice: Int) {
        if choice == randomChosenFlag {
            correctCount += 1
            outcomeTitle = "Excellent!"
            outcomeMessage = "You correctly chose the flag for \(countries[choice])."
        }
        else {
            outcomeTitle = "Sorry..."
            outcomeMessage = "You chose the flag for \(countries[choice]) not \(countries[randomChosenFlag])."
        }
            
        choiceMade = true
    }
    
    
    init(){
        round = 1
        randomChosenFlag = Int.random(in: 0..<flagsPerRound)
        countries.shuffled()
        choiceMade = false
    }
    
    var body: some View {
        NavigationView {
            
            VStack() {
                Spacer()
                    .frame(height: 40)
                
                Text("Pick the flag for **\(countries[randomChosenFlag])**")
                Spacer()
                    .frame(height: 40)
                
                    
                VStack(spacing: 30) {
                    ForEach(0..<flagsPerRound, id: \.self) { i in
                        Button(
                            action: {
                                flagSelected = i
                                flagSelectionHandler(choice: i)
                            },
                            label: {
                                Image("\(countries[i])")
                                    .renderingMode(.original)
                                    .border(.black
                                    )
                            }
                        )
                        .alert(isPresented: $choiceMade) {
                            Alert(
                                title: Text(outcomeTitle),
                                message: Text(outcomeMessage),
                                dismissButton:  .default(Text("OK")){
                                    if round == totalRounds {
                                        finalCorrect = correctCount
                                        finalScore = correctCount*scoreMultiplier
                                        showEndgameSheet = true
                                    }
                                    generateNewQuestion()
                                })
                        }
                    }
                }
                .padding()
                Spacer()
                    .frame(height: 50)
                
                HStack(spacing: 10) {
                    VStack{
                        Text("Score")
                            .foregroundColor(.white)
                        Text("\(correctCount * scoreMultiplier)")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                        
                    }
                    .padding()
                    .background(.orange)
                    .cornerRadius(20)
                    
                    VStack{
                        Text("Round")
                            .foregroundColor(.white)
                        Text("\(round)")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                        
                    }
                    .padding()
                    .background(.gray)
                    .cornerRadius(20)
                }
            }
            .sheet(isPresented: $showEndgameSheet) {
                VStack {
                    Text("Complete")
                        .font(.largeTitle)
                        .padding()
                    
                    VStack{
                        Text("Final Score")
                            .foregroundColor(.white)
                        Text("\(finalScore)")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                        
                    }
                    .padding()
                    .background(.orange)
                    .cornerRadius(20)
                    
                    HStack {
                        VStack{
                            Text("Correct")
                                .foregroundColor(.white)
                            Text("\(finalCorrect)")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                            
                        }
                        .padding()
                        .background(.green)
                        .cornerRadius(20)
                        
                        VStack{
                            Text("Incorrect")
                                .foregroundColor(.white)
                            Text("\(totalRounds-finalCorrect)")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                            
                        }
                        .padding()
                        .background(.red)
                        .cornerRadius(20)
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
