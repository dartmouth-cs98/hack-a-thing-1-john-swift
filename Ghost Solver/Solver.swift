//
//  Solver.swift
//  Ghost Solver
//

import Foundation

class Solver {
    let dictionaryFile = "words"
    var root:TrieNode = TrieNode("")
    
    func setUp() {
        let lines = getLines()
        root = buildTrie(lines!)
    }
    
    func lookUpWord(word:String) -> [String]? {
        do {
            let results = try root.lookUpWord(word: word)
            return results
        }
        catch GhostSolverError.FinishedWord {
            return ["Finished Word"]
        }
        catch GhostSolverError.NotAWord {
            return ["Not a Word"]
        }
        catch {
            print(error)
        }
        return nil
    }
    
    func getLines() -> [String]! {
        if let path = Bundle.main.path(forResource: dictionaryFile, ofType: "txt") {
            do {
                let data = try String(contentsOfFile: path, encoding: .utf8)
                let myStrings = data.components(separatedBy: "\n")
                return myStrings
            }
            catch {
                print(error)
            }
        }
        return nil
    }
    
    func buildTrie(_ lines:[String]) -> TrieNode {
        let root = TrieNode("")
        for word in lines {
            root.insertWord(word)
        }
        return root
    }
}
