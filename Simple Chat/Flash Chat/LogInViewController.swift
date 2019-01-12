//
//  LogInViewController.swift
//  Flash Chat
//
//  This is the view controller where users login


import UIKit
import Firebase
import SVProgressHUD

class LogInViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    let emailInfoKey = "EmailInfo"
    let passwordInfoKey = "PasswordInfo"
    let rememberUserInfoSwitchKey = "rememberUserInfoSwitchInfo"
    
    //Textfields pre-linked with IBOutlets
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    @IBOutlet var rememberUserInfoSwitch: UISwitch!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        loadUserInfo()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func logInPressed(_ sender: AnyObject) {
        
        SVProgressHUD.show()
        
        //TODO: Log in the user
        Auth.auth().signIn(withEmail: emailTextfield.text!, password: passwordTextfield.text!) {
            (user, error) in
            
            if error != nil {
                print(error!)
            } else {
                print("Log in successful")
                
                self.defaults.set(self.emailTextfield.text!, forKey: self.emailInfoKey)
                self.defaults.set(self.passwordTextfield.text!, forKey: self.passwordInfoKey)
                self.defaults.set(self.rememberUserInfoSwitch.isOn, forKey: self.rememberUserInfoSwitchKey)
                
                SVProgressHUD.dismiss()
                
                self.performSegue(withIdentifier: "goToChat", sender: self)
            }
        }
        
    }
    
    func loadUserInfo() {
        
        if defaults.bool(forKey: rememberUserInfoSwitchKey) == true {
            
            rememberUserInfoSwitch.isOn = true
            
            if let email = defaults.string(forKey: emailInfoKey) {
                emailTextfield.text = email
            }
            
            if let password = defaults.string(forKey: passwordInfoKey) {
                passwordTextfield.text = password
            }
            
        }
        
    }
    
}  
