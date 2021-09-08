//
//  Alert.swift
//  Baluchon
//
//  Created by Ludovic DANGLOT on 07/09/2021.
//

import UIKit

extension UIViewController {

    
    func didAlert(message: String) {
        let alertVC = UIAlertController(title: "Zéro!", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return self.present(alertVC, animated: true, completion: nil)
    }

}
