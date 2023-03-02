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
}

