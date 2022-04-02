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
    
    @IBOutlet var taitoruLabel: UILabel!
    @IBOutlet var kokugoLabel: UILabel!
    @IBOutlet var suugakuLabel: UILabel!
    @IBOutlet var eigoLabel: UILabel!
    @IBOutlet var rikaLabel: UILabel!
    @IBOutlet var shakaiLabel: UILabel!
    @IBOutlet var junniLabel: UILabel!

    
    // *** let plus: Plus = dataManager.create() ***
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.rankingTextField.delegate = self
        // Do any additional setup after loading the view.
        nameTextField.layer.borderColor = UIColor.systemGray.cgColor
        nameTextField.layer.borderWidth = 1.0
        japaneseTextField.layer.borderColor = UIColor.systemRed.cgColor
        japaneseTextField.layer.borderWidth = 1.0
        mathTextField.layer.borderColor = UIColor.systemTeal.cgColor
        mathTextField.layer.borderWidth = 1.0
        englishTextField.layer.borderColor = UIColor.systemPink.cgColor
        englishTextField.layer.borderWidth = 1.0
        scienceTextField.layer.borderColor = UIColor.systemGreen.cgColor
        scienceTextField.layer.borderWidth = 1.0
        socialStudiesTextField.layer.borderColor = UIColor.systemOrange.cgColor
        socialStudiesTextField.layer.borderWidth = 1.0
        rankingTextField.layer.borderColor = UIColor.systemPurple.cgColor
        rankingTextField.layer.borderWidth = 1.0
        
        taitoruLabel.layer.cornerRadius = 16
        kokugoLabel.layer.cornerRadius = 16
        suugakuLabel.layer.cornerRadius = 16
        eigoLabel.layer.cornerRadius = 16
        rikaLabel.layer.cornerRadius = 16
        shakaiLabel.layer.cornerRadius = 16
        junniLabel.layer.cornerRadius = 16
        taitoruLabel.layer.masksToBounds = true
        kokugoLabel.layer.masksToBounds = true
        suugakuLabel.layer.masksToBounds = true
        eigoLabel.layer.masksToBounds = true
        rikaLabel.layer.masksToBounds = true
        shakaiLabel.layer.masksToBounds = true
        junniLabel.layer.masksToBounds = true
        
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
        if nameTextField.text != "" && japaneseTextField.text != "" && mathTextField.text != "" && englishTextField.text != "" && scienceTextField.text != "" && socialStudiesTextField.text != "" && rankingTextField.text != "" {
            //保存
            let alert: UIAlertController = UIAlertController(title: "保存しますか？", message: "" , preferredStyle: .alert)
            alert.addAction(
                UIAlertAction(title: "保存", style: .default, handler: { [weak self] action in
                    guard let self = self else { return }
                    self.saveContext()
                    }
                )
            )
            alert.addAction(
                UIAlertAction(
                    title: "キャンセル", style: .cancel, handler: { action in
                    print("キャンセル")
                    }
                )
            )
            present(alert, animated: true, completion: nil)
        }else {
            let textFieldAlert: UIAlertController = UIAlertController(title: "保存できません。", message: "未入力の項目があります。", preferredStyle: .alert)

                textFieldAlert.addAction(
                    UIAlertAction(
                        title: "OK", style: .default, handler: { action in
                            print("nil")
                        }
                    )
                )
                present(textFieldAlert, animated: true, completion: nil)
        }
    }
    
    private func saveContext() {
        let plus: Plus = dataManager.create()
        plus.date = Date()
        plus.japanese = Int64(self.japaneseTextField.text ?? "0")!
        plus.math = Int64(self.mathTextField.text ?? "0")!
        plus.english = Int64(self.englishTextField.text ?? "0")!
        plus.science = Int64(self.scienceTextField.text ?? "0")!
        plus.social_studies = Int64(self.socialStudiesTextField.text ?? "0")!
        plus.ranking = Int64(self.rankingTextField.text ?? "0")!
        plus.name = String(self.nameTextField.text ?? "")
        print("保存されました。")
        self.japaneseTextField.text = ""
        self.mathTextField.text = ""
        self.englishTextField.text = ""
        self.scienceTextField.text = ""
        self.socialStudiesTextField.text = ""
        self.rankingTextField.text = ""
        self.nameTextField.text = ""
        self.dataManager.saveContext()
    }
}
