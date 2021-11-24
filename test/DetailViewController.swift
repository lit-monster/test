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
    
    var plus: Plus?

    override func viewDidLoad() {
        super.viewDidLoad()
        if let plus = plus {
            japaneseLabel.text = String(plus.japanese)
            mathLabel.text = String(plus.math)
            englishLabel.text = String(plus.english)
            scienceLabel.text = String(plus.science)
            socialStudyLabel.text = String(plus.social_studies)
            rankingLabel.text = String(plus.ranking)
            titleLabel.text = plus.name
        }


        // Do any additional setup after loading the view.
    }
    
}
