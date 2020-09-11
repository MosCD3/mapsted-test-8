//
//  ListViewCell.swift
//  MoosTestCase8
//
//  Created by Mostafa Youssef on 9/11/20.
//  Copyright © 2020 Phzio. All rights reserved.
//
import UIKit

class ListViewCell: UICollectionViewCell {

//    lazy weak var accessoryIcon: UIImageView

    
//    let label:UILabel = {
//        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
//        label.font = UIFont.boldSystemFont(ofSize: 20)
//        label.textColor = .black
////        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
    
        let label:UITextField = {
            let label = UITextField(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
            label.font = UIFont.boldSystemFont(ofSize: 20)
            label.textColor = .black
    //        label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
    
    let leftIcon:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit // image will never be strecthed vertially or horizontally
        img.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        //        img.layer.cornerRadius = 35
        //        img.clipsToBounds = true
        img.backgroundColor = UIColor(hexString: "#ebebeb")
        return img
    }()
    


    
    var myModel: CollectionViewItem? {
        didSet {
            
            addSubview(label)
            addSubview(leftIcon)
            
            if let iconName = myModel?.iconName , let img = UIImage(named: iconName) {
                leftIcon.image = img
            }
            
//            if let iconName = myModel?.accessoryIconName , let img = UIImage(named: iconName) {
//                accessoryIcon.image = img
//            }
            
//            label.text = myModel?.label
            
            
//            let pic = UIPickerView(frame: CGRect(x: 100, y: 0, width: 100, height: 20))
//            pic.dataSource = self
//            pic.delegate = self
//            addSubview(pic)
            
            let salutations = ["Mr.", "Ms.", "Mrs."]
            label.loadDropdownData(data: salutations)
            dismissPickerView()
        }
    }
    
    func dismissPickerView() {
       let toolBar = UIToolbar()
       toolBar.sizeToFit()
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(actionD))
       toolBar.setItems([button], animated: true)
       toolBar.isUserInteractionEnabled = true
       label.inputAccessoryView = toolBar
    }
    @objc func actionD() {
          endEditing(true)
    }
}

