//
//  QuizViewController.swift
//  QuizApp
//
//  Created by SHUBHAM  CHAUHAN on 15/10/17.
//  Copyright © 2017 shubhamchauhan. All rights reserved.
//

import UIKit
import DLRadioButton

class QuizViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var questionNumberLabel: UILabel!
    @IBOutlet weak var option_1: DLRadioButton!
    @IBOutlet weak var option_2: DLRadioButton!
    @IBOutlet weak var option_3: DLRadioButton!
    @IBOutlet weak var option_4: DLRadioButton!
    @IBOutlet weak var timerLabel: UILabel!
    
    var quizModel = QuizModel()
    var quizModelArray = [QuizModel]()
    var seconds = 10
    static var i = 0
    var time = Timer()
    
    var randomQuestionCountArray = [Int]()
    var questionCounter = 0
    var calculatedScore = 0
    let totalQuizQuestions = 10
    
    var skip = 0
    var selectedOptionNumber = 0
    var noOfAttempts : Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         time = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(counter), userInfo: nil, repeats: true)
        
        questionCounter = 0
        QuizViewController.i = 0
        
        //No of attempts in Userdefaults
        var c = UserDefaults.standard.value(forKey: "noOfAttempts") as! Int
        c += 1
        UserDefaults.standard.set(c, forKey: "noOfAttempts")
        
        option_1.titleLabel?.numberOfLines = 2
        option_2.titleLabel?.numberOfLines = 2
        option_3.titleLabel?.numberOfLines = 2
        option_4.titleLabel?.numberOfLines = 2
        self.view.backgroundColor = UIColor(white: 1, alpha: 1)
        collection.dataSource = self
        collection.delegate = self
        collection.backgroundColor = UIColor(white: 1, alpha : 1)

        option_1.contentHorizontalAlignment = .left
        option_2.contentHorizontalAlignment = .left
        option_3.contentHorizontalAlignment = .left
        option_4.contentHorizontalAlignment = .left

        loadDetailsFromJSON()
        randomQuestionCountArray = uniqueRandoms(numberOfRandoms: totalQuizQuestions, minNum: 0, maxNum: UInt32(quizModelArray.count))
        print(randomQuestionCountArray)
        
        firstQuestionLoad()
    }
    
    //Mark : Function for timer
     @objc func counter(){
        seconds -= 1
        if seconds <= 5 {
            timerLabel.textColor = UIColor.red
        }else{
            timerLabel.textColor = UIColor.black
        }
        
        timerLabel.text = String(seconds)
        
        if (seconds == 0) {
            nextButton.sendActions(for: .touchUpInside)
            //time.invalidate()
            }
        }
    

    //MARK : Conforming to collection view
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "questionCell", for: indexPath) as? QuestionCollectionViewCell{
            cell.configureCell(questionID: indexPath.row + 1)
            
            if indexPath.row == 0 {
                cell.contentView.backgroundColor = UIColor(red:0.00, green:0.51, blue:0.91, alpha:1.0)
            }
            return cell
    }
        else{
        return UICollectionViewCell()
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let newWidth = Int(collection.bounds.width) - 1
        let size = CGSize(width: CGFloat(newWidth)/6, height: 30)
        return size
    }


    //MARK : Loading data from Json to dictionary
    func loadDetailsFromJSON(){
        if let path = Bundle.main.path(forResource: "quiz", ofType: "json"){
            
            let url = URL(fileURLWithPath: path)
            print(path)
            
            do {
                let data = try Data(contentsOf: url)
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
               // print(json)
                
                if let dict1 = json as? Dictionary<String,AnyObject>{
                    
                    for obj in (dict1["questions"] as? [Dictionary<String,AnyObject>])!{
                        let quizDict = QuizModel(diction: obj)
                        quizModelArray.append(quizDict)
                        print("question added")
                    }
                }
            }
            catch{
                
            }
        }
        else{
            print("json not found")
        }
    }
  
    
    
    //MARK : Loading the first question separately
    func firstQuestionLoad(){
        questionLabel.textAlignment = .left
        questionLabel.text = quizModelArray[randomQuestionCountArray[0]].question
        
        option_1.setTitle(quizModelArray[randomQuestionCountArray[0]].option1, for: .normal)
        option_2.setTitle(quizModelArray[randomQuestionCountArray[0]].option2, for: .normal)
    
        option_3.isHidden = false
        option_4.isHidden = false
        
        if quizModelArray[randomQuestionCountArray[0]].option3 == ""{
            option_3.isHidden = true
        }else{
            option_3.setTitle(quizModelArray[randomQuestionCountArray[0]].option3, for: .normal)
        }
        if quizModelArray[randomQuestionCountArray[0]].option4.characters.count == 0{
            option_4.isHidden = true
        }else{
            option_4.setTitle(quizModelArray[randomQuestionCountArray[0]].option4, for: .normal)
        }
        
    }
    
    
    // MARK : On next button Press
    @IBAction func onNextPress(_ sender: UIButton) {
        //For reseting the timer
        seconds = 10
        
        //Calculating skipped questions
        if selectedOptionNumber == 0{
                skip  = skip + 1
            }
        
        //Check the result for previous question and change the score
        if selectedOptionNumber == quizModelArray[randomQuestionCountArray[questionCounter]].answer{
            calculatedScore = calculatedScore + 1
           
        }
        print("calculatedScore = \(calculatedScore)")
        
        
        //Reset the selected option
        selectedOptionNumber = 0
        
        //Increment the question counter for displaying the current question
        questionCounter = questionCounter + 1
        
        
        //Show the result if all the questions have been displayed
        if questionCounter == 10{
            performSegue(withIdentifier: "resultSegue", sender: self)
            time.invalidate()
        }
        
            
        else{
            //Clear the options
            option_1.isSelected = false
            option_2.isSelected = false
            option_3.isSelected = false
            option_4.isSelected = false
            
            
            //Set the background color of current question cell to blue
            let indexpath = IndexPath(row: (QuizViewController.i + 1), section: 0)
            collection.cellForItem(at: indexpath)?.contentView.backgroundColor = UIColor(red:0.00, green:0.51, blue:0.91, alpha:1.0)
            
            //Feed values to all the labels and buttons
            QuizViewController.i += 1
            questionLabel.text = quizModelArray[randomQuestionCountArray[questionCounter]].question
           
            option_1.setTitle(quizModelArray[randomQuestionCountArray[questionCounter]].option1, for: .normal)
            option_2.setTitle(quizModelArray[randomQuestionCountArray[questionCounter]].option2, for: .normal)
            option_3.isHidden = false
            option_4.isHidden = false
            
            if quizModelArray[randomQuestionCountArray[questionCounter]].option3 == ""{
                option_3.isHidden = true
            }else{
                option_3.setTitle(quizModelArray[randomQuestionCountArray[questionCounter]].option3, for: .normal)
            }
            if quizModelArray[randomQuestionCountArray[questionCounter]].option4.characters.count == 0{
                option_4.isHidden = true
            }else{
                option_4.setTitle(quizModelArray[randomQuestionCountArray[questionCounter]].option4, for: .normal)
            }
        }
        
    }
    
 
    //MARK : Provides the index of selected option
    @IBAction func onOptionSelection(_ sender: UIButton) {
        
        selectedOptionNumber = sender.tag
        print("Currently selection Option : \(selectedOptionNumber)")
    }
    
    
    //MARK : Returns the array of unique random numbers
    func uniqueRandoms(numberOfRandoms: Int, minNum: Int, maxNum: UInt32) -> [Int] {
        
        var uniqueNumbers = [Int]()
        
        while uniqueNumbers.count < numberOfRandoms {
            
            let randomNumber = Int(arc4random_uniform(maxNum)) + minNum
            var found = false
            
              for num in uniqueNumbers{
                    if num == randomNumber{
                        found = true
                        break
                        }
                }
            if found == false {
                uniqueNumbers.append(randomNumber)
            }
        }
        return uniqueNumbers
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         UserDefaults.standard.set(calculatedScore, forKey: "score")
         UserDefaults.standard.set(skip, forKey: "skippedQuestion")
    }

    
    @IBAction func onClosePress(_ sender: UIButton) {
        skip = skip + (totalQuizQuestions - questionCounter)
        performSegue(withIdentifier: "closeSegue", sender: self)
    }
    
}


