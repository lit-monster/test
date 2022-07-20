//
//  PlusViewController.swift
//  test
//
//  Created by Youmi Nagase on 2021/01/06.
//

import UIKit
import Foundation

class PlusViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var japaneseTextField: UITextField!
    @IBOutlet var mathTextField: UITextField!
    @IBOutlet var englishTextField: UITextField!
    @IBOutlet var scienceTextField: UITextField!
    @IBOutlet var socialStudiesTextField: UITextField!
    @IBOutlet var rankingTextField: UITextField!

    @IBOutlet var saveButton: UIButton!
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var japaneseLabel: UILabel!
    @IBOutlet var mathLabel: UILabel!
    @IBOutlet var englishLabel: UILabel!
    @IBOutlet var scienceLabel: UILabel!
    @IBOutlet var socialStudiesLabel: UILabel!
    @IBOutlet var rankingLabel: UILabel!
  
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
        mathTextField.layer.borderColor = UIColor.systemBlue.cgColor
        mathTextField.layer.borderWidth = 1.0
        englishTextField.layer.borderColor = UIColor.systemYellow.cgColor
        englishTextField.layer.borderWidth = 1.0
        scienceTextField.layer.borderColor = UIColor.systemGreen.cgColor
        scienceTextField.layer.borderWidth = 1.0
        socialStudiesTextField.layer.borderColor = UIColor.systemOrange.cgColor
        socialStudiesTextField.layer.borderWidth = 1.0
        rankingTextField.layer.borderColor = UIColor.systemPurple.cgColor
        rankingTextField.layer.borderWidth = 1.0
        
        titleLabel.layer.cornerRadius = 5
        japaneseLabel.layer.cornerRadius = 5
        mathLabel.layer.cornerRadius = 5
        englishLabel.layer.cornerRadius = 5
        scienceLabel.layer.cornerRadius = 5
        socialStudiesLabel.layer.cornerRadius = 5
        rankingLabel.layer.cornerRadius = 5
        titleLabel.layer.masksToBounds = true
        japaneseLabel.layer.masksToBounds = true
        mathLabel.layer.masksToBounds = true
        englishLabel.layer.masksToBounds = true
        scienceLabel.layer.masksToBounds = true
        socialStudiesLabel.layer.masksToBounds = true
        rankingLabel.layer.masksToBounds = true
        
        saveButton.layer.cornerRadius = 10
        saveButton.layer.borderColor = UIColor.systemPink.cgColor
        saveButton.layer.borderWidth = 2.0
        
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
        
        moveTextField(textFields: [nameTextField, japaneseTextField, mathTextField, englishTextField, scienceTextField, socialStudiesTextField, rankingTextField], previousNextable: true)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func countTextField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var maxLength: Int = 0
        
        switch (textField.tag) {
        case 0: //title
            maxLength = 15
        case 1: //japanese
            maxLength = 10
        case 2: //math
            maxLength = 10
        case 3: //english
            maxLength = 10
        case 4: //science
            maxLength = 10
        case 5: //socialStudies
            maxLength = 10
        case 6: //rankig
            maxLength = 10
        default:
            break
        }
        let textFieldNumber = textField.text?.count ?? 0
        let stringNumber = string.count
        return textFieldNumber + stringNumber <= maxLength
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
                    self.nameTextField.text = ""
                    self.japaneseTextField.text = ""
                    self.mathTextField.text = ""
                    self.englishTextField.text = ""
                    self.scienceTextField.text = ""
                    self.socialStudiesTextField.text = ""
                    self.rankingTextField.text = ""
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

extension UIViewController {

    @objc func doneButtonTapped() {
        view.endEditing(true)
    }

    func moveTextField(textFields: [UITextField], previousNextable: Bool = false) {
        for (index, textField) in textFields.enumerated() {
            let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
            toolBar.barStyle = .default
            var items = [UIBarButtonItem]()

            if previousNextable {
            let previousButton = UIBarButtonItem(image: UIImage(systemName: "chevron.up"), style: .plain, target: self, action: nil)
            if textField == textFields.first {
                previousButton.isEnabled = false
            }else {
                previousButton.target = textFields[index - 1]
                previousButton.action = #selector(UITextField.becomeFirstResponder)
            }
            let fixedSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.fixedSpace, target: self, action: nil)
            fixedSpace.width = 8
            let nextButton = UIBarButtonItem(image: UIImage(systemName: "chevron.down"), style: .plain, target: self, action: nil)
            if textField == textFields.last {
                nextButton.isEnabled = false
            } else {
                nextButton.target = textFields[index + 1]
                nextButton.action = #selector(UITextField.becomeFirstResponder)
            }
                items.append(contentsOf: [previousButton, nextButton, fixedSpace])
            }
            let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let doneButton = UIBarButtonItem(title: "完了", style: .done, target: view, action: #selector(UIView.endEditing))
            items.append(contentsOf: [flexSpace, doneButton])
            toolBar.setItems(items, animated: false)
            toolBar.sizeToFit()
            textField.inputAccessoryView = toolBar
        }
    }
}
