//
//  UIImageView+Extension.swift
//  NewsTest
//
//  Created by Ahmed Shafik on 03/10/2021.
//

import Foundation
import SDWebImage

extension UIImageView {
    
    
    func setHilightedImage(imageUrl: String){
        self.sd_setHighlightedImage(with: URL(string: imageUrl), options: [], completed: nil)
    }
    
    func setImage(imageUrl: String){
        let newImgeUrl = "https://image.tmdb.org/t/p/w500/\(imageUrl)"
        if let encoded = newImgeUrl.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed){
            self.sd_setImage(with: URL(string: encoded)) { (img, _, _, _) in
                if img != nil{
                    self.image = img
                }else{
                    self.image = UIImage.init(named: "NoImage")
                }
            }
        }else{
            self.sd_setImage(with: URL(string: newImgeUrl)) { (img, _, _, _) in
                if img != nil{
                    self.image = img
                }else{
                    self.image = UIImage.init(named: "NoImage")
                }
            }
        }
    }
}
