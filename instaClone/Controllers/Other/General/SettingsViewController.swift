//
//  SettingsViewController.swift
//  instaClone
//
//  Created by Vinicius Bruno on 19/08/21.
//

import SafariServices
import UIKit

struct SettingCellModel {
    let title: String
    let handler: (() -> Void)
}

///view controler to show user settings
class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    

    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self , forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private var data = [[SettingCellModel]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureModels()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView )
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func configureModels(){
        data.append([
            SettingCellModel(title: "Edit Profile"){ [weak self] in
                self?.didTapEditProfile()
            },
            SettingCellModel(title: "Invite Friends"){ [weak self] in
                self?.didTapInviteFriends()
            },
            SettingCellModel(title: "Save Original Posts"){ [weak self] in
                self?.didTapSaveOriginalPosts()
            }
        ])
        
        data.append([
            SettingCellModel(title: "Terms of Service"){ [weak self] in
                self?.openURL(type: .terms)
            },
            SettingCellModel(title: "Privacy Politic"){ [weak self] in
                self?.openURL(type: .privacy)
            },
            SettingCellModel(title: "Help/Feedback"){ [weak self] in
                self?.openURL(type: .help)
            }
        ])
        
        data.append([
            SettingCellModel(title: "Log Out"){ [weak self] in
                self?.didTapLogOut()
            }
        ])
    }
    
    enum SettingsURLType{
        case terms, privacy, help
    }
    
    private func openURL(type: SettingsURLType){
        let urlString: String
        switch type {
        case .terms: urlString = "https://help.instagram.com/581066165581870"
        case .privacy: urlString = "https://help.instagram.com/519522125107875"
        case .help: urlString = "https://help.instagram.com"
        }
        
        guard let url = URL(string: urlString)else{
            return
        }
        
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    private func didTapSaveOriginalPosts(){
        
    }
    
    private func didTapInviteFriends(){
        
    }
    
    private func didTapEditProfile(){
        let vc = EditProfileViewController()
        vc.title = "Edit Profile"
        let navVc = UINavigationController(rootViewController: vc)
        navVc.modalPresentationStyle = .fullScreen
        present(navVc, animated: true)
        
    }
    
    
    private func didTapLogOut(){
        let actionSheet = UIAlertController(title: "Log Out", message: "Are you sure you want to log out?", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { _ in
            AuthManager.shared.logOut(completion: {success in
                DispatchQueue.main.async {
                    if success{
                        let loginVc = LoginViewController()
                        loginVc.modalPresentationStyle = .fullScreen
                        self.present(loginVc, animated: true){
                            self.navigationController?.popToRootViewController(animated: false)
                            self.tabBarController?.selectedIndex = 0
                        }
                    }else{
                        //error occurred
                        fatalError("Could not log out user")
                    }
                }
            })
        }))
        actionSheet.popoverPresentationController?.sourceView = tableView
        actionSheet.popoverPresentationController?.sourceRect = tableView.bounds

        present(actionSheet, animated: true)
        
    }

}

extension SettingsViewController {
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        data[indexPath.section][indexPath.row].handler()
    
    }
}
