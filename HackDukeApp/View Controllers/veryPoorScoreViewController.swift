//
//  veryPoorScoreViewController.swift
//  HackDukeApp
//
//  Created by Niam Kothari on 12/6/20.
//

import UIKit

class veryPoorScoreViewController: UIViewController {
    
    @IBOutlet weak var userScore: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let score = String(format: "%.2f", Total.score)
        userScore.text = ("Score: \(score)")
    }
}
