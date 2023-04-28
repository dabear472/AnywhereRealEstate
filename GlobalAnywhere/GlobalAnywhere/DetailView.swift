//
//  DetailView.swift
//  GlobalAnywhere
//
//  Created by Jonathan Buford on 4/28/23.
//

import UIKit

class DetailView: UIView {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterTextLabel: UILabel!

    var dataModel: DataModel?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    init() {
        super.init(frame: CGRect(x: 0, y: 0,
                                 width: UIScreen.main.bounds.width,
                                 height: UIScreen.main.bounds.height))
    }

    func setupView() {
        let modelData = self.dataModel
    }
}
