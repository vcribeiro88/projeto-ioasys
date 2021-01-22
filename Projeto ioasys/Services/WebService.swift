//
//  WebService.swift
//  Projeto ioasys
//
//  Created by Vinícius de Oliveira on 21/01/21.
//

import Foundation

class WebService {
    var session: URLSession!
    public let url = URL(string: "https://empresas.ioasys.com.br/api/v1/enterprises")!
    
    init() {
        self.session = URLSession.shared
    }
    
    func get(token: String, client: String, uid: String, completion: @escaping ([Enterprise]) -> Void) {
        
        var request = URLRequest(url: self.url)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-type")
        request.setValue("\(token)", forHTTPHeaderField: "access-token")
        request.setValue("\(client)", forHTTPHeaderField: "client")
        request.setValue("\(uid)", forHTTPHeaderField: "uid")
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
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
                let enterprises = try JSONDecoder().decode(EnterpriseList.self, from: json)
                completion(enterprises.enterprises)
            } catch {
                print(error)
                completion([])
            }
        }
        dataTask.resume()
    }
    
}
