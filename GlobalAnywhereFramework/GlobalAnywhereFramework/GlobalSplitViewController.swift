//
//  GlobalSplitViewController.swift
//  GlobalAnywhere
//
//  Created by Jonathan Buford on 5/2/23.
//

import UIKit

public class GlobalSplitViewController: UISplitViewController {

    public var forSimpsons: Bool = true
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        GlobalVariables.shared.forSimpsons = self.forSimpsons
        GlobalVariables.shared.splitViewController = self
        self.show(.primary)
    }
    
}
