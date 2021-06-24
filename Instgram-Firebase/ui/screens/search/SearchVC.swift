//
//  SearchVC.swift
//  Instgram-Firebase
//
//  Created by Mahmoud Elattar on 22/06/2021.
//  Copyright © 2021 ITI. All rights reserved.
//

import UIKit
import Firebase

final class SearchVC: UIViewController {
    @IBOutlet private weak var searchBarContainer: UIView!
    
    @IBOutlet private weak var usersTableView: UITableView!{
        didSet{
            usersTableView.delegate = self
            usersTableView.dataSource = self
        }
    }
    private let searchController = UISearchController(searchResultsController: nil)
    var users : [User] = []
    var filteredUsers = [User]()
    override func viewDidLoad() {
        super.viewDidLoad()
      registerCell()
       setUpSearchBar()
        fetchAllUsers()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        searchController.isActive = false
//navigationController?.navigationBar.topItem?.title = "some title"
    }
    fileprivate func registerCell(){
        let nipName = UINib(nibName: UserTableViewCell.identifier, bundle: nil)
        usersTableView.register(nipName, forCellReuseIdentifier: UserTableViewCell.identifier)
    }

    fileprivate func fetchAllUsers(){
      let reference =  Database.database().reference().child("users")
            reference.observe(.value) { snapShot in
            
            guard let response = snapShot.value as? [String : [String:Any]] else {return}
            for (_,value) in response{
                print("rrrrr->>>>\(value["userName"] as! String)")
            }
        }
        
        reference.observeSingleEvent(of: .value) {[weak self]snapShot in
            guard let self = self else {return}
            guard let dictionaries = snapShot.value as? [String : Any] else {return}
            for (key,value) in dictionaries{
                guard let userDictionary = value as? [String:Any] else {return}
                let user = User(uid: key, dictionary: userDictionary)
                self.users.append(user)
                
            }
            self.users.sort {
                $0.userName.compare($1.userName) == .orderedAscending
            }
            self.filteredUsers = self.users
            self.usersTableView.reloadData()
        } withCancel: { error in
            print("failed due to",error)
        }

        
        
        
        
        
        
    }
    
    
}
extension SearchVC : UISearchControllerDelegate{
    
    fileprivate func setUpSearchBar(){
        searchController.delegate = self
        searchController.searchBar.delegate = self
       searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search for a user"
        searchController.searchBar.translatesAutoresizingMaskIntoConstraints = true

        searchController.searchBar.barTintColor = UIColor.colorWithRGB(red: 230, green: 230, blue: 230)
        
        searchController.searchBar.autoresizingMask = [.flexibleWidth]
        searchBarContainer.addSubview(searchController.searchBar)
        searchController.searchBar.frame = searchBarContainer.bounds
        definesPresentationContext = true
        extendedLayoutIncludesOpaqueBars = true
        if #available(iOS 13.0, *) {
            searchController.searchBar.searchTextField.accessibilityIdentifier = "User Search"
        }
    }
    
    
    
    
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("searchBarSearchButtonClicked")
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        searchController.isActive = false
       // viewModel.didSearch(query: searchText)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("searchBarCancelButtonClicked")
    }
    
}

extension SearchVC : UISearchBarDelegate{
    public func willPresentSearchController(_ searchController: UISearchController) {
        print("willPresentSearchController")
    }

    public func willDismissSearchController(_ searchController: UISearchController) {
        self.filteredUsers = self.users
        self.usersTableView.reloadData()
        print("willDismissSearchController")
    }

    public func didDismissSearchController(_ searchController: UISearchController) {
        print("didDismissSearchController")}
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("searchBarTextDidBeginEditing")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.filteredUsers = self.users
        }
        else{
            filteredUsers = users.filter{$0.userName.lowercased().contains(searchText.lowercased())}
        }
        
        self.usersTableView.reloadData()
    print("textDidChange")
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("searchBarTextDidEndEditing")
    }
}

extension SearchVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  filteredUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier, for: indexPath) as? UserTableViewCell else{
            return UITableViewCell()
        }
        cell.user = filteredUsers[indexPath.row]
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
   
}
