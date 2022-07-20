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
    
    var selectedRecordId: String?

    var realmManager = RealmManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        japaneseLabel.layer.cornerRadius = 5
        mathLabel.layer.cornerRadius = 5
        englishLabel.layer.cornerRadius = 5
        scienceLabel.layer.cornerRadius = 5
        socialStudyLabel.layer.cornerRadius = 5
        rankingLabel.layer.cornerRadius = 5
        titleLabel.layer.cornerRadius = 5
        
        japaneseLabel.layer.masksToBounds = true
        mathLabel.layer.masksToBounds = true
        englishLabel.layer.masksToBounds = true
        scienceLabel.layer.masksToBounds = true
        socialStudyLabel.layer.masksToBounds = true
        rankingLabel.layer.masksToBounds = true
        titleLabel.layer.masksToBounds = true
        
        if let plus = realmManager.getFilteredRecords(predicate: NSPredicate(format: "id == %@", selectedRecordId!), type: Plus()).first as? Plus {
            japaneseLabel.text = "国語　　" + String(plus.japanese) + "点"
            mathLabel.text = "数学　　" + String(plus.math) + "点"
            englishLabel.text = "英語　　" + String(plus.english) + "点"
            scienceLabel.text = "理科　　" + String(plus.science) + "点"
            socialStudyLabel.text = "社会　　" + String(plus.socialStudies) + "点"
            rankingLabel.text = "順位　　" + String(plus.ranking) + "位"
            titleLabel.text = plus.name
        }
    }

    @IBAction func deleteButtonPressed() {
        guard let selectedRecordId = selectedRecordId else { return }
        realmManager.deleteRecord(id: selectedRecordId, type: Plus())
        let alert: UIAlertController = UIAlertController(title: "削除しますか？", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "削除", style: .default, handler: { (action) -> Void in
            self.navigationController?.popViewController(animated: true)
        }))
        alert.addAction(UIAlertAction(title: "キャンセル", style: .cancel))
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func updateButtonPressed() {
        guard let selectedRecordId = selectedRecordId else { return }
        let updatedRecord = Plus()
        realmManager.updateRecord(id: selectedRecordId, newRecord: updatedRecord)
    }
    
    @IBAction func resultEditbButton() {
    }
}
