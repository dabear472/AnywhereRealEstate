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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setupView() {
        if let modelData = GlobalVariables.shared.dataModel {
            let nameParts = modelData.Text.components(separatedBy: " - ")
            
            if let characterName = nameParts.first {
                self.nameLabel.text = nameParts.first
                NetworkTraffic.shared.gatherImageData(withImageView: self.characterImage,
                                                      withQueryName: characterName)
            } else {
                print("Unable to parse out character name")
                setupErrorView()
            }
            
            self.characterTextLabel.isHidden = false
            self.characterTextLabel.text = modelData.Text
        } else {
            self.setupErrorView()
        }
    }
    
    func setupErrorView() {
        characterTextLabel.isHidden = true
        characterImage.image = GlobalVariables.noImageIcon
        nameLabel.text = "Please press back button."
    }
}
