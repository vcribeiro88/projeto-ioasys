//
//  CompanyModel.swift
//  Projeto ioasys
//
//  Created by Vinícius de Oliveira on 21/01/21.
//

import Foundation

struct Company: Decodable {
    public var name: String
    
    init(name: String) {
        self.name = name
    }
    
    public static var all: [Company] = [
        Company.init(name: "Empresa X"),
        Company.init(name: "Empresa Y"),
        Company.init(name: "Empresa Z"),
        Company.init(name: "Empresa XZ")
    ]
}
