//
//  String+EX.swift
//  NewsTest
//
//  Created by Ahmed Shafik on 03/10/2021.
//

import Foundation
extension String {
    
    // MARK: - Replacing a String with a new String
    func replacement(_ of : String, _ with : String) -> String {
        
        return self.replacingOccurrences(of: of, with: with)
    }
}
