//
//  EnterpriseDetailViewController.swift
//  Projeto ioasys
//
//  Created by Vinícius de Oliveira on 21/01/21.
//

import UIKit

class EnterpriseDetailViewController: UIViewController {
    
    @IBOutlet weak var enterpriseLogo: UIImageView!
    @IBOutlet weak var enterpriseName: UILabel!
    
    var currentEnterprise: Enterprise!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        enterpriseLogo.image = UIImage(named: currentEnterprise.photo)
        enterpriseName.text = currentEnterprise.enterprise_name
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}
