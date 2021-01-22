//
//  User.swift
//  Projeto ioasys
//
//  Created by Vinícius de Oliveira on 21/01/21.
//

import Foundation

struct User: Codable {
    public var email: String
    public var password: String
    public var uid: String
    public var token: String
    public var client: String
}
