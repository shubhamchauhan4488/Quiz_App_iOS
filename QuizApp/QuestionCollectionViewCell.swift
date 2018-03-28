//
//  QuestionCollectionViewCell.swift
//  QuizApp
//
//  Created by SHUBHAM  CHAUHAN on 19/10/17.
//  Copyright © 2017 shubhamchauhan. All rights reserved.
//

import UIKit

class QuestionCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var quesLabl: UILabel!
    
    
    func configureCell(questionID : Int){
        quesLabl.text = String(describing : questionID)
    }
}

