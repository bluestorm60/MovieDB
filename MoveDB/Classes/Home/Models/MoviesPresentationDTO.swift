//
//  MoviesPresentationDTO.swift
//  MoveDB
//
//  Created by Ahmed Shafik on 02/01/2022.
//

import Foundation
import UIKit

struct MoviesPresentationDTO{
    let posterImgeString: String
    let movieTitle: String
    init(imgeString: String,title: String) {
        self.movieTitle = title
        self.posterImgeString = imgeString
    }
}
