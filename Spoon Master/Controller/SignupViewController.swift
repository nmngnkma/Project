//
//  SignupViewController.swift
//  Spoon Master
//
//  Created by Nam Ngây on 09/01/2021.
//  Copyright © 2021 Nam Ngây. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class SignupViewController: UIViewController {
    
    // MARK: IB outlets
    @IBOutlet var heading: UILabel!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var signUpButton: UIButton!
    
    @IBOutlet var cloud1: UIImageView!
    @IBOutlet var cloud2: UIImageView!
    @IBOutlet var cloud3: UIImageView!
    @IBOutlet var cloud4: UIImageView!
    
    let spinner = UIActivityIndicatorView(style: .medium)
    let status = UIImageView(image: UIImage(named: "banner"))
    let label = UILabel()
    let messages = ["Connecting ..."]
    var animationContainerView: UIView!
    var errorMessage: String?
    var statusPosition = CGPoint.zero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        signUpButton.isEnabled = false
        configView()
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        setUpUI()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setUpAnimation()
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func signup() {
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { _, error in
                if let error = error as NSError? {
                    print("unknown error: \(error.localizedDescription)")
                }
            }
        }
        animateAfterSignUp()
    }
    
    @IBAction func back(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    func animateAfterSignUp() {
        view.endEditing(true)
        signUpButton.setTitle("", for: .normal)
        UIView.animate(withDuration: 1.5) {
            self.heading.center.x += self.view.bounds.width
        }
        UIView.animate(withDuration: 1.5, delay: 0.5, options: []) {
            self.emailTextField.center.x += self.view.bounds.width
        } completion: { _ in }
        
        UIView.animate(withDuration: 1.5, delay: 0.75, options: []) {
            self.passwordTextField.center.x += self.view.bounds.width
        } completion: { _ in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let homeVC = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController {
                self.navigationController?.pushViewController(homeVC, animated: true)
            }
        }
        UIView.animate(withDuration: 1, delay: 0.25, options: []) {
            self.cloud1.center.x += self.view.bounds.width
            self.cloud1.alpha = 0
        } completion: { _ in}
        UIView.animate(withDuration: 1, delay: 0.5, options: []) {
            self.cloud2.center.x += self.view.bounds.width
            self.cloud2.alpha = 0
        } completion: { _ in}
        UIView.animate(withDuration: 1, delay: 0.75, options: []) {
            self.cloud3.center.x += self.view.bounds.width
            self.cloud3.alpha = 0
        } completion: { _ in}
        UIView.animate(withDuration: 1, delay: 0.1, options: []) {
            self.cloud4.center.x += self.view.bounds.width
            self.cloud4.alpha = 0
        } completion: { _ in}
        UIView.animate(withDuration: 1, delay: 0.05, usingSpringWithDamping: 0.5, initialSpringVelocity: 1.0, options: []) {
            self.signUpButton.center.y += self.view.bounds.height
        } completion: { _ in}
        
        //  turnOnMessage()
    }
    
    func openAlert() {
        let alert = UIAlertController(title: "Error", message: errorMessage ?? "The email or password is not validate", preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func checkTextField() {
        if let email = emailTextField.text, let password = passwordTextField.text {
            if email.isValidEmail == true && password.isEmpty == false {
                signUpButton.isEnabled = true
            } else {
                signUpButton.isEnabled = false
            }
            if email.isValidEmail == false {
                openAlert()
            }
        }
    }
}

// MARK: UITextFieldDelegate
extension SignupViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        textFieldDidEndEditing(textField)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        checkTextField()
        resignFirstResponder()
    }
}

