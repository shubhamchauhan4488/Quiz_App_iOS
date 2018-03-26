//
//  InstructionViewController.swift
//  QuizApp
//
//  Created by SHUBHAM  CHAUHAN on 22/10/17.
//  Copyright © 2017 shubhamchauhan. All rights reserved.
//

import UIKit

class InstructionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onBackPress(_ sender: UIButton) {
        performSegue(withIdentifier: "InstructionToHome", sender: self)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
