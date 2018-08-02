//
//  ResetPasswordViewController.swift
//  FirebaseDemo
//

import UIKit
import Firebase

class ResetPasswordViewController: UIViewController {

    @IBOutlet var emailTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Forgot Password"
        emailTextField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func resetPassword(sender: UIButton){
        guard let email = emailTextField.text, email != "" else {
            let alertController = UIAlertController(title: "Error", message: "Please input your email", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(action)
            present(alertController, animated: true, completion: nil)
            return
        }
        
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            let title = error == nil ? "Success Reset Password" : "Reset Password Error"
            let message = error == nil ? "Please check your email to follow reset instruction" : error?.localizedDescription
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
                if error == nil {
                    self.view.endEditing(true)
                    
                    if let navController = self.navigationController {
                        navController.popViewController(animated: true)
                    }
                }
            })
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
        }
    }

}
