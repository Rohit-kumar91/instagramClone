//
//  SignUpViewController.swift
//  InstagramClone
//
//  Created by Rohit Prajapati on 31/01/19.
//  Copyright © 2019 Rohit Prajapati. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var imageSelected = false
    
    let plusPhotoButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus_photo").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleSelectProfilePhoto), for: .touchUpInside)
        return button
    }()
    
    let emailTextfield: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        return tf
    }()
    
    let fullnameTextfield: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Full name"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(formValidation), for: .editingChanged)

        return tf
    }()
    
    let usernameTextfield: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Username"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(formValidation), for: .editingChanged)

        return tf
    }()
    
    let passwordTextfield: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.isSecureTextEntry = true
        tf.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        return tf
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
        button.layer.cornerRadius = 5
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button
        
    }()
    
    let alreadyHaveAccountButton: UIButton = {
        let button = UIButton()
        let attributedTitle = NSMutableAttributedString(string: "Already have a account?   ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        attributedTitle.append(NSAttributedString(string: "Sign In", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor(red: 17/255, green: 154/255, blue: 237/255, alpha: 1)]))
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleShowSignIn), for: .touchUpInside)
        
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //background Color White
        view.backgroundColor = .white
        view.addSubview(plusPhotoButton)
        plusPhotoButton.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 40, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 140, height: 140)
        plusPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        configureViewComponents()
        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 20, paddingRight: 0, width: 0, height: 50)

    }
    
    
    func configureViewComponents() {
        
        let stackView = UIStackView(arrangedSubviews: [emailTextfield,fullnameTextfield,usernameTextfield,passwordTextfield,signUpButton])
        stackView.distribution = .fillEqually
        stackView.axis =  .vertical
        stackView.spacing = 10
        view.addSubview(stackView)
        stackView.anchor(top: plusPhotoButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 40, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 240)
        
    }
    
    @objc func handleShowSignIn() {
        print("Show signIn.")
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func handleSignUp() {
        print("Handle Show signUp.")
        
        guard let email = emailTextfield.text else { return }
        guard let password = passwordTextfield.text else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            
            //Handle error
            if let error = error {
                print("Failed to create user with error\(error.localizedDescription)")
                return
            }
            
            //Success
            print("Successfully created user with firebase.")
        }
        
        
    }
    
    @objc func formValidation() {
        guard emailTextfield.hasText, passwordTextfield.hasText, fullnameTextfield.hasText, usernameTextfield.hasText, imageSelected == true else {
            
            signUpButton.isEnabled = false
            signUpButton.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
            
            return
        }
        
        signUpButton.isEnabled = true
        signUpButton.backgroundColor = UIColor(red: 17/255, green: 204/255, blue: 244/255, alpha: 1)
        
    }
    
    @objc func handleSelectProfilePhoto() {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        //Select Image
        guard let profileImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            imageSelected = false
            return
        }
        
        //Set Image selected to true
        imageSelected = true
        
        //Configure image button.
        plusPhotoButton.layer.cornerRadius = plusPhotoButton.frame.width / 2
        plusPhotoButton.layer.masksToBounds = true
        plusPhotoButton.layer.borderColor = UIColor.black.cgColor
        plusPhotoButton.layer.borderWidth = 2
        plusPhotoButton.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        
        self.dismiss(animated: true, completion: nil)
        
        
        
    }
    

  

}
