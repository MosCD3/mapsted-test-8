//
//  ViewController.swift
//  MoosTestCase8
//
//  Created by Mostafa Youssef on 9/10/20.
//  Copyright © 2020 Phzio. All rights reserved.
//

import UIKit

class WelcomePage: UIViewController {

    var mainCoordinator: GenericCoordinatorProtocol
    init(coordinator: GenericCoordinatorProtocol) {
        
        self.mainCoordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Interface Builder is not supported!")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
        button.setTitle("Save", for: .normal)
        button.addTarget(self, action: #selector(displayData), for: .touchUpInside)
        button.backgroundColor = UIColor(hexString: "2d73fb")
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        view.addSubview(button)
        button.center = view.center
        // Do any additional setup after loading the view.
    }
    
    @objc func displayData() {
        mainCoordinator.navToBuildingData()
    }


}

