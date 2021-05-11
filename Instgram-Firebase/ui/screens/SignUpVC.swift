//
//  SignUpVC.swift
//  Instgram-Firebase
//
//  Created by Mahmoud Elattar on 4/25/21./Users/mahmoudelattar/Desktop/iti/ios/Instgram-Firebase/Instgram-Firebase/Instgram-Firebase/Utils/extensions/UIView+Extension.swift
//  Copyright © 2021 ITI. All rights reserved.
//

import UIKit
import Firebase

class SignUpVC: UIViewController {
    let profileImageButton :UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "add-profile-image")!.withRenderingMode(.alwaysOriginal), for: .normal)
        button.layer.cornerRadius = button.frame.width/2
        button.addTarget(self, action: #selector(selectPhotoFromGallery), for: .touchUpInside)
        return button
    }()
    
    let signupButton :UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.colorWithRGB(red: 149, green: 204, blue: 255)
        button.layer.cornerRadius = 10
        button.setTitle("SignUp", for: .normal)
        button.titleLabel?.font=UIFont.boldSystemFont(ofSize: 20)
        button.isEnabled = false
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(registerToFirebase), for: .touchUpInside)
        return button
    }()
    
    let loginButton :UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Already have an account?", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 17) , NSAttributedString.Key.foregroundColor : UIColor.gray])
        let latterString = NSAttributedString(string: " Sign In.", attributes:  [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 17) , NSAttributedString.Key.foregroundColor : UIColor.colorWithRGB(red: 17, green: 154, blue: 237)])
        attributedTitle.append(latterString)
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(popUpLoginScreen), for: .touchUpInside)
        return button
    }()
    
    
    let emailTextField = CustomTextField(placeHolder : "E-mail")
    let userNameTextField = CustomTextField(placeHolder : "UserName")
    let passwordTextField = CustomTextField(placeHolder : "Password")
    
    var stackView:UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureProfileImageButton()
        configureStackView()
        configureSignInButton()
        handleTextFieldInput()
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    @objc func registerToFirebase(){
        guard let email = emailTextField.text , email.count>5  else {
            return
        }
        guard let name = userNameTextField.text , name.count>5  else {
            return
        }
        guard let password = passwordTextField.text , password.count>5  else {
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { (result : AuthDataResult?, error : Error?) in
            if let  error = error{
                print("faild",error)
                return
            }
            guard let uid = result?.user.uid else {return}
            
            
            guard let profileImage = self.profileImageButton.imageView?.image else {return}
            guard  let imageData = profileImage.jpegData(compressionQuality: 0.75) else {return}
            let uniqueFileName = NSUUID().uuidString
            
            let storageItem =  Storage.storage().reference().child("profile-images").child(uniqueFileName)
            storageItem.putData(imageData, metadata: nil , completion: { (data
                , error) in
                if let error = error{
                    print("\(error)")
                    return
                }
                
                
                storageItem.downloadURL(completion: { (url, error) in
                    if let error = error  {
                        print(error)
                        return
                    }
                    guard let url = url else {return}
                    //     imageUrl = url.absoluteString
                    
                    let values = ["userName":name,"image_Url":url.absoluteString]
                    Database.database().reference().child("users").child(uid).setValue(values, withCompletionBlock:  { (error, reference) in
                        if let error = error  {
                            print("error" , error)
                            return}
                        print(reference)
                    })
                })
            }
                
                
                
            )
            
            
            
        }
        
    }
    
    @objc func popUpLoginScreen(){
        navigationController?.popToRootViewController(animated: true)
        
    }
    private func handleTextFieldInput(){
        emailTextField.addTarget(self, action: #selector(checkIfInputsValidation), for: .editingChanged)
        userNameTextField.addTarget(self, action: #selector(checkIfInputsValidation), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(checkIfInputsValidation), for: .editingChanged)
    }
    @objc private func checkIfInputsValidation(){
        let isValid = emailTextField.text?.count ?? 0>0 && userNameTextField.text?.count ?? 0>0 && passwordTextField.text?.count ?? 0>0
        if isValid {
            signupButton.isEnabled = true
            signupButton.backgroundColor = UIColor.colorWithRGB(red: 17, green: 154, blue: 237)
        }
        else{
            signupButton.isEnabled = false
            signupButton.backgroundColor = UIColor.colorWithRGB(red: 149, green: 204, blue: 255)
        }
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
        self.passwordTextField.isSecureTextEntry = true
        stackView.anchor(top: profileImageButton.bottomAnchor, topPadding: 40, bottom: nil, bottomPadding: 0, leading: view.leadingAnchor, leadingPadding: 30, trailing: view.trailingAnchor, trailingPadding: 30, width: nil, height: view.frame.height*0.3)
        
    }
    private func configureSignInButton(){
        view.addSubview(loginButton)
        loginButton.anchor(top: nil, topPadding: 0, bottom: view.safeAreaLayoutGuide.bottomAnchor, bottomPadding: -8, leading: view.leadingAnchor, leadingPadding: 30, trailing: nil, trailingPadding: 0, width: view.frame.width*0.7, height: 30)
        
    }
    
}
extension SignUpVC :UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    @objc func selectPhotoFromGallery(){
        let imageVC                    = UIImagePickerController()
        imageVC.delegate               = self
        imageVC.modalPresentationStyle = .fullScreen
        imageVC.allowsEditing          = true
        present(imageVC, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let editedImage   = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage
        let originalImage = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerOriginalImage")] as? UIImage
        
        if let editedImage = editedImage {
            profileImageButton.setImage(editedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        else if let originalImage = originalImage {
            profileImageButton.setImage(originalImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        profileImageButton.makeRounded()
        dismiss(animated: true, completion: nil)
    }
}
