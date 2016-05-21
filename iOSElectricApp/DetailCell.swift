//
//  SettingNameCell.swift
//  iOSDataChart
//
//  Created by Chotipat on 4/25/2559 BE.
//  Copyright © 2559 Chotipat. All rights reserved.
//

import UIKit
import RealmSwift

class DetailCell: UITableViewCell {
    @IBOutlet var ImageView: UIImageView!
    @IBOutlet var OutletID: UILabel!
    @IBOutlet var OutletName: UILabel!
    @IBOutlet var Power: UILabel!
    @IBOutlet var Limit: UILabel!
    @IBOutlet var Detail: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
}