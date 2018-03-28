//
//  ViewController.swift
//  QuizApp
//
//  Created by SHUBHAM  CHAUHAN on 13/10/17.
//  Copyright © 2017 shubhamchauhan. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

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
}

