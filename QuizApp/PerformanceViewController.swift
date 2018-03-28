//
//  PerformanceViewController.swift
//  QuizApp
//
//  Created by SHUBHAM  CHAUHAN on 25/10/17.
//  Copyright © 2017 shubhamchauhan. All rights reserved.
//

import UIKit

class PerformanceViewController: UIViewController {
  
    @IBOutlet weak var noOfAttempts: UILabel!
    
    @IBOutlet weak var bestScore: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let attempts = UserDefaults.standard.value(forKey: "noOfAttempts")!
        noOfAttempts.text =  "No. of Attempts : " + String(describing : attempts)
        let strBest = "Your Best : "
        
        var max = 0
        
        if (UserDefaults.standard.value(forKey: "score") as! Int) > max {
            max = UserDefaults.standard.value(forKey: "score") as! Int
            bestScore.text = strBest.padding(toLength: 18, withPad: " ", startingAt: 0) + String(describing : max)
            
        }
        if attempts as! Int == 0
        {bestScore.text = strBest.padding(toLength: 18, withPad: " ", startingAt: 0) + "0"
         }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
