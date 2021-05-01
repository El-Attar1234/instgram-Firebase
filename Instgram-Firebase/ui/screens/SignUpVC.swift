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
        button.backgroundColor = UIColor.colorWithRGB(red: 100, green: 204, blue: 255)
        button.layer.cornerRadius = 10
        button.setTitle("SignUp", for: .normal)
        button.titleLabel?.font=UIFont.boldSystemFont(ofSize: 20)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(registerToFirebase), for: .touchUpInside)
        return button
    }()
    
   @objc func registerToFirebase(){
        
    }
    
    let emailTextField = CustomTextField(placeHolder : "E-mail")
    let userNameTextField = CustomTextField(placeHolder : "UserName")
    let passwordTextField = CustomTextField(placeHolder : "Password")
    
    var stackView:UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureProfileImageButton()
        configureStackView()
        
        
    }
    
    private func configureProfileImageButton(){
        view.addSubview(profileImageButton)
        profileImageButton.anchor(top: view.topAnchor, topPadding: 60, bottom: nil, bottomPadding: 0, leading: nil, leadingPadding: 0, trailing: nil, trailingPadding: 0, width:  view.frame.width*0.3, height:  view.frame.width*0.3)
        profileImageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    private func configureStackView(){
         stackView = UIStackView(arrangedSubviews: [emailTextField,userNameTextField,passwordTextField,signupButton])
        view.addSubview(stackView)
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        passwordTextField.isSecureTextEntry = true
        stackView.anchor(top: profileImageButton.bottomAnchor, topPadding: 40, bottom: nil, bottomPadding: 0, leading: view.leadingAnchor, leadingPadding: 30, trailing: view.trailingAnchor, trailingPadding: 30, width: nil, height: view.frame.height*0.3)
        
    }
    
}
