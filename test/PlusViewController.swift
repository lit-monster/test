//
//  PlusViewController.swift
//  test
//
//  Created by Youmi Nagase on 2021/01/06.
//

import UIKit
import CoreData

class PlusViewController: UIViewController, NSFetchedResultsControllerDelegate, UITextFieldDelegate {
    
    let dataManager = DataManager.shared
    
    lazy var fetchedResultsController: NSFetchedResultsController<Plus> = {

        let _controller: NSFetchedResultsController<Plus> = dataManager.getFetchedResultController(with: ["date"])
        _controller.delegate = self
        return _controller
    }()

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
        self.rankingTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (self.rankingTextField.isFirstResponder) {
            self.rankingTextField.resignFirstResponder()
        }
    }
    
    func textFieldShouldReturn(rankingTextField: UITextField) -> Bool {
        rankingTextField.resignFirstResponder()
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        do {

            try fetchedResultsController.performFetch()
        } catch {

            print(error)
        }
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
}

