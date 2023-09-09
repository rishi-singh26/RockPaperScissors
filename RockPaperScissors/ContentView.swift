//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Rishi Singh on 09/09/23.
//

import SwiftUI

struct ContentView: View {
    let options = ["🪨", "📃", "✂️"]
    let colors = [
        Color(red: 0.4, green: 0.44, blue: 0.48, opacity: 0.3),
        Color(red: 0.38, green: 0.89, blue: 0.99, opacity: 0.5),
        Color(red: 0.99, green: 0.23, blue: 0.27, opacity: 0.3)
    ]
    
    @State private var selection = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    @State private var score = 0

    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottom)
            VStack(spacing: 0) {
                Spacer()
                Text("Score: \(score)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Spacer()
                IconView(icon: options[selection], color: colors[selection])
                Text(shouldWin ? "Win" : "Lose")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(shouldWin ? .green : .red)
                Spacer()
                HStack(spacing: 20) {
                    Button {
                        handleUserSelection(when: options[selection], with: options[0])
                    } label: {
                        IconView(icon: options[0], color: colors[0])
                    }
                    Button {
                        handleUserSelection(when: options[selection], with: options[1])
                    } label: {
                        IconView(icon: options[1], color: colors[1])
                    }
                    Button {
                        handleUserSelection(when: options[selection], with: options[2])
                    } label: {
                        IconView(icon: options[2], color: colors[2])
                    }
                }
                Spacer()
            }
            .padding()
        }
        .ignoresSafeArea()
    }
    
    func handleUserSelection(when gameChoice: String, with userChoice: String) {
        if let didWin = checkWinLoose(on: gameChoice, with: userChoice) {
            if shouldWin && didWin {
                score += 1
            }
            if !shouldWin && !didWin {
                score += 1
            }
        }
        selection = Int.random(in: 0...2)
        shouldWin.toggle()
    }
    
    func checkWinLoose(on gameChoice: String, with userChoice: String) -> Bool? {
        if (gameChoice == options[0] && userChoice == options[1]) {
            return true
        }
        if (gameChoice == options[1] && userChoice == options[2]) {
            return true
        }
        if (gameChoice == options[2] && userChoice == options[0]) {
            return true
        }
        if gameChoice == userChoice {
            return nil
        }
        return false
    }
}

struct IconView: View {
    let icon: String
    let color: Color
    var body: some View {
        Text(icon)
            .font(.largeTitle)
            .frame(width: 50, height: 50)
            .padding()
            .background(color)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(radius: 10)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
