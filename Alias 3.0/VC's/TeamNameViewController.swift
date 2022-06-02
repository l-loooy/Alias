//
//  TeamNameViewController.swift
//  Alias 3.0
//
//  Created by admin on 05.05.2022.
//  Copyright © 2022 Sergey Lolaev. All rights reserved.
//

import UIKit

protocol RegistrateTeam {
    func addTeamToTableView(_ teamName: String)
}


class TeamNameViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    var delegate: RegistrateTeam?
    var teamName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        textField.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func sendTeamNameToTable(_ sender: UIButton) {
        if delegate == nil {
            print("nil value")
        } else {
            //если с делегатом все норм, то он добавит команду из textField в tableView
            delegate?.addTeamToTableView(teamName)
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let avatarVC =  storyboard.instantiateViewController(withIdentifier: "AvatarViewControllerID") as! AvatarViewController
            
             //сейчас надо прыгнуть до RegistrationVC. через TextFieldVc
            avatarVC.didTapDoneButtonAction = { [weak self] in
                self?.dismiss(animated: false)
            }
            
            if let registrationVC = delegate as? AddSelectedAvatarToTableView {
                avatarVC.delegate = registrationVC
            }
            present(avatarVC, animated: true, completion: nil)

        }
    }
}


// MARK: - UITextFieldDelegate
extension TeamNameViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text == "" {
            textField.placeholder = "Введите имя своей команды"
        } else {
            teamName = textField.text!
            print(teamName)
            //отклоняем клавиатуру после нажатия кнопки return
            textField.endEditing(true)
        }
        return true
    }
}
