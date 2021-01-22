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
    @IBOutlet weak var incorrectCredentialsLabel: UILabel!
    @IBOutlet weak var headerImage: UIImageView!
    
    var auth = AuthenticationService()
    var userDataLogin: [String : String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        loginButton.layer.cornerRadius = 8
        headerImage.layer.cornerRadius = 410
        
        self.navigationController?.navigationBar.isHidden = true
        incorrectCredentialsLabel.isHidden = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginSegue" {
            let homeViewController = segue.destination as! HomeViewController
            homeViewController.headerLogin = sender as! [String : String]
        }
    }
    
    @IBAction func login(_ sender: Any) {
        auth.login(email: emailTextField.text!, password: passwordTextfield.text!) { [self](headerAccess) in
            DispatchQueue.main.async {
                userDataLogin = headerAccess
                
                if userDataLogin == [:] {
                    print("Credenciais incorretas")
                    incorrectCredentialsLabel.isHidden = false
                } else {
                    performSegue(withIdentifier: "loginSegue", sender: userDataLogin)
                }
            }
        }
    }
    
}
