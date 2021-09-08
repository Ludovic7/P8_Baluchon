//
//  String+Data.swift
//  Baluchon
//
//  Created by Ludovic DANGLOT on 06/09/2021.
//

import Foundation

// MARK: - Extension

// String became Data
extension String {
    var data : Data? {
        guard let url = URL(string: self) else { return nil}
        guard let data = try? Data(contentsOf: url) else {return nil}
        return data
    }
}
