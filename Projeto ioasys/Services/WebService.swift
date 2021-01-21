//
//  WebService.swift
//  Projeto ioasys
//
//  Created by Vinícius de Oliveira on 21/01/21.
//

import Foundation

class WebService {
    var session: URLSession!
    let url = URL(string: "https://empresas.ioasys.com.br/api/v1/enterprises?enterprise_types=1&name=aQm")!
    
    init() {
        self.session = URLSession.shared
    }
    
    func get(completion: @escaping ([Enterprise]) -> Void) {
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completion([])
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion([])
                return
            }
            guard let json = data else {
                completion([])
                return
            }
            
            do {
                let enterprises = try JSONDecoder().decode([Enterprise].self, from: json)
                completion(enterprises)
            } catch {
                print(error)
                completion([])
            }
        }
        dataTask.resume()
    }
    
}
