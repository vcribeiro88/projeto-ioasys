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
    @IBOutlet weak var companiesCollectionView: UICollectionView!
    
    var enterprises = [Enterprise]()
    var filteredCompanies: [Enterprise] = []
    
    var webService = WebService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchEnterprises()
        
        searchBar.searchTextField.backgroundColor = UIColor(named: "textFieldBg")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func fetchEnterprises() {
        webService.get { (enterprises) in
            DispatchQueue.main.async {
                self.enterprises = enterprises
                print("Enterprises: \(enterprises)")
                self.companiesCollectionView.reloadData()
            }
        }
    }

}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredCompanies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let companyCell = companiesCollectionView.dequeueReusableCell(withReuseIdentifier: "companyCell", for: indexPath) as! CompanyCollectionViewCell
        
        companyCell.layer.cornerRadius = 4
        companyCell.companyNameLabel.text = filteredCompanies[indexPath.row].enterprise_name
        companyCell.companyLogoImage.image = UIImage(named: filteredCompanies[indexPath.row].photo)
        
        return companyCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "companySegue" {
                let companyDetailViewController = segue.destination as! CompanyDetailViewController
                companyDetailViewController.navigationController?.title = enterprises[indexPath.row].enterprise_name
            }
        }
    }
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = companiesCollectionView.frame.size
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
        companiesCollectionView.layer.position.y -= 50
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text!.isEmpty {
            filteredCompanies = []
            companiesCollectionView.reloadData()
        }
        
        filteredCompanies = enterprises.filter({$0.enterprise_name.lowercased().unaccent().contains(searchBar.text!.lowercased().unaccent())})
        
        companiesCollectionView.reloadData()
    }
}


//({$0.lowercased().folding(options: .diacriticInsensitive, locale: .current).contains(searchBar.text!.lowercased().folding(options: .diacriticInsensitive, locale: .current))})
