//
//  ViewModel.swift
//  BostaAssessment
//
//  Created by Adham Samer on 28/02/2023.
//

import Foundation
class ViewModel {
    var bindAlbumsToHomeVC: (() -> Void) = {}
    var bindUserToHomeVC: (()->Void) = {}
    var bindPhotosToAlbumVC: (()->Void) = {}
    var user: User? {
        didSet{
            bindUserToHomeVC()
        }
    }
    var albums: [Album] = [] {
        didSet {
            bindAlbumsToHomeVC()
        }
    }
    var photos: [Photo] = [] {
        didSet{
            bindPhotosToAlbumVC()
        }
    }
    
    
    func getUser(id:Int) {
        NetworkService.fetchUser(id: id) { result in
            self.user = result
        }
    }
    func getAlbums(userID:Int) {
        NetworkService.fetchAlbums(userID: userID) { result in
            self.albums = result ?? []
        }
    }
    func getPhotos(albumId:Int) {
        NetworkService.fetchPhotos(albumID: albumId) { result in
            self.photos = result ?? []
        }
    }
}

