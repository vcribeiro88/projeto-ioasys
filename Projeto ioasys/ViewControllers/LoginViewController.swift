//
//  LoginViewController.swift
//  Projeto ioasys
//
//  Created by Vinícius de Oliveira on 21/01/21.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    var auth = AuthenticationService()
    var userDataLogin: [String : String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        emailTextField.text = "testeapple@ioasys.com.br"
        passwordTextfield.text = "12341234"
    }
    
    @IBAction func login(_ sender: Any) {
        auth.login(email: "testeapple@ioasys.com.br", password: "12341234") { [self](headerAccess) in
            userDataLogin = headerAccess
        }
        
        if userDataLogin == [:] {
            print("Credenciais incorretas")
        } else {
            performSegue(withIdentifier: "loginSegue", sender: nil)
        }
    }
    
}
