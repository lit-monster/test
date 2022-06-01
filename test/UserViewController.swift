//
//  UserViewController.swift
//  test
//
//  Created by Youmi Nagase on 2022/05/04.
//

import UIKit
import CoreData

class UserViewController: UIViewController {
    
    @IBOutlet var japaneseAverageLabel: UILabel!
    @IBOutlet var mathAverageLabel: UILabel!
    @IBOutlet var englishAverageLabel: UILabel!
    @IBOutlet var scienceAverageLabel: UILabel!
    @IBOutlet var socialStudyAverageLabel: UILabel!
    
    var plus: Plus?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
