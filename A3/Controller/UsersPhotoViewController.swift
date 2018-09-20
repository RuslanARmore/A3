//
//  UsersPhotoViewController.swift
//  A3
//
//  Created by Руслан Ахриев on 19.09.2018.
//  Copyright © 2018 Руслан Ахриев. All rights reserved.
//

import UIKit

class UsersPhotoViewController: UIViewController ,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var collectionView: UICollectionView!
    var user : User!
    var albums = [Album]()
    var photo = [Photo]()
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
    
        downloadData()
        // Do any additional setup after loading the view.
    }
    
    func downloadData() {
        DataService.instance.getAlbumsOfUser(userId: user.id!) { (request) in
            self.albums = request
            DataService.instance.getPhotoOfUser(albums: self.albums) { (request2) in
                self.photo = request2
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }

        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photo.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserPhotoCell", for: indexPath) as? UserPhotoCollectionViewCell {
            cell.activityIndicator.hidesWhenStopped = true
            cell.activityIndicator.startAnimating()
            cell.updateCell(photo: photo[indexPath.row])
            
            cell.contentView.layer.cornerRadius = 2.0
            cell.contentView.layer.borderWidth = 1.0
            cell.contentView.layer.borderColor = UIColor.clear.cgColor
            cell.contentView.layer.masksToBounds = true;
            
            cell.layer.shadowColor = UIColor.lightGray.cgColor
            cell.layer.shadowOffset = CGSize(width:0,height: 2.0)
            
            cell.layer.shadowRadius = 2.0
            cell.layer.shadowOpacity = 1.0
            cell.layer.masksToBounds = false;
            cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath


            return cell
        }
        return UICollectionViewCell()
    }
    
    
}
