//
//  ResultViewController.swift
//  QuizApp
//
//  Created by SHUBHAM  CHAUHAN on 18/10/17.
//  Copyright © 2017 shubhamchauhan. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var champLabel: UILabel!
    @IBOutlet weak var incorrectAnswers: UILabel!
    @IBOutlet weak var skippedQuestions: UILabel!
    let totalQuizQuestions = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        image.isHidden = true
        champLabel.isHidden = true
        
        let correctAnswers = UserDefaults.standard.value(forKey: "score")! as! Int
        let skippedQuestion = UserDefaults.standard.value(forKey: "skippedQuestion") as! Int
        let incorrectAnswer = totalQuizQuestions - correctAnswers - skippedQuestion
        scoreLabel.text =       "Score             : " + String(describing: correctAnswers)
        incorrectAnswers.text = "Incorrect Answers : " + String(incorrectAnswer)
        skippedQuestions.text = "Skipped Questions : " + String(skippedQuestion)
        
        if correctAnswers >= 2{
            image.isHidden = false
            champLabel.isHidden = false
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onEndPress(_ sender: UIButton) {
        performSegue(withIdentifier: "resultToDashboard", sender: self)
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
