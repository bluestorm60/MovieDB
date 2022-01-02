//
//  Constants.swift
//  MoveDB
//
//  Created by Ahmed Shafik on 01/01/2022.
//

import Foundation
import UIKit


let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

var token = "0db92b81f2fa71d09358ddd9d4606489"
var MainUrl = "https://api.themoviedb.org"

func addShadowToView(_ view: UIView){
    view.layer.shadowColor = UIColor.lightGray.cgColor
    view.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
    view.layer.shadowRadius = 2.0
    view.layer.shadowOpacity = 0.2
    view.layer.masksToBounds = false
}

func addThickerShadowToView(_ view: UIView){
    view.layer.shadowColor = UIColor.lightGray.cgColor
    view.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
    view.layer.shadowRadius = 7.0
    view.layer.shadowOpacity = 0.5
    view.layer.masksToBounds = false
}


