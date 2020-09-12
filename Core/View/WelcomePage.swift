//
//  ViewController.swift
//  MoosTestCase8
//
//  Created by Mostafa Youssef on 9/10/20.
//  Copyright © 2020 Phzio. All rights reserved.
//

import UIKit
import SnapKit

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
        button.setTitle("Load Data", for: .normal)
        button.addTarget(self, action: #selector(displayData), for: .touchUpInside)
        button.backgroundColor = UIColor(hexString: "2d73fb")
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        view.addSubview(button)
        
        let label1 = UILabel()
        label1.font = UIFont.boldSystemFont(ofSize: 30)
        label1.textAlignment = .center
        view.addSubview(label1)
        label1.snp.makeConstraints {
            maker in
            maker.width.equalTo(view).offset(-40)
            maker.height.equalTo(80)
            maker.top.equalTo(view).offset(100)
        }
        label1.text = "Mapsted Test Case #8"
        
        let label2 = UILabel()
        label2.font = UIFont.boldSystemFont(ofSize: 20)
        label2.textAlignment = .center
        view.addSubview(label2)
        label2.snp.makeConstraints {
            maker in
            maker.width.equalTo(view).offset(-40)
            maker.height.equalTo(80)
            maker.top.equalTo(label1).offset(100)
        }
        label2.text = "Mostafa Gamal"
        
        let label3 = UILabel()
        label3.font = UIFont.boldSystemFont(ofSize: 16)
        label3.textAlignment = .center
        view.addSubview(label3)
        label3.snp.makeConstraints {
            maker in
            maker.width.equalTo(view).offset(-40)
            maker.height.equalTo(80)
            maker.top.equalTo(label2).offset(40)
        }
        label3.text = "11th Sept. 2020"
        
        
        button.center = view.center
        // Do any additional setup after loading the view.
    }
    
    @objc func displayData() {
        mainCoordinator.navToBuildingData()
    }


}

