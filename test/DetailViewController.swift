//
//  DetailViewController.swift
//  test
//
//  Created by Youmi Nagase on 2021/10/14.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var japaneseLabel: UILabel!
    @IBOutlet var mathLabel: UILabel!
    @IBOutlet var englishLabel: UILabel!
    @IBOutlet var scienceLabel: UILabel!
    @IBOutlet var socialStudyLabel: UILabel!
    @IBOutlet var rankingLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    
    var inJapanese: Int = 0
    var inMath: Int = 0
    var inEnglish: Int = 0
    var inScience: Int = 0
    var inSocialStudy: Int = 0
    var inRanking: Int = 0
//    var inTitle: String = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        japaneseLabel.text = String(inJapanese)
        mathLabel.text = String(inMath)
        englishLabel.text = String(inEnglish)
        scienceLabel.text = String(inScience)
        socialStudyLabel.text = String(inSocialStudy)
        rankingLabel.text = String(inRanking)
//        titleLabel.text = inTitle

        // Do any additional setup after loading the view.
    }
    
}
