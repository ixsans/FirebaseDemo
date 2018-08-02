//
//  SignUpViewController.swift
//  FirebaseDemo
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Sign Up"
        nameTextField.becomeFirstResponder()
    }

    @IBAction func registerAccount(sender: UIButton) {
        guard let name = nameTextField.text, name != "",
        let email = emailTextField.text, email != "",
            let password = passwordTextField.text, password != "" else {
                let alertController = UIAlertController(title: "Registration Error", message: "Please make sure your name, enter email and password", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(alertAction)
                present(alertController, animated: false, completion: nil)
                return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                print(error)
                let alertController = UIAlertController(title: "Registration Error", message: error.localizedDescription, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(action)
                self.present(alertController, animated: false, completion: nil)
                return
            }
            
            if let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest() {
                changeRequest.displayName = name
                changeRequest.commitChanges(completion: { (error) in
                    if let error = error {
                        print("Failed to change name: \(error)")
                        return
                    }
                })
            }
            
            self.view.endEditing(true)
            
            user?.sendEmailVerification(completion: nil)
            
            let alertController = UIAlertController(title: "Registration Success", message: "You have already registed. Please confirm your email first before trying to login.", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
                self.dismiss(animated: false, completion: nil)
            })
            alertController.addAction(action)
            self.present(alertController, animated: false, completion: nil)
            
//            if let mainVC = self.storyboard?.instantiateViewController(withIdentifier: "MainView") {
//                UIApplication.shared.keyWindow?.rootViewController = mainVC
//                self.dismiss(animated: false, completion: nil)
//            }
            
            
        }
    }

}
