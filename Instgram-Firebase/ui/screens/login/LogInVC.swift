//
//  LogInVC.swift
//  Instgram-Firebase
//
//  Created by Mahmoud Elattar on 5/5/21.
//  Copyright © 2021 ITI. All rights reserved.
//

import UIKit
import Firebase

class LogInVC: UIViewController {
    @IBOutlet weak var instgramLogoView: UIView!
    
    let loginButton :UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.colorWithRGB(red: 149, green: 204, blue: 255)
        button.layer.cornerRadius = 10
        button.setTitle("Login", for: .normal)
        button.titleLabel?.font=UIFont.boldSystemFont(ofSize: 20)
        button.isEnabled = false
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    let emailTextField = CustomTextField(placeHolder : "E-mail")
    let passwordTextField = CustomTextField(placeHolder : "Password")
    
    
    
    @objc func handleLogin(){
        guard let email = emailTextField.text , email.count>5  else { return}
        guard let password = passwordTextField.text , password.count>5  else {return}
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                print("failed login " ,error)
                return
            }
            
        /*    let keyWindow = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first
            
            
            guard let mainTabBarController = keyWindow?.rootViewController as? UserProfileViewController  else {return}
            
            mainTabBarController.fetchUserData()*/
            print("user",user?.user.uid)
            self.dismiss(animated: true)
        }
        
        
    }
    var stackView:UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureStackView()
        handleTextFieldInput()
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func singUpShowScreen(_ sender: Any) {
        let signUpVC = SignUpVC()
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .darkContent
    }
    private func configureStackView(){
        stackView = UIStackView(arrangedSubviews: [emailTextField,passwordTextField,loginButton])
        view.addSubview(stackView)
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        self.passwordTextField.isSecureTextEntry = true
        stackView.anchor(top: instgramLogoView.bottomAnchor, topPadding: 60, bottom: nil, bottomPadding: 0, leading: view.leadingAnchor, leadingPadding: 30, trailing: view.trailingAnchor, trailingPadding: 30, width: nil, height: view.frame.height*0.2)
        
    }
    private func handleTextFieldInput(){
        emailTextField.addTarget(self, action: #selector(checkIfInputsValidation), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(checkIfInputsValidation), for: .editingChanged)
    }
    @objc private func checkIfInputsValidation(){
        let isValid = emailTextField.text?.count ?? 0>0 &&  passwordTextField.text?.count ?? 0>0
        if isValid {
            loginButton.isEnabled = true
            loginButton.backgroundColor = UIColor.colorWithRGB(red: 17, green: 154, blue: 237)
        }
        else{
            loginButton.isEnabled = false
            loginButton.backgroundColor = UIColor.colorWithRGB(red: 149, green: 204, blue: 255)
        }
    }
    
    
}
