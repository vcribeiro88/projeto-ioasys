//
//  HomeViewController.swift
//  Projeto ioasys
//
//  Created by Vinícius de Oliveira on 20/01/21.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var enterprisesCollectionView: UICollectionView!
    
    var enterprises = [Enterprise]()
    var filteredEnterprises: [Enterprise] = []
    
    var webService = WebService()
    
    var headerLogin: [String : String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchEnterprises()
        
        searchBar.searchTextField.backgroundColor = UIColor(named: "textFieldBg")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "enterpriseDetailSegue" {
            
            guard let indexPath = enterprisesCollectionView.indexPathsForSelectedItems?.first else {return}
            
            let enterpriseDetailViewController = segue.destination as! EnterpriseDetailViewController
            enterpriseDetailViewController.currentEnterprise = filteredEnterprises[indexPath.row]
        }
    }
    
    func fetchEnterprises() {
        webService.get(token: headerLogin["token"]!, client: headerLogin["client"]!, uid: headerLogin["uid"]!) { (enterprises) in
            DispatchQueue.main.async {
                self.enterprises = enterprises
                print("Enterprises: \(enterprises)")
                self.enterprisesCollectionView.reloadData()
            }
        }
    }

}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredEnterprises.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let enterpriseCell = enterprisesCollectionView.dequeueReusableCell(withReuseIdentifier: "enterpriseCell", for: indexPath) as! EnterprisesCollectionViewCell
        
        enterpriseCell.layer.cornerRadius = 4
        enterpriseCell.enterpriseNameLabel.text = filteredEnterprises[indexPath.row].enterprise_name
        enterpriseCell.enterpriseLogoImage.image = UIImage(named: filteredEnterprises[indexPath.row].photo)
        
        return enterpriseCell
    }
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = enterprisesCollectionView.frame.size
        return CGSize(width: size.width - 32, height: 140)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        headerImage.layer.position.y -= 50
        searchBar.layer.position.y -= 50
        enterprisesCollectionView.layer.position.y -= 50
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text!.isEmpty {
            filteredEnterprises = []
            enterprisesCollectionView.reloadData()
        }
        
        filteredEnterprises = enterprises.filter({$0.enterprise_name.lowercased().unaccent().hasPrefix(searchBar.text!.lowercased().unaccent())})
        
        enterprisesCollectionView.reloadData()
    }
}
