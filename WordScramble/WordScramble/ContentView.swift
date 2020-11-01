//
//  ContentView.swift
//  WordScramble
//
//  Created by Shishira on 10/8/20.
//  Copyright © 2020 Shishira. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    @State private var letterCount = 0
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter your word", text: $newWord, onCommit: addNewWord)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .autocapitalization(.none)
                
                List(usedWords, id: \.self)
                {
                    Image(systemName: "\($0.count).circle")
                    Text($0)
                }
                
                Text("Your score: word count = \(usedWords.count), letter count = \(letterCount)")
                    .font(.footnote)
                Spacer()
            }
            .navigationBarTitle(rootWord)
            .onAppear(perform: startNewGame)
            .alert(isPresented: $showingError) {
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
            .navigationBarItems(leading: Button(action: startNewGame) {
                Text("New Game")
            })
        }
        
        
    }
    
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else
        {
            return
        }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word already used", message: "Be more Original")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not Recognized", message: "You can't just make them up, you know!")
            return
        }
        
        guard isReal(word: answer) else {
//            wordError(title: "Word not possible", message: "That isn't a real word.")
            return
        }
        usedWords.insert(answer, at: 0)
        newWord = ""
    }
    
    func startNewGame() {
        //1. find the url path for start.txt
        if let fileUrl = Bundle.main.url(forResource: "start", withExtension: "txt") {
            // 2. load all contents of start.txt into a string
            if let words = try? String(contentsOf: fileUrl) {
               // 3. spit the string into an array of strings.
                let allwords = words.components(separatedBy: .whitespacesAndNewlines)
                // pick a random string from the array or pick silkworm as default
                rootWord = allwords.randomElement() ?? "silkworm"
                usedWords.removeAll()
                letterCount = 0
                
                return
            }
        }
        fatalError("Could not load start.txt from bundle.")
    }
    
    func isOriginal(word : String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word : String) -> Bool {
        var tempWord = rootWord
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter)
            {
                tempWord.remove(at: pos)
            }
            else
            {
                return false
            }
        }
        return true
    }
    
    func isReal(word : String) -> Bool {
        if word.count > 2 {
            if word == rootWord {
                wordError(title: "Same words", message: "The answer can not be same as scramble word")
                return false
            }
            else {
                let checker = UITextChecker()
                let range = NSRange(location: 0, length: word.utf16.count)
                let misspelledword = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
                
                if misspelledword.location == NSNotFound {
                    letterCount += word.count
                     return true
                }
                else
                {
                    wordError(title: "Word not possible", message: "That isn't a real word.")
                    return false
                }
            }
        }
        else
        {
            wordError(title: "shorter than 3 letters", message: "The word entered must not be shorter than 3 letters")
            return false
        }
        
    }
    
    func wordError(title: String, message : String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
