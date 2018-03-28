//
//  QuizModel.swift
//  QuizApp
//
//  Created by SHUBHAM  CHAUHAN on 17/10/17.
//  Copyright © 2017 shubhamchauhan. All rights reserved.
//

import Foundation

class QuizModel{
    
    //MARK : class variables
    private var _question : String!
    private var _option1 : String!
    private var _option2 : String!
    private var _option3 : String!
    private var _option4 : String!
    private var _answer : Int!
    
    //MARK: properties
    public var question : String{
        if _question == nil {
            _question = ""
        }
        return _question
    }
    
    public var option1 : String{
        if _option1 == nil {
            _option1 = ""
        }
        return _option1
    }
    
    public var option2 : String{
        if _option2 == nil {
            _option2 = ""
        }
        return _option2
    }
    
    public var option3 : String{
        if _option3 == nil {
            _option3 = ""
        }
        return _option3
    }
    
    public var option4 : String{
        if _option4 == nil {
            _option4 = ""
        }
        return _option4
    }
    
    public var answer : Int{
        if _answer == 0 {
            _answer = 0
        }
        return _answer
    }
    
    
    
    //MARK: default initializer
    init(){
        _question = ""
        _option1 = ""
        _option2 = ""
        _option3 = ""
        _option4 = ""
        _answer = 0
    }
    
    
    //MARK : Parametrized initializer
    init(diction : Dictionary<String,AnyObject>){
        
        
        if let ques = diction["question"] as? String{
            self._question = ques
            print(ques)
        }
        if let ans = diction["answers"] as? [String?]{
            switch ans.count {
            case 2 :
                self._option1 = ans[0]
                self._option2 = ans[1]
                self._option3 = ""
                self._option4 = ""
            
            case 3 :
                self._option1 = ans[0]
                self._option2 = ans[1]
                self._option3 = ans[2]
                self._option4 = ""
                
            case 4 :
                self._option1 = ans[0]
                self._option2 = ans[1]
                self._option3 = ans[2]
                self._option4 = ans[3]
                
            default:
                break
            }
        }
        if let correct = diction["correctAnswer"] as? Int{
            self._answer = correct
        
    }
}
    
    
    
}
