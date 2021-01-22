//
//  AuthenticationService.swift
//  Projeto ioasys
//
//  Created by Vinícius de Oliveira on 21/01/21.
//

import Foundation

class AuthenticationService {
    
    var session: URLSession!
    public let url = URL(string: "https://empresas.ioasys.com.br/api/v1/users/auth/sign_in")!
    
    init() {
        self.session = URLSession.shared
    }
    
    func login(email: String, password: String, completion: @escaping ([String : String]) -> Void) {
        var request = URLRequest(url: self.url)
        
        let userDict: [String : String] = ["email" : email, "password" : password]
        
        request.setValue("application/json", forHTTPHeaderField: "Content-type")
        request.httpMethod = "POST"
        
        guard let json = try? JSONEncoder().encode(userDict) else { return }
        
        let uploadTask = URLSession.shared.uploadTask(with: request, from: json) {(data, response, error) in
            

            
            if let _ = error {
                completion([:])
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                
                if (200...299).contains(httpResponse.statusCode) {
                    
                    let tokenResponse = httpResponse.value(forHTTPHeaderField: "access-token")
                    let clientResponse = httpResponse.value(forHTTPHeaderField: "client")
                    let uidResponse = httpResponse.value(forHTTPHeaderField: "uid")
                    
                    print("token : \(tokenResponse!), client : \(clientResponse!), uid: \(uidResponse!)")
                    
                    completion(["token" : tokenResponse!, "client" : clientResponse!, "uid": uidResponse!])
                } else {
                    completion([:])
                    return
                }
            }
        }
        uploadTask.resume()
    }

}


