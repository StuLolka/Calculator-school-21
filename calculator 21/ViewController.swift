//
//  ViewController.swift
//  calculator 21
//
//  Created by Сэнди Белка on 12.08.2020.
//  Copyright © 2020 Сэнди Белка. All rights reserved.
//

import UIKit





class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var currentLevelOutletPlaceholder: UITextField!
    @IBOutlet weak var xpLevelOutletPlaceholder: UITextField!
    @IBOutlet weak var scoreOutletPlaceholder: UITextField!
    @IBOutlet weak var yourNewLevelLabel: UILabel!
    @IBOutlet weak var newLevelLabel: UILabel!
    
    private let xpToCoefficient = [25 : 2.2,
                                   100 : 8.8330,
                                   225 : 20.02,
                                   375 : 33.88,
                                   600 : 56.10,
                                   800 : 79.2,
                                   1000 : 93.50,
                                   1500 : 132]
    
    private let expForLevel = [0: 0.0,
                               1 : 1000,
                               2 : 2136.3636363636365,
                               3 : 3427.6859504132235,
                               4 : 4895.097670924118,
                               5 : 6562.610989686497,
                               6 : 8457.51248828011,
                               7 : 10610.809645772853,
                               8 : 13057.738233832788,
                               9 : 15838.338902082713,
                               10 : 18998.112388730355,
                               11 : 22588.764078102675,
                               12 : 26669.05008875304,
                               13 : 31305.738737219363,
                               14 : 36574.70311047655,
                               15 : 42562.16262554153,
                               16 : 49366.09389266083,
                               17 : 57097.83396893276,
                               18 : 65883.9022374236,
                               19 : 75868.07072434499,
                               20 : 87213.71673221022,
                               21 : 100106.49628660252,
                               22 : 114757.3821438665,
                               23 : 131406.11607257556,
                               24 : 150325.13190065406,
                               25 : 171824.01352347052,
                               26 : 196254.56082212558,
                               27 : 224016.54638877907,
                               28 : 255564.2572599762,
                               29 : 291413.9287045184,
                               30 : 332152.19170968]

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light    
    }

    @IBAction func startButton(_ sender: UIButton) {
        currentLevelOutletPlaceholder.delegate = self
        xpLevelOutletPlaceholder.delegate = self
        scoreOutletPlaceholder.delegate = self
        if let curlvl = currentLevelOutletPlaceholder.text, let xplvl = xpLevelOutletPlaceholder.text, let score = scoreOutletPlaceholder.text {
            guard let startLvl = Double(curlvl) else {return }
            guard let xpLvl = Int(xplvl) else {return }
            guard let score = Double(score) else {return }
            yourNewLevelLabel.text = "Your new level is"
            yourNewLevelLabel.backgroundColor = .black
            getLvl(startLvl, xpLvl, score)
        }
    }
    
    private func getLvl(_ startLvl: Double, _ xpLvl: Int, _ score: Double) {
        guard let xpStartLevel = expForLevel[Int(startLvl)] else {return }
        guard let xpNextLevel = expForLevel[Int(startLvl) + 1] else {return }
        guard let xpProj = xpToCoefficient[xpLvl] else {return }
        let startLvlXp = getStartLvlXp(xpStartLevel, xpNextLevel, startLvl)
        let xpYouGet = xpProj * score
        let xpYouHave = xpYouGet + startLvlXp
        var i = Int(startLvl)
        while (i < 30 && expForLevel[i, default: -1] < xpYouHave) {
            i += 1
        }
        guard let second = expForLevel[i] else {return }
        guard let first = expForLevel[i - 1] else {return }
        finish(second, first, xpYouHave, i)
    }
    
    private func getStartLvlXp(_ xpStartLevel: Double, _ xpNextLevel: Double, _ startLvl: Double) -> Double {
        let dif = xpNextLevel - xpStartLevel
        let cof = startLvl - Double(Int(startLvl))
        let startLvlXp = xpStartLevel + (cof * dif)
        return startLvlXp
    }
    
    private func finish(_ second : Double, _ first : Double, _ xpYouHave : Double, _ i : Int) {
        let diff = second - first
        let dbl = (xpYouHave - first) / diff
        let yourNewLvl = Double(i - 1) + dbl
        let formatted = String(format: "%.2f", yourNewLvl)
        newLevelLabel.backgroundColor = .black
        newLevelLabel.text = "\(formatted)"
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == currentLevelOutletPlaceholder{
            xpLevelOutletPlaceholder.becomeFirstResponder()
        }
        else if textField == scoreOutletPlaceholder {
            scoreOutletPlaceholder.resignFirstResponder()
        }
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

