//
//  ViewController.swift
//  Baluchon
//
//  Created by Ludovic DANGLOT on 30/07/2021.
//

import UIKit

class ConverterViewController: UIViewController {
    
    private let converter = Converter()

    @IBOutlet weak var textField: UITextField!

    @IBOutlet weak var dollarsLabel: UILabel!
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textField.resignFirstResponder()
    }
    
        @IBAction func tappedButtonValidate(_ sender: Any) {
        converter.getConverter { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let rate) :
                    guard let textCorrect = self.textField.text else {
                        return
                    }
                    guard let doubleCorrect = Double(textCorrect) else {
                        return
                    }
                    self.dollarsLabel.text = "\(doubleCorrect*rate)"
                case .failure(let error):
                    print(error)
            }
            }
        }

    
    }
    
}

