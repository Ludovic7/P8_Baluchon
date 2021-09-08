//
//  ViewController.swift
//  Baluchon
//
//  Created by Ludovic DANGLOT on 30/07/2021.
//

import UIKit

class ConverterViewController: UIViewController {
    
   
    
    // MARK: - @IB Outlet

    @IBOutlet weak var textField: UITextField!

    @IBOutlet weak var dollarsLabel: UILabel!
    
    // MARK: - Properties
    
    private let converter = ConverterService()
    
    // MARK: - @IB Action
    
    // make the keyboard disappear
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textField.resignFirstResponder()
    }
    
    //Call to the API to do the conversion
        @IBAction func tappedButtonValidate(_ sender: Any) {
        converter.getConverter { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let rate) :
                    guard let textCorrect = self?.textField.text else {
                        return
                    }
                    guard let doubleCorrect = Double(textCorrect) else {
                        return
                    }
                    self?.dollarsLabel.text = "\(doubleCorrect*rate)"
                case .failure(let error):
                    print(error)
                    self?.didAlert(message: "Erreur de chargement des données")
            }
            }
        }
    }
    
}

