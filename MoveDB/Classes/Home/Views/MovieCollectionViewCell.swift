//
//  MovieCollectionViewCell.swift
//  MoveDB
//
//  Created by Ahmed Shafik on 02/01/2022.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var moviePosterImgeView: UIImageView!
    @IBOutlet weak var movieTitleLb: UILabel!
    
    static let reuseIdentifier = "MovieCollectionViewCell"
    
    var item: MoviesPresentationDTO? {
        didSet{
            guard let obj = item else {return}
            self.movieTitleLb.text = obj.movieTitle
            self.moviePosterImgeView.setImage(imageUrl: obj.posterImgeString)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
