//
//  ViewController.swift
//  Ghost Solver
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var tField: UITextField!
    @IBOutlet weak var resultsBox: UILabel!

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if var word = tField.text {
            word = word + string
            word = word.lowercased()
            if word.count == 0 {
                resultsBox.text = "No Results"
            }
            else if let results = appDelegate.lookUpWord(word: word) {
                resultsBox.text = results.description
            }
        }
        else {
            print("Please type in a valid word or phrase")
        }
        return true
    }
}
