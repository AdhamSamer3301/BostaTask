//
//  FetchProtocols.swift
//  BostaAssessment
//
//  Created by Adham Samer on 28/02/2023.
//

import Foundation
protocol GET_ALBUMS {
    static func fetchAlbums(userID: Int, completionHandler: @escaping ([Album]?) -> Void)
}

protocol GET_PHOTOS {
    static func fetchPhotos(albumID: Int, completionHandler: @escaping ([Photo]?) -> Void)
}

protocol GET_USER {
    static func fetchUser(id:Int,completionHandler: @escaping (User?) -> Void)
}
