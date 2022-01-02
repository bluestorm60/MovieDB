//
//  UIViewController+Extension.swift
//  NewsTest
//
//  Created by Ahmed Shafik on 03/10/2021.
//

import Foundation
import UIKit

extension UIViewController{
    func alert(confirmBtnTitle: String = "confirm",alertTitle: String = "", msg: String = "",completion: @escaping (()->()), cancelCompletion : @escaping (()->())){
        let alert = UIAlertController(title: alertTitle == "" ? nil : alertTitle, message: msg == "" ? nil : msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: confirmBtnTitle, style: .default, handler: { action in
            completion()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            cancelCompletion()
        }))
        self.present(alert, animated: true)
    }
    
    func alert(alertTitle: String = "", msg: String = ""){
        let alert = UIAlertController(title: alertTitle == "" ? nil : alertTitle, message: msg == "" ? nil : msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
        }))
        self.present(alert, animated: true)
    }

}
