//
//  ViewController.swift
//  QuizApp
//
//  Created by SHUBHAM  CHAUHAN on 13/10/17.
//  Copyright © 2017 shubhamchauhan. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var userDefaults = UserDefaults.standard;
    var resetAttempts = 0;
    var resetBestScore = 0;

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK : Alert on Start button press
    @IBAction func onStartPress(_ sender: UIButton) {
    
        let introAlert = UIAlertController(title: "Starting The Quiz", message: "All The Best", preferredStyle: .alert)
        
        let startAction = UIAlertAction(title: "Start", style: .default, handler:
        {_ in if(QuizViewController.i == 10){
            self.performSegue(withIdentifier: "startToResultSegue", sender: self)
        }else{
            
            self.performSegue(withIdentifier: "startQuiz", sender: self)
            }
            
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        
        introAlert.addAction(startAction)
        introAlert.addAction(cancelAction)
        
        self.present(introAlert, animated: true, completion: nil)
    }
    
    //MARK : Home screen logout
    @IBAction func onLogout(_ sender: UIButton) {
        performSegue(withIdentifier: "deskBoardToLogin", sender: self)
    }
    
    @IBAction func onClearHistoryPress(_ sender: UIButton) {
        print("Clearing history");
        
           let clearAlert = UIAlertController(title: "This will clear your Best Score", message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler:
            {_ in
                self.userDefaults.set(self.resetAttempts, forKey: "noOfAttempts")
                self.userDefaults.set(self.resetBestScore, forKey: "bestScore")
            }
        )
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        
        clearAlert.addAction(okAction)
        clearAlert.addAction(cancelAction)
        
        self.present(clearAlert, animated: true, completion: nil)
    }
}

