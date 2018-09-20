//
//  DataService.swift
//  A3
//
//  Created by Руслан Ахриев on 18.09.2018.
//  Copyright © 2018 Руслан Ахриев. All rights reserved.
//

import Foundation
import UIKit

let USERS_URL = "https://jsonplaceholder.typicode.com/users"
let ALBUM_URL = "https://jsonplaceholder.typicode.com/albums"
let PHOTO_URL = "https://jsonplaceholder.typicode.com/photos"
class DataService {
    
    static let instance = DataService()
    let imageCache = NSCache<AnyObject, AnyObject>()
    
    func getUsers (complition: @escaping ([User])->()) {
        guard let url = URL(string: USERS_URL) else { return }
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    let users = try JSONDecoder().decode([User].self, from: data)
                    complition(users)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
    
    func getAlbumsOfUser (userId : Int , complition: @escaping ([Album])->()) {
        var albums = [Album]()
        guard let url = URL(string: ALBUM_URL) else { return }
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    let albumsInstance = try JSONDecoder().decode([Album].self, from: data)
                    for album in albumsInstance {
                        if album.userId == userId {
                            albums.append(album)
                        }
                    }
                    complition(albums)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
    
    func getPhotoOfUser ( albums : [Album], complition: @escaping ([Photo])->()) {

        var photos = [Photo]()
        guard let url = URL(string: PHOTO_URL) else { return }
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    let photoInstance = try JSONDecoder().decode([Photo].self, from: data)
                    for photo in photoInstance {
                        for album in albums {
                            if photo.albumId == album.id {
                                photos.append(photo)
                            }
                        }
                    }
                    complition(photos)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
}
