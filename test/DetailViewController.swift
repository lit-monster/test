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
    
    @IBOutlet var kokugoLabel: UILabel!
    @IBOutlet var suugakuLabel: UILabel!
    @IBOutlet var eigoLabel: UILabel!
    @IBOutlet var rikaLabel: UILabel!
    @IBOutlet var shakaiLabel: UILabel!
    @IBOutlet var junniLabel: UILabel!
    @IBOutlet var taitoruLabel: UILabel!
    
    var selectedRecordId: String?

    var realmManager = RealmManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        japaneseLabel.layer.cornerRadius = 16
        japaneseLabel.layer.masksToBounds = true
        mathLabel.layer.cornerRadius = 16
        mathLabel.layer.masksToBounds = true
        englishLabel.layer.cornerRadius = 16
        englishLabel.layer.masksToBounds = true
        scienceLabel.layer.cornerRadius = 16
        scienceLabel.layer.masksToBounds = true
        socialStudyLabel.layer.cornerRadius = 16
        socialStudyLabel.layer.masksToBounds = true
        rankingLabel.layer.cornerRadius = 16
        rankingLabel.layer.masksToBounds = true
        titleLabel.layer.cornerRadius = 16
        titleLabel.layer.masksToBounds = true
        
        kokugoLabel.layer.cornerRadius = 16
        kokugoLabel.layer.masksToBounds = true
        suugakuLabel.layer.cornerRadius = 16
        suugakuLabel.layer.masksToBounds = true
        eigoLabel.layer.cornerRadius = 16
        eigoLabel.layer.masksToBounds = true
        rikaLabel.layer.cornerRadius = 16
        rikaLabel.layer.masksToBounds = true
        shakaiLabel.layer.cornerRadius = 16
        shakaiLabel.layer.masksToBounds = true
        junniLabel.layer.cornerRadius = 16
        junniLabel.layer.masksToBounds = true
        
        if let plus = realmManager.getFilteredRecords(predicate: NSPredicate(format: "id == %@", selectedRecordId!), type: Plus()).first as? Plus {
            japaneseLabel.text = String(plus.japanese) + "点"
            mathLabel.text = String(plus.math) + "点"
            englishLabel.text = String(plus.english) + "点"
            scienceLabel.text = String(plus.science) + "点"
            socialStudyLabel.text = String(plus.socialStudies) + "点"
            rankingLabel.text = String(plus.ranking) + "位"
            titleLabel.text = plus.name
        }
    }

    @IBAction func deleteButtonPressed() {
        guard let selectedRecordId = selectedRecordId else { return }
        realmManager.deleteRecord(id: selectedRecordId, type: Plus())
    }

    @IBAction func updateButtonPressed() {
        guard let selectedRecordId = selectedRecordId else { return }
        let updatedRecord = Plus()
        realmManager.updateRecord(id: selectedRecordId, newRecord: updatedRecord)
    }
}