// MARK: - SetupAnimation
extension SignupViewController {
    func configView() {
        navigationController?.isNavigationBarHidden = true
        //set up the UI
        
        signUpButton.layer.cornerRadius = signUpButton.frame.size.height / 10
        signUpButton.layer.masksToBounds = true
        signUpButton.setTitle("Sign Up", for: .normal)
        
        spinner.center = CGPoint(x: signUpButton.bounds.width / 2,
                                 y: signUpButton.bounds.height / 2)
        spinner.alpha = 1
        signUpButton.addSubview(spinner)
        
        status.isHidden = true
        status.center = view.center
        
        label.frame = CGRect(x: 0.0, y: 0.0, width: status.frame.size.width, height: status.frame.size.height)
        label.font = UIFont(name: "HelveticaNeue", size: 18.0)
        label.textColor = UIColor(red: 0.89, green: 0.38, blue: 0.0, alpha: 1.0)
        label.textAlignment = .center
        status.addSubview(label)
    }
    
    func setUpUI() {
        heading.center.x -= view.bounds.width
        emailTextField.center.x -= view.bounds.width
        passwordTextField.center.x -= view.bounds.width
        cloud1.center.x -= view.bounds.width
        cloud2.center.x -= view.bounds.width
        cloud3.center.x -= view.bounds.width
        cloud4.center.x -= view.bounds.width
        
        cloud1.alpha = 0.0
        cloud2.alpha = 0.0
        cloud3.alpha = 0.0
        cloud4.alpha = 0.0
        
        signUpButton.center.y += 100
        signUpButton.alpha = 0
    }
    
    func setUpAnimation() {
        UIView.animate(withDuration: 1.5) {
            self.heading.center.x += self.view.bounds.width
        }
        UIView.animate(withDuration: 1.5, delay: 0.5, options: []) {
            self.emailTextField.center.x += self.view.bounds.width
        } completion: { _ in }
        
        UIView.animate(withDuration: 1.5, delay: 1, options: []) {
            self.passwordTextField.center.x += self.view.bounds.width
        } completion: { _ in }
        UIView.animate(withDuration: 1, delay: 0.25, options: []) {
            self.cloud1.center.x += self.view.bounds.width
            self.cloud1.alpha = 1
        } completion: { _ in}
        UIView.animate(withDuration: 1, delay: 0.5, options: []) {
            self.cloud2.center.x += self.view.bounds.width
            self.cloud2.alpha = 1
        } completion: { _ in}
        UIView.animate(withDuration: 1, delay: 0.75, options: []) {
            self.cloud3.center.x += self.view.bounds.width
            self.cloud3.alpha = 1
        } completion: { _ in}
        UIView.animate(withDuration: 1, delay: 0.1, options: []) {
            self.cloud4.center.x += self.view.bounds.width
            self.cloud4.alpha = 1
        } completion: { _ in}
        UIView.animate(withDuration: 1.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 1.0, options: []) {
            self.signUpButton.center.y -= 100
            self.signUpButton.alpha = 1
        } completion: { _ in}
    }
    
    func turnOnMessage() {
        animationContainerView = UIView(frame: view.bounds)
        animationContainerView.frame = view.bounds
        view.addSubview(animationContainerView)
        
        delay(seconds: 0.75) {
            UIView.transition(with: self.animationContainerView, duration: 1, options: [.curveEaseOut, .transitionFlipFromBottom]) {
                self.animationContainerView.addSubview(self.status)
            } completion: { _ in
                self.showMessage(index: 0)
            }
        }
    }
    
    func showMessage(index: Int) {
        label.text = messages[index]
        
        UIView.transition(with: status, duration: 0.33,
                          options: [.curveEaseOut, .transitionCrossDissolve],
                          animations: {
                            self.status.isHidden = false
                          },
                          completion: {_ in
                            //transition completion
                            delay(seconds: 2.0) {
                                if index < self.messages.count-1 {
                                    self.removeMessage(index: index)
                                } else {
                                    self.status.isHidden = true
                                }
                            }
                          }
        )
    }
    
    func removeMessage(index: Int) {
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [],
                       animations: {
                        self.status.center = self.view.center
                       },
                       completion: {_ in
                        self.status.isHidden = true
                        
                        self.showMessage(index: index+1)
                       }
        )
    }
}
