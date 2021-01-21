//
//  CompanyDetailViewController.swift
//  Projeto ioasys
//
//  Created by Vinícius de Oliveira on 21/01/21.
//

import UIKit

class CompanyDetailViewController: UIViewController {
    
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}