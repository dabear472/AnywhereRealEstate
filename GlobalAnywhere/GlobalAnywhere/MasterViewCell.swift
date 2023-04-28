//
//  MasterViewCell.swift
//  GlobalAnywhere
//
//  Created by Jonathan Buford on 4/27/23.
//

import UIKit

class MasterViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!

    var dataModel: DataModel?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setupView() {
        let modelData = self.dataModel
        
        if let name = modelData?.Text {
            let nameParts = name.components(separatedBy: " - ")
            self.nameLabel.text = nameParts.first
        } else {
            self.setupErrorCell()
        }
    }
    
    func setupErrorCell() {
        self.nameLabel.text = "Name Unavailable"
    }
}
