//
//  RegistrationViewController.swift
//  Alias 3.0
//
//  Created by admin on 05.05.2022.
//  Copyright © 2022 Sergey Lolaev. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {

    
    var teamsArray = [String]()
    var avatarsForTable = [UIImage]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @IBAction func goToTextField(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let teamNameViewController =  storyboard.instantiateViewController(withIdentifier: "TeamNameViewControllerID") as! TeamNameViewController
        teamNameViewController.delegate = self
        present(teamNameViewController, animated: true, completion: nil)
    }
}

// MARK: - RegistrateTeam
extension RegistrationViewController: RegistrateTeam {
    func addTeamToTableView(_ teamName: String) {
        teamsArray.append(teamName)
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate
extension RegistrationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(teamsArray[indexPath.row])
    }
    
//Задает высоту ячейки
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
  
//Удаляем ячейки
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            teamsArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
}

// MARK: - UITableViewDataSource

extension RegistrationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        teamsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        if let teamName = teamsArray[safe: indexPath.row] {
            cell.textLabel?.text = teamName
            
        }
        
        if let image = avatarsForTable[safe: indexPath.row] {
            cell.imageView?.image = avatarsForTable[safe: indexPath.row]
        }
        
        return cell
    }
}

// MARK: - AddSelectedAvatarToTableView
extension RegistrationViewController: AddSelectedAvatarToTableView {
    func addThisAvatar(_ avatar: UIImage) {
        avatarsForTable.append(avatar)
        //обновляю таблицу после добавления аватара
        tableView.reloadData()
    }

}

// что-то страшное
extension Array {
    subscript (safe index: Index) -> Element? {
        0 <= index && index < count ? self[index] : nil
    }
}
