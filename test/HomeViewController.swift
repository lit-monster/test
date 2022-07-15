//
//  HomeViewController.swift
//  test
//
//  Created by Youmi Nagase on 2021/01/06.
//

import UIKit

class HomeViewController: UIViewController, UIGestureRecognizerDelegate {

    let realmManager = RealmManager()
    
    var selectedRecordID = String()
    
    @IBOutlet var  collectionView :UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(UINib(nibName: "ResultCell", bundle: nil), forCellWithReuseIdentifier: "ResultCell")
        }
    }
    
    @IBOutlet var collectionViewFlowLayout: UICollectionViewFlowLayout!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionViewFlowLayout.estimatedItemSize = CGSize(width: self.view.frame.width, height: 64)
        
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            let next = segue.destination as? DetailViewController
            next?.selectedRecordId = self.selectedRecordID
        }
    }
    
    //スワイプ時に実行されるメソッド
    @objc func swipe(_ sender: UISwipeGestureRecognizer) {
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let result = realmManager.getAllRecords(type: Plus())
        return result.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let result = realmManager.getAllRecords(type: Plus())
        let plus = result[indexPath.row]
        print(plus.date)
        print(plus.japanese)
        print(plus.math)
        print(plus.english)
        print(plus.science)
        print(plus.socialStudies)
        print(plus.ranking)
        print(plus.name)
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ResultCell", for: indexPath) as? ResultCell
        cell?.recordId = plus.id
        cell?.dateLabel.text = DateUtils.stringFromDate(date: plus.date, format: "yyyy/MM/dd")
        cell?.nameLabel.text = plus.name
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedCell = collectionView.cellForItem(at: indexPath) as? ResultCell else { return }
        selectedRecordID = selectedCell.recordId!
        performSegue(withIdentifier: "detailSegue", sender: nil)
    }
}
