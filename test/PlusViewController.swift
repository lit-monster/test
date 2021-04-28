//
//  PlusViewController.swift
//  test
//
//  Created by Youmi Nagase on 2021/01/06.
//

import UIKit
import CoreData

class PlusViewController: UIViewController {
    
    let dataManager = DataManager.shared
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var japaneseTextField: UITextField!
    @IBOutlet var mathTextField: UITextField!
    @IBOutlet var englishTextField: UITextField!
    @IBOutlet var scienceTextField: UITextField!
    @IBOutlet var socialStudiesTextField: UITextField!
    @IBOutlet var rankingTextField: UITextField!

    
    
    // *** let plus: Plus = dataManager.create() ***
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func save() {
        let plus: Plus = dataManager.create()
        plus.date = Date()
        plus.japanese = Float(japaneseTextField.text ?? "0.0")!
        plus.math = Float(mathTextField.text ?? "0.0")!
        plus.english = Float(englishTextField.text ?? "0.0")!
        plus.science = Float(scienceTextField.text ?? "0.0")!
        plus.social_studies = Float(socialStudiesTextField.text ?? "0.0")!
        plus.ranking = Int64(rankingTextField.text ?? "0")!
        plus.name = String(nameTextField.text ?? "")
        dataManager.saveContext()
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

