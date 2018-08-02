//
//  LogonViewController.swift
//  FirebaseDemo
//

import UIKit
import Firebase 

class LoginViewController: UIViewController {
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.title = "Log In"
        emailTextField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = ""
    }

    @IBAction func login(sender: UIButton) {
        guard let email = emailTextField.text, email != "",
            let password = passwordTextField.text, password != "" else {
                let alertController = UIAlertController(title: "Login Error", message: "Please enter email and password", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(alertAction)
                present(alertController, animated: false, completion: nil)
                return
        }
        
        self.view.endEditing(true)
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                let alertController = UIAlertController(title: "Login Failed", message: error?.localizedDescription, preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(alertAction)
                self.present(alertController, animated: false, completion: nil)
                return
            }
            
            guard let currentUser = user, currentUser.isEmailVerified else {
                let alertController = UIAlertController(title: "Login Failed", message: "Your email has not been verified. Please verify your email", preferredStyle: .alert)
                let resendAction = UIAlertAction(title: "Resend", style: .default, handler: { (action) in
                    user?.sendEmailVerification(completion: nil)
                })
                alertController.addAction(resendAction)
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                alertController.addAction(cancelAction)
                self.present(alertController, animated: false, completion: nil)
                return
            }
            
            if let mainVC = self.storyboard?.instantiateViewController(withIdentifier: "MainView"){
                UIApplication.shared.keyWindow?.rootViewController = mainVC
                self.dismiss(animated: false, completion: nil)
            }
            
        }
        
    }
    
}












