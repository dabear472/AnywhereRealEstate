//
//  ViewController.swift
//  simpsonsviewer
//
//  Created by Jonathan Buford on 4/27/23.
//

import UIKit
import GlobalAnywhereFramework

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let s = UIStoryboard (name: "GlobalMainStoryboard", bundle: Bundle(for: GlobalSplitViewController.self))
        let vc = s.instantiateInitialViewController() as! GlobalSplitViewController
        vc.modalPresentationStyle = .fullScreen
        vc.forSimpsons = true
        self.present(vc, animated: true, completion: nil)

    }

}

