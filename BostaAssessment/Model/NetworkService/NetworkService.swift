//
//  NetworkService.swift
//  BostaAssessment
//
//  Created by Adham Samer on 28/02/2023.
//

import Alamofire
import Foundation
class NetworkService: GET_ALBUMS, GET_PHOTOS, GET_USER {
    static func fetchUser(id: Int, completionHandler: @escaping (User?) -> Void) {
        let url = "https://jsonplaceholder.typicode.com/users/\(id)"
        AF.request(url)
            .responseDecodable(of: User.self) { response in
                guard let response = response.value else {
                    return
                }
                completionHandler(response)
            }
    }

    static func fetchAlbums(userID: Int, completionHandler: @escaping ([Album]?) -> Void) {
        let url = "https://jsonplaceholder.typicode.com/albums?=\(userID)"
        let request = NSURLRequest(url: URL(string: url)!)
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: request as URLRequest) { data, _, error in
            guard let data = data else {
                completionHandler(nil)
                return
            }
            do {
                let json = try JSONDecoder().decode([Album]?.self, from: data)
                completionHandler(json)
            } catch {
                print(String(describing: error))
                completionHandler(nil)
            }
        }
        dataTask.resume()
    }

    static func fetchPhotos(albumID: Int, completionHandler: @escaping ([Photo]?) -> Void) {
        let url = "https://jsonplaceholder.typicode.com/photos?albumId=\(albumID)"
        
        AF.request(url).response { response in
            switch response.result {
                case .success(let data):
                    do{
                        let json = try JSONDecoder().decode([Photo]?.self, from: data!)
                        completionHandler(json)
                    }catch{
                        print(String(describing: error))
                        completionHandler(nil)
                    }
                case .failure(let error):
                    print(String(describing: error))
                    completionHandler(nil)
            }
        }
    }
}
