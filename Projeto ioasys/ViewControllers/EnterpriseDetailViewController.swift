//
//  EnterpriseDetailViewController.swift
//  Projeto ioasys
//
//  Created by Vinícius de Oliveira on 21/01/21.
//

import UIKit

class EnterpriseDetailViewController: UIViewController {
    
    @IBOutlet weak var enterpriseLogo: UIImageView!
    @IBOutlet weak var enterpriseDescription: UITextView!
    @IBOutlet weak var enterpriseName: UILabel!
    
    var selectedEnterprise: Enterprise!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationItem.title = selectedEnterprise.enterprise_name
        
        enterpriseName.text = selectedEnterprise.enterprise_name
        enterpriseDescription.text = selectedEnterprise.description
    }
}
