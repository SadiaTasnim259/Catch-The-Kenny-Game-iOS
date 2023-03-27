//
//  ViewController.swift
//  CatchTheKennyGame
//
//  Created by Sadia on 25/3/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    
    @IBOutlet weak var kenny1: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny7: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny9: UIImageView!
    
    
    var randomKenny: UIImageView!
    var timer = Timer()
    var score = 0
    var time = 15
    var kennyArray = [UIImageView]()
    var highscore = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let gestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let gestureRecognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        kenny1.addGestureRecognizer(gestureRecognizer1)
        kenny2.addGestureRecognizer(gestureRecognizer2)
        kenny3.addGestureRecognizer(gestureRecognizer3)
        kenny4.addGestureRecognizer(gestureRecognizer4)
        kenny5.addGestureRecognizer(gestureRecognizer5)
        kenny6.addGestureRecognizer(gestureRecognizer6)
        kenny7.addGestureRecognizer(gestureRecognizer7)
        kenny8.addGestureRecognizer(gestureRecognizer8)
        kenny9.addGestureRecognizer(gestureRecognizer9)
        
        kennyArray = [kenny1, kenny2, kenny3, kenny4, kenny5, kenny6, kenny7, kenny8, kenny9]
        
        
        showScore()
    }
    
    func showScore()  {
        let score = UserDefaults.standard.integer(forKey: "HIGHEST_SCORE")
        highscore = score
        highscoreLabel.text = "Highscore: \(highscore)"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        startAlert(title: "Start", message: "Start the game!")
    }
    
    func hideKenny(){
        for kenny in kennyArray{
            kenny.isHidden = true
        }
        
        let number = Int.random(in: 0...8)
        randomKenny = kennyArray[number]
        randomKenny.isHidden = false
    }
    
    @objc func increaseScore(){
        score += 1
        scoreLabel.text = "Score: \(score)"
    }
    
    func startAlert(title: String, message: String){
        let alertStart = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let startButton = UIAlertAction(title: "Start", style: UIAlertAction.Style.default) { uiAlertAction in
            self.timerSetup()
            self.hideKenny()
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) { action in
            self.randomKenny.isHidden = true
        }
        
        alertStart.addAction(startButton)
        alertStart.addAction(cancelButton)
        self.present(alertStart, animated: true)
    }
    
    func timerSetup(){
        time = 20
        score = 0
        scoreLabel.text = "Score: \(score)"
        self.timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.timerUpdate), userInfo: nil, repeats: true)
    }
    
    @objc func timerUpdate(){
        time -= 1
        if time == 0{
            timer.invalidate()
            
            if score > highscore{
                UserDefaults.standard.set(score, forKey: "HIGHEST_SCORE")
            }
            showScore()
            startAlert(title: "Restart", message: "Restart the game")
            
        }
        hideKenny()
        timeLabel.text = "Time: \(time)"
    }
    
    
    
}

