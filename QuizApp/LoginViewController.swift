//
//  LoginViewController.swift
//  QuizApp
//
//  Created by SHUBHAM  CHAUHAN on 25/10/17.
//  Copyright © 2017 shubhamchauhan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var userDefault = UserDefaults.standard
    var attempts = 0
    var bestScore = 0
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    @IBOutlet weak var mySwitch: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture);
        
        userName.text = userDefault.value(forKey: "username") as? String
        password.text = userDefault.value(forKey: "password") as? String

        if(userDefault.value(forKey: "noOfAttempts") == nil){
        userDefault.set(attempts, forKey: "noOfAttempts")
        }
        if(userDefault.value(forKey: "bestScore") == nil){
            userDefault.set(bestScore, forKey: "bestScore")
        }
        // Do any additional setup after loading the view.
    }

    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        userName.resignFirstResponder()
        password.resignFirstResponder()
    }
    
    @IBAction func onLogin(_ sender: UIButton) {
        userDefault.set(userName.text! as String, forKey: "username")
        userDefault.set(password.text! as String, forKey: "password")
        if ((userDefault.value(forKey: "username") as! String == "shubhamchauhan@gmail.com") && (userDefault.value(forKey: "password") as! String == "4488"))
       {
        
        if mySwitch.isOn{
            userDefault.set(userName.text! as String, forKey: "username")
            userDefault.set(password.text! as String, forKey: "password")
       
        }else{
            userDefault.removeObject(forKey: "username")
            userDefault.removeObject(forKey: "password")
        }
         performSegue(withIdentifier: "loginToDeskBoard", sender: self)
        }else{
            
            let loginAlert = UIAlertController(title: "Invalid Login", message: "Username or Password don't match", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "Start", style: .default, handler: nil)
            
            loginAlert.addAction(okAction)
            
            self.present(loginAlert, animated: true, completion: nil)
        }
    }
    
    

}
