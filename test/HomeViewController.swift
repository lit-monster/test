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
    
    var selectedIndex = IndexPath()
    
    @IBOutlet var  collectionView :UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(UINib(nibName: "ResultCell", bundle: nil), forCellWithReuseIdentifier: "ResultCell")
        }
    }
    
    @IBOutlet var collectionViewFlowLayout: UICollectionViewFlowLayout!
    
    lazy var fetchedResultsController: NSFetchedResultsController<Plus> = {
        
        let _controller: NSFetchedResultsController<Plus> = dataManager.getFetchedResultController(with: ["date"])
        _controller.delegate = self
        return _controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionViewFlowLayout.estimatedItemSize = CGSize(width: self.view.frame.width, height: 64)
        
        // Do any additional setup after loading the view.
        
        //スワイプ用のインスタンスを生成する
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(HomeViewController.swipe(_:))
        )
        //デリゲートをセット
        swipeGesture.delegate = self
        //viewにスワイプジェスチャーを追加
        self.view.addGestureRecognizer(swipeGesture)
        
        let leftSwipe = UISwipeGestureRecognizer(
            target: self, action: #selector(HomeViewController.swipe(_:)))
        leftSwipe.direction = .left
        self.view.addGestureRecognizer(leftSwipe)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            let next = segue.destination as? DetailViewController
            let plus = fetchedResultsController.object(at: selectedIndex)
            next?.plus = plus
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
        cell?.dateLabel.text = DateUtils.stringFromDate(date: plus.date!, format: "yyyy/MM/dd")
        cell?.nameLabel.text = plus.name
        
        //        DateUtils.stringFromDate(date: plus.date!, format: "yyyy/MM/dd")
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath
        performSegue(withIdentifier: "detailSegue", sender: nil)
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
