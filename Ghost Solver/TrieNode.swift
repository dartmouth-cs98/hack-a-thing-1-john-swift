//
//  TrieNode.swift
//  Ghost Solver
//
//  Created by John Schlachtenhaufen on 9/21/19.
//  Copyright © 2019 JohnSchlachtenhaufen. All rights reserved.
//

import Foundation

class TrieNode : NSObject {
    var value:String
    var children = Array<TrieNode>()
    
    init(_ value:String) {
        self.value = value
    }
    
    private func isLeaf() -> Bool {
        return children.isEmpty
    }
    
    func insertWord(_ word:String) {
        insertWordHelper(word, 0)
    }
    
    private func insertWordHelper(_ word:String, _ depth:Int) {
        if word.count == 0 {
            return
        }
        let value =  "\(word[word.startIndex])"
        let node = TrieNode(value)
        if children.contains(node) {
            if children[children.index(of: node)!].isLeaf() && depth > 2 {
                return
            }
        }
        else {
            children.append(node)
        }
        
        let index = word.index(word.startIndex, offsetBy: 1)
        children[children.index(of: node)!].insertWordHelper(word.substring(from: index), depth + 1)
    }
    
    func lookUpWord(word:String) throws -> [String] {
        if let resultRoot = try? findResultRoot(word:word) {
            var results = [String]()
            if resultRoot.isLeaf() {
                throw GhostSolverError.FinishedWord
            }
            resultRoot.traverse(list:&results, word:word)
            return results
        }
        else {
            throw GhostSolverError.NotAWord
        }
    }
    
    private func findResultRoot(word:String) throws -> TrieNode {
        let char = word[word.startIndex]
        let node = TrieNode("\(char)")
        if !children.contains(node) {
            throw GhostSolverError.NotAWord
        }
        else {
            if word.count == 1 {
                return children[children.index(of: node)!]
            }
            else {
                let index = children.index(of: node)!
                let child = children[index]
                let newWord = word.substring(from: word.index(word.startIndex, offsetBy: 1))
                if let newRoot =  try? child.findResultRoot(word: newWord) {
                    return newRoot
                }
                else {
                    throw GhostSolverError.NotAWord
                }
            }
        }
    }
    
    private func traverse(list: inout [String], word:String) {
        if list.count > 5 {
            return
        }
        if isLeaf() && word.count > 3 {
            list.append(word)
        }
        else {
            for child in children {
                child.traverse(list: &list, word:word + child.value)
            }
        }
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        return value == (object as! TrieNode).value
    }
    
    override var hash: Int {
        return value.hashValue
    }
    
}

