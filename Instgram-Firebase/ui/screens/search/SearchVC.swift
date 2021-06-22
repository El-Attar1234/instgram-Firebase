//
//  SearchVC.swift
//  Instgram-Firebase
//
//  Created by Mahmoud Elattar on 22/06/2021.
//  Copyright © 2021 ITI. All rights reserved.
//

import UIKit

final class SearchVC: UIViewController {
    @IBOutlet private weak var searchBarContainer: UIView!
    
    @IBOutlet private weak var usersTableView: UITableView!
    private let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    

    fileprivate func setUpSearchBar(){
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchBarContainer.addSubview(searchController.searchBar)
    }
    
    
}
extension SearchVC : UISearchControllerDelegate{
    
}

extension SearchVC : UISearchBarDelegate{
    
}
