//
//  UserPhotoCollectionViewCell.swift
//  A3
//
//  Created by Руслан Ахриев on 19.09.2018.
//  Copyright © 2018 Руслан Ахриев. All rights reserved.
//

import UIKit

var imageCache = NSCache<AnyObject, AnyObject>()

class UserPhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var userPhotoImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    func updateCell ( photo : Photo) {
        if let image = imageCache.object(forKey: photo.url! as String as AnyObject) {
            userPhotoImage.image = image as? UIImage
             self.activityIndicator.stopAnimating()
        } else {
            let imageUrl = URL(string: photo.url!)
           
            DispatchQueue.global().async {
                if let imageData = try? Data(contentsOf: imageUrl!) {
                    let image = UIImage(data: imageData)
                    imageCache.setObject(image!, forKey: photo.url! as String as AnyObject)
                    DispatchQueue.main.async {
                        self.userPhotoImage.image = image
                       
                        self.activityIndicator.stopAnimating()
                    }
                }
            }
        }
        titleLabel.text = photo.title
        
    }
    

}
