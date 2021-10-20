//
//  HomeViewController.swift
//  test
//
//  Created by Youmi Nagase on 2021/01/06.
//

import CoreData
import UIKit

class HomeViewController: UIViewController, NSFetchedResultsControllerDelegate, UIGestureRecognizerDelegate {

    let dataManager = DataManager.shared
    
    @IBOutlet var  collectionView :UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(UINib(nibName: "ResultCell", bundle: nil), forCellWithReuseIdentifier: "ResultCell")
        }
    }
    
    lazy var fetchedResultsController: NSFetchedResultsController<Plus> = {

        let _controller: NSFetchedResultsController<Plus> = dataManager.getFetchedResultController(with: ["date"])
        _controller.delegate = self
        return _controller
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //ロングプレス用のインスタンスを生成する
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(HomeViewController.longPress(_:))
        )
        //デリゲートをセット
        longPressGesture.delegate = self
        //viewにロングプレスジェスチャーを追加
        self.view.addGestureRecognizer(longPressGesture)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.cellTap(_:))
        )
        tapGesture.delegate = self
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func cellTap(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "detailSegue", sender: nil)
    }
    
    //ロングプレス時に実行されるメソッド
    @objc func longPress(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .ended {
            //ロングプレス終了時に実行したい処理を記載する
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        do {
            try fetchedResultsController.performFetch()
        } catch {
            print(error)
        }
    }
        
    }

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let sections = fetchedResultsController.sections else { return 0 }

        let sectionInfo = sections[section]
        return sectionInfo.numberOfObjects // これ
        
    return 3
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let plus = fetchedResultsController.object(at: indexPath)
        print(fetchedResultsController.object(at: indexPath))
        print(plus.date)
        print(plus.japanese)
        print(plus.math)
        print(plus.english)
        print(plus.science)
        print(plus.social_studies)
        print(plus.ranking)
        print(plus.name)
         
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ResultCell", for: indexPath) as? ResultCell
        
        cell?.japaneseLabel.text = String(plus.japanese)
        cell?.englishLabel.text = String(plus.english)
        cell?.mathLabel.text = String(plus.math)
        cell?.scienceLabel.text = String(plus.science)
        cell?.social_studiesLabel.text = String(plus.social_studies)
        cell?.dateLabel.text = DateUtils.stringFromDate(date: plus.date!, format: "yyyy/MM/dd")
        cell?.rankingLabel.text = String(plus.ranking)
        cell?.nameLabel.text = plus.name
        
//        DateUtils.stringFromDate(date: plus.date!, format: "yyyy/MM/dd")
        return cell!
    }
    
    
class DateUtils {
    class func stringFromDate(date: Date, format: String) -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
}
}
