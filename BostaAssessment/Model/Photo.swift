//
//  Photo.swift
//  BostaAssessment
//
//  Created by Adham Samer on 01/03/2023.
//

import Foundation
class Photo: Decodable {
    var albumId:Int
    var id:Int
    var title:String
    var url:String
    var thumbnailUrl:String
}
