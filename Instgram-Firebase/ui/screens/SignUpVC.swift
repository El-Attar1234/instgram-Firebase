//
//  SignUpVC.swift
//  Instgram-Firebase
//
//  Created by Mahmoud Elattar on 4/25/21.
//  Copyright © 2021 ITI. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {
    let profileImageButton :UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "add-profile-image")!.withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    let signupButton :UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 100/255, green: 204/255, blue: 255/255, alpha: 1)
        button.layer.cornerRadius = 10
        button.setTitle("SignUp", for: .normal)
        button.titleLabel?.font=UIFont.boldSystemFont(ofSize: 20)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    
    let emailTextField = CustomTextField(placeHolder : "E-mail")
    let userNameTextField = CustomTextField(placeHolder : "UserName")
    let passwordTextField = CustomTextField(placeHolder : "Password")
    
    var stackView:UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addSubViews()
        configure()
        
    }
    
    
    private func addSubViews(){
        
        stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.backgroundColor = .red
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(userNameTextField)
        stackView.addArrangedSubview(passwordTextField)
         stackView.addArrangedSubview(signupButton)
        
        view.addSubview(profileImageButton)
       //  view.addSubview(t1)
        view.addSubview(stackView)
        //  view.addSubview(emailTextField)
    }
    
    private func configure(){
        profileImageButton.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.isSecureTextEntry = true
        
        
        NSLayoutConstraint.activate([
            profileImageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            profileImageButton.widthAnchor.constraint(equalToConstant: view.frame.width*0.3),
            profileImageButton.heightAnchor.constraint(equalToConstant: view.frame.width*0.3),
            
            stackView.topAnchor.constraint(equalTo: profileImageButton.bottomAnchor, constant: 40),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 30),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -30),
            stackView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
    
}
