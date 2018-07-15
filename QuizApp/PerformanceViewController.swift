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
    
    var userDefaults = UserDefaults.standard;
    var max = Int();
    
    override func viewWillAppear(_ animated: Bool) {
        let attempts = userDefaults.value(forKey: "noOfAttempts")!
        print(attempts);
        let strBest = "Your Best : "
        
        max = userDefaults.integer(forKey: "bestScore")
        
        if (attempts as! Int != 0){
            noOfAttempts.text =  "No. of Attempts : " + String(describing : attempts)
            if (userDefaults.integer(forKey: "score") > max ){
                max = userDefaults.integer(forKey: "score")
                userDefaults.set(max, forKey: "bestScore");
                bestScore.text = strBest.padding(toLength: 18, withPad: " ", startingAt: 0) + String(describing : max)
            }else{
                bestScore.text = strBest.padding(toLength: 18, withPad: " ", startingAt: 0) + String(describing : max)
            }
        }else{
            noOfAttempts.text =  "No. of Attempts : " + "0";
            bestScore.text = strBest.padding(toLength: 18, withPad: " ", startingAt: 0) + "0"
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

  
    
    
}
