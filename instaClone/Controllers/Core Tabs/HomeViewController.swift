//
//  ViewController.swift
//  instaClone
//
//  Created by Vinicius Bruno on 19/08/21.
//

import FirebaseAuth
import UIKit

class HomeViewController: UIViewController {

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(IGFeedPostTableViewCell.self, forCellReuseIdentifier: IGFeedPostTableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        handleNotAuthenticated()
        
        
       
        
    }
    private func handleNotAuthenticated(){
        //verificar status de autenticação
        
        if Auth.auth().currentUser == nil{
            //show log in
            let loginVc = LoginViewController()
            loginVc.modalPresentationStyle = .fullScreen
            
            present(loginVc, animated: false)
            
        }
    }
    
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identifier, for: indexPath) as!
            IGFeedPostTableViewCell
        
        return cell
    }
}
