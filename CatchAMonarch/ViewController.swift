//
//  ViewController.swift
//  CatchAMonarch
//
//  Created by Brandon Petersen on 1/8/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        countdown = 5
        timerLabel.text = "\(countdown)"
        scoreLabel.text = "Score: \(score)"
        
        let storedHighscore = UserDefaults.standard.object(forKey: "highscore")
        
        highestScore = 0
        if storedHighscore == nil {
            highestScoreLabel.text = "\(highestScore)"
        }
        
        if let newScore = storedHighscore as? Int {
            highestScore = newScore
            highestScoreLabel.text = "Highscore: \(highestScore)"
        }
        
        butterfly1.isUserInteractionEnabled = true
        butterfly2.isUserInteractionEnabled = true
        butterfly3.isUserInteractionEnabled = true
        butterfly4.isUserInteractionEnabled = true
        butterfly5.isUserInteractionEnabled = true
        butterfly6.isUserInteractionEnabled = true
        butterfly7.isUserInteractionEnabled = true
        butterfly8.isUserInteractionEnabled = true
        butterfly9.isUserInteractionEnabled = true
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        butterfly1.addGestureRecognizer(recognizer1)
        butterfly2.addGestureRecognizer(recognizer2)
        butterfly3.addGestureRecognizer(recognizer3)
        butterfly4.addGestureRecognizer(recognizer4)
        butterfly5.addGestureRecognizer(recognizer5)
        butterfly6.addGestureRecognizer(recognizer6)
        butterfly7.addGestureRecognizer(recognizer7)
        butterfly8.addGestureRecognizer(recognizer8)
        butterfly9.addGestureRecognizer(recognizer9)
        
        butterflyArray = [butterfly1, butterfly2, butterfly3, butterfly4, butterfly5, butterfly6, butterfly7, butterfly8, butterfly9]
        hideButterfly()
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideButterfly), userInfo: nil, repeats: true)
        
    }
    
    
    //MARK: Vars
    var timer = Timer()
    var hideTimer = Timer()
    var countdown = 0
    var score = 0
    var highestScore = 0
    var butterflyArray = [UIImageView]()
    
    
    //MARK: Outlets
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highestScoreLabel: UILabel!
    
    @IBOutlet weak var butterfly1: UIImageView!
    @IBOutlet weak var butterfly2: UIImageView!
    @IBOutlet weak var butterfly3: UIImageView!
    @IBOutlet weak var butterfly4: UIImageView!
    @IBOutlet weak var butterfly5: UIImageView!
    @IBOutlet weak var butterfly6: UIImageView!
    @IBOutlet weak var butterfly7: UIImageView!
    @IBOutlet weak var butterfly8: UIImageView!
    @IBOutlet weak var butterfly9: UIImageView!
    
    
    //MARK: Functions
    @objc func hideButterfly() {
        for butterfly in butterflyArray {
            butterfly.isHidden = true
        }
        
        let randomNumber = arc4random_uniform(UInt32(butterflyArray.count-1))
        butterflyArray[Int(randomNumber)].isHidden = false
    }
    

    @objc func increaseScore() {
        score += 1
        scoreLabel.text = "Score: \(score)"
    }
    
    @objc func countDown() {
        countdown -= 1
        timerLabel.text = "\(countdown)"
        
        if countdown == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            for butterfly in butterflyArray {
                butterfly.isHidden = true
            }
            
            if self.score > self.highestScore {
                self.highestScore = self.score
                highestScoreLabel.text = "Highscore: \(self.highestScore)"
                
                UserDefaults.standard.set(self.highestScore, forKey: "highscore")
            }
            
            let alert = UIAlertController(title: "Game Over!", message: "You Got a Score of \(score)!", preferredStyle: UIAlertController.Style.alert)
            
            let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { UIAlertAction in
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.countdown = 30
                self.timerLabel.text = "\(self.countdown)"
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideButterfly), userInfo: nil, repeats: true)
            }
            
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
        }
    }
}

