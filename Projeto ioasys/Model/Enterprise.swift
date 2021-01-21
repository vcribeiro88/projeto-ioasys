//
//  Enterprise.swift
//  Projeto ioasys
//
//  Created by Vinícius de Oliveira on 21/01/21.
//

import Foundation

struct Enterprise: Codable {
    public var name: String
    
    init(name: String) {
        self.name = name
    }
    
    public static var all: [Enterprise] = [
        Enterprise.init(name: "Empresa X"),
        Enterprise.init(name: "Empresa Y"),
        Enterprise.init(name: "Empresa Z"),
        Enterprise.init(name: "Empresa XZ")
    ]
}
