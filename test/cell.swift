//
//  cell.swift
//  test
//
//  Created by Youmi Nagase on 2021/06/09.
//

//  カスタムセルクラス.swift
import UIKit
class cell: UITableViewCell {
  @IBOutlet var label: UILabel!

  func cell(選択数はこれを使う: IndexPath){
    self.label.text = String((選択数はこれを使う.row)+1)
  }
}
