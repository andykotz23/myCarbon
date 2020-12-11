//
//  excellentScoreViewController.swift
//  HackDukeApp
//
//  Created by Niam Kothari on 12/6/20.
//

import UIKit

class excellentScoreViewController: UIViewController {
    let defaults = UserDefaults.standard
    @IBOutlet weak var wordGoodness: UITextField!
    @IBOutlet weak var messageToUser: UITextView!
    @IBOutlet weak var userScore: UILabel!
    @IBOutlet weak var thingsToDo: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        let score = String(format: "%.2f", Total.score)
//        userScore.text = ("Score: \(score)")
        loadScreen()
    }
    
    func loadScreen() {
        var score = Float(0.0)
        let totalemissions = Total.value
        if totalemissions < 11 {
            score = 100
        }
        else if totalemissions >= 11 {
            score = 100.0 * (11.0/totalemissions)
        }
        Total.score = score
        let K = Constants()
        userScore.text = ("Score: \(score)")
        var keepTrackOfScores = (defaults.object(forKey: "keepTrack") as? [Int]) ?? [Int]()
        keepTrackOfScores.append(Int(ceilf(score)))
        defaults.set(keepTrackOfScores,forKey: "keepTrack")
        let currList = defaults.object(forKey: "keepTrack") ?? 0
        print(currList,type(of: currList))
        switch Total.score {
        case 100:
            messageToUser.text = K.excellentStr + "\n" + K.endStr + "\n" 
            wordGoodness.text = "Excellent!"
            wordGoodness.backgroundColor = #colorLiteral(red: 0, green: 0.9580436349, blue: 0, alpha: 1)
            messageToUser.font = messageToUser.font?.withSize(22)
        case 51...99:
            messageToUser.text = K.greatStr + "\n" +  K.endStr + "\n"
            wordGoodness.text = "Great!"
            wordGoodness.backgroundColor = #colorLiteral(red: 0, green: 0.8158865571, blue: 0.3598684072, alpha: 1)
            messageToUser.font = messageToUser.font?.withSize(22)
        case 31...50:
            messageToUser.text = K.goodStr + "\n" + K.endStr + "\n"
            wordGoodness.text = "Good!"
            wordGoodness.backgroundColor = #colorLiteral(red: 0, green: 0.668805182, blue: 0, alpha: 1)
            messageToUser.font = messageToUser.font?.withSize(22)
        case 21...30:
            messageToUser.text = K.fairStr + "\n" + K.endStr + "\n"
            wordGoodness.text = "Fair"
            wordGoodness.backgroundColor = #colorLiteral(red: 1, green: 0.7955777645, blue: 0, alpha: 1)
            messageToUser.font = messageToUser.font?.withSize(14.5)
        case 11...20:
            messageToUser.text = K.poorStr + "\n" + K.endStr + "\n"
            wordGoodness.text = "Poor"
            wordGoodness.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0.1729321778, alpha: 1)
            messageToUser.font = messageToUser.font?.withSize(14.5)
        default:
            messageToUser.text = K.veryPoorStr + "\n" + K.endStr + "\n"
            wordGoodness.text = "Very Poor"
            wordGoodness.backgroundColor = #colorLiteral(red: 0.9904320836, green: 0, blue: 0, alpha: 1)
            messageToUser.font = messageToUser.font?.withSize(14.5)

        }
        
//        if Total.score == 100 {
//            self.performSegue(withIdentifier: "excellentScore", sender: self)
//        }
//        else if Total.score > 50 && Total.score < 100 {
//            self.performSegue(withIdentifier: "greatScore", sender: self)
//        }
//        else if Total.score > 30 && Total.score <= 50 {
//            self.performSegue(withIdentifier: "goodScore", sender: self)
//        }
//        else if Total.score > 20 && Total.score <= 30 {
//            self.performSegue(withIdentifier: "fairScore", sender: self)
//        }
//        else if Total.score > 10 && Total.score <= 20 {
//            self.performSegue(withIdentifier: "poorScore", sender: self)
//        }
//        else {
//            self.performSegue(withIdentifier: "veryPoorScore", sender: self)
//        }
    }
}
