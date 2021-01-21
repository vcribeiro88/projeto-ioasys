//
//  String extension.swift
//  Projeto ioasys
//
//  Created by Vinícius de Oliveira on 21/01/21.
//

import Foundation

extension String {
    public func unaccent() -> String {

        return self.folding(options: .diacriticInsensitive, locale: .current)

    }
}
