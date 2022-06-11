//
//  PlusViewController.swift
//  test
//
//  Created by Youmi Nagase on 2021/01/06.
//

import UIKit
import CoreData

class PlusViewController: UIViewController, UITextFieldDelegate {

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
  
    let realmManager = RealmManager()
    
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
        
        saveButton.layer.cornerRadius = 10
        saveButton.layer.borderColor = UIColor.systemYellow.cgColor
        saveButton.layer.borderWidth = 2.0
        saveButton.layer.shadowColor = UIColor.systemYellow.cgColor
        
        nameTextField.delegate = self
        japaneseTextField.delegate = self
        mathTextField.delegate = self
        englishTextField.delegate = self
        scienceTextField.delegate = self
        socialStudiesTextField.delegate = self
        rankingTextField.delegate = self
        
        nameTextField.tag = 0
        japaneseTextField.tag = 1
        mathTextField.tag = 2
        englishTextField.tag = 3
        scienceTextField.tag = 4
        socialStudiesTextField.tag = 5
        rankingTextField.tag = 6
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        toolBar.sizeToFit()
        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        let commitButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(commitButtonTapped))
        toolBar.items = [spacer,commitButton]
        nameTextField.inputAccessoryView = toolBar
        japaneseTextField.inputAccessoryView = toolBar
        mathTextField.inputAccessoryView = toolBar
        englishTextField.inputAccessoryView = toolBar
        scienceTextField.inputAccessoryView = toolBar
        socialStudiesTextField.inputAccessoryView = toolBar
        rankingTextField.inputAccessoryView = toolBar
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
//
//    func textFieldShouldReturn(rankingTextField: UITextField) -> Bool {
//        rankingTextField.resignFirstResponder()
//        return true
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        let nextTag = textField.tag + 1
        if let nextTextField = self.view.viewWithTag(nextTag)  {
            nextTextField.becomeFirstResponder()
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }
    
    @objc func commitButtonTapped() {
//        textField.resignFirstResponder()
//                if textField == nameTextField {
//                    japaneseTextField.becomeFirstResponder()
//                }else if textField == japaneseTextField {
//                    mathTextField.becomeFirstResponder()
//                }else if textField == mathTextField {
//                    englishTextField.becomeFirstResponder()
//                }else if textField == englishTextField {
//                    scienceTextField.becomeFirstResponder()
//                }else if textField == scienceTextField {
//                    socialStudiesTextField.becomeFirstResponder()
//                }else if textField == socialStudiesTextField {
//                    rankingTextField.becomeFirstResponder()
//                }else {
//                    return true
//                }
//                return true
    }

    @IBAction func save() {
        if nameTextField.text != "" && japaneseTextField.text != "" && mathTextField.text != "" && englishTextField.text != "" && scienceTextField.text != "" && socialStudiesTextField.text != "" && rankingTextField.text != "" {
            let alert: UIAlertController = UIAlertController(title: "保存しますか？", message: "" , preferredStyle: .alert)
            alert.addAction(
                UIAlertAction(title: "保存", style: .default, handler: { [weak self] action in
                    guard let self = self else { return }
                    let plus = Plus()
                    plus.date = Date()
                    plus.name = self.nameTextField.text ?? ""
                    plus.japanese = Int(self.japaneseTextField.text!)!
                    plus.math = Int(self.mathTextField.text!)!
                    plus.english = Int(self.englishTextField.text!)!
                    plus.science = Int(self.scienceTextField.text!)!
                    plus.socialStudies = Int(self.socialStudiesTextField.text!)!
                    plus.ranking = Int(self.rankingTextField.text!)!
                    self.realmManager.createTestRecord(record: plus)
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
}
