//
//  UIImageVIew+Extension.swift
//  GetMyCloths
//
//  Created by Ravi Dwivedi on 10/04/23.
//

import UIKit
import Kingfisher


extension UIImageView{
    
    func setImage(with urlString:String){
        guard let url = URL(string:urlString) else {
            return
        }
        let resource = ImageResource(downloadURL: url, cacheKey: urlString)
        kf.indicatorType = .activity
        kf.setImage(with:resource)
    }
}

