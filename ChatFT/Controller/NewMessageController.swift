//
//  NewMessageController.swift
//  ChatFT
//
//  Created by Pranav Badgi on 11/04/20.
//  Copyright © 2020 Pranav Badgi. All rights reserved.
//

import UIKit

private let reuseIdentifier = "UserCell"


//which ever controller uses this protocol has to be conformed to this func everytime
//this is used to get the clicked user from newmessage and send them to conversations controller
protocol NewMessageControllerDelegate: class {
    func controller(_ controller: NewMessageController, wantsToStartChatWith user: User)
}

class NewMessageController: UITableViewController {
 
    //Pranav:- properties
    private var users = [User]()
    private var filteredUsers = [User]()
    private var inSearchMode: Bool {
        return searchController.isActive && !searchController.searchBar.text!.isEmpty
    }
    //we are setting this delegate to conversationscontroller 
    weak var delegate: NewMessageControllerDelegate?
    private let searchController = UISearchController(searchResultsController: nil)
    
    
    //Pranav:- Lifecyccle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureSearchController()
        fetchUsers()
    }
    
    //Pranav: - Selectors
    
    @objc func handleDismissal() {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    //Pranav: - API
    
    func fetchUsers() {
        showLoader(true)
        Service.fetchUSers { users in
            self.showLoader(false)
            self.users = users
            self.tableView.reloadData()
        }
    }
    
    //Pranav:- Helpers
    func configureUI() {
        configureNavigationbar(withTitle: "New Message", prefersLargeTitles: false)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleDismissal))
        tableView.tableFooterView = UIView()
        tableView.register(UserCell.self, forCellReuseIdentifier: reuseIdentifier )
        tableView.rowHeight = 80
        
    }
    
    
    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.showsCancelButton = false
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search user"
        definesPresentationContext = false
        
        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textField.textColor = .systemPurple
            textField.backgroundColor = .white
        }
    }

}

extension NewMessageController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inSearchMode ?  filteredUsers.count : users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! UserCell
        
        cell.user = inSearchMode ?  filteredUsers[indexPath.row] : users[indexPath.row]
        return cell
    }
    
    
}
  
//this extension is conformed to conversations controller with the help of a protocol
extension NewMessageController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = inSearchMode ? filteredUsers[indexPath.row] : users[indexPath.row]
        delegate?.controller(self, wantsToStartChatWith: user)
    
    }
}

extension NewMessageController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchtext = searchController.searchBar.text?.lowercased() else { return }
        filteredUsers = users.filter({ user -> Bool in
            return user.username.contains(searchtext) || user.fullname.contains(searchtext)
        })
        self.tableView.reloadData()

    }
}
