//
//  User.swift
//  BostaAssessment
//
//  Created by Adham Samer on 28/02/2023.
//

import Foundation

class User: Decodable {
    var id: Int?
    var name: String?
    var username: String?
    var email: String?
    var address: Address?
}

class Address: Decodable {
    var street: String?
    var suite: String?
    var city: String?
    var zipcode: String?
}

