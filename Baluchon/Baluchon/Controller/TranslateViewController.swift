//
//  translateViewController.swift
//  Baluchon
//
//  Created by Ludovic DANGLOT on 25/08/2021.
//

import UIKit

class TranslateViewController: UIViewController {
    
    // MARK: - @IB Outlet

    @IBOutlet weak var texViewtToTranslate: UITextView!
    @IBOutlet weak var resultTranslateTextView: UITextView!
    
    // MARK: - Properties
    
    let translate = TranslateService()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - @IB Action
    
    //Call to the API to do the translate
    @IBAction func getTranslate(_ sender: UIButton) {
        sender.isEnabled = false
        translate.getTranslate(textToTranslate: texViewtToTranslate.text) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let translateData) :
                    self?.resultTranslateTextView.text = translateData.data.translations[0].translatedText
                case .failure(let error):
                    print(error)
                    self?.didAlert(message: "Erreur de chargement des données")
                }
                sender.isEnabled = true
            }
        }
    }
    
    
    @IBAction func dissmissKeyboard(_ sender: UITapGestureRecognizer) {
        texViewtToTranslate.resignFirstResponder()
    }
    
    // clear the text
    @IBAction func clearButton(_ sender: Any) {
        texViewtToTranslate.text = ""
        resultTranslateTextView.text = ""
    }
}



