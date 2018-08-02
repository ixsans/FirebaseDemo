//
//  ProfileViewController.swift
//  FirebaseDemo
//
//

import UIKit
import Firebase
import GoogleSignIn

class ProfileViewController: UIViewController {
    
    @IBOutlet var nameLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "My Profile"
        
        if let name = Auth.auth().currentUser?.displayName {
            nameLabel.text = name
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func close(sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
  
    @IBAction func logout(sender: UIButton) {
        do {
            if let providerData = Auth.auth().currentUser?.providerData {
                let userInfo = providerData[0]                
                switch userInfo.providerID {
                    case "google.com":
                        GIDSignIn.sharedInstance().signOut()
                    default:
                        break
                }
            }
            
            
            try Auth.auth().signOut()
        }catch {
            let alertController = UIAlertController(title: "Logout Error", message: error.localizedDescription, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(action)
            present(alertController, animated: false, completion: nil)
            return
        }
        
        if let welcomeVC = self.storyboard?.instantiateViewController(withIdentifier: "WelcomeView") {
            UIApplication.shared.keyWindow?.rootViewController = welcomeVC
            self.dismiss(animated: false, completion: nil)
        }
        
    }

}
