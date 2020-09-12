//
//  ListViewCell.swift
//  MoosTestCase8
//
//  Created by Mostafa Youssef on 9/11/20.
//  Copyright © 2020 Phzio. All rights reserved.
//
import UIKit
import SnapKit

class ListViewCell: UICollectionViewCell {
    
    //    lazy weak var accessoryIcon: UIImageView
    
    
    //    let label:UILabel = {
    //        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
    //        label.font = UIFont.boldSystemFont(ofSize: 20)
    //        label.textColor = .black
    ////        label.translatesAutoresizingMaskIntoConstraints = false
    //        return label
    //    }()
    
    var uiConfig: UIConfigurationProtocol?
    
    let label:UITextField = {
        let label = UITextField()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .black
        //        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dropDownLabel:UITextField = {
        let label = UITextField()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .black
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.backgroundColor = UIColor(hexString: "#CFD8DC")
        //        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let infoLabel:UITextField = {
        let label = UITextField()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .black
        label.text = "0.0"
        //        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    var myModel: CollectionViewItem? {
        didSet {
            
            
            //Add code to set selectedBackgroundView property
            let view = UIView(frame: bounds)
            // Set background color that you want
            view.backgroundColor = UIColor(hexString: "#F3F3F3")
            selectedBackgroundView = view
            
            
            addSubview(label)
            addSubview(dropDownLabel)
            addSubview(infoLabel)
        
            
            dropDownLabel.delegate = self
            
            label.snp.makeConstraints { maker in
                maker.height.equalTo(self)
                maker.width.equalTo(100)
                maker.left.equalTo(self).offset(10)
            }
            
            dropDownLabel.snp.makeConstraints { maker in
                maker.height.equalTo(self)
                maker.width.equalTo(190)
                maker.left.equalTo(label.snp.right).offset(10)
            }
            infoLabel.snp.makeConstraints { maker in
                maker.height.equalTo(self)
                maker.right.equalTo(self.snp.right).offset(-10)
            }
            
            label.text = myModel?.label
            dropDownLabel.text = "DropDown Title Here"
            infoLabel.text = ""
            
            
            
            
            
            if
                let itemTag = myModel?.itemTag,
                let dataSource = myModel?.dataSource {
                
                
                if itemTag == "buildingInfo" {
                    dropDownLabel.text = dataSource.getFamousBuildingName()
                    dropDownLabel.isUserInteractionEnabled = false
                } else if let cellDropDownData = dataSource.getMyCellDropDownData(tag: itemTag) {
                    dropDownLabel.isUserInteractionEnabled = true
                    
                    dropDownLabel.loadDropdownData(data: cellDropDownData) {
                        value in
                        
                        switch itemTag {
                        case "manufacturerInfo":
                            self.manifacturerSelected(value: value)
                        case "categoryInfo" :
                            self.categorySelected(value: value)
                        case "countryInfo" :
                            self.countrySelected(value: value)
                        case "stateInfo" :
                            self.stateSelected(value: value)
                        case "itemsInfo" :
                            self.itemsSelected(value: value)
                        default:
                            LogService.shared.error(message: "94-No action impliment for:\(itemTag)")
                            
                        }
                        
                    }
                    dismissPickerView()
       
                } else {
                    LogService.shared.error(message: "84-Cannot get cell drop down data")
                }
            }
            
            
            
            
            //            let salutations = ["Mr.", "Ms.", "Mrs."]
            //            label.loadDropdownData(data: salutations)
            //            dismissPickerView()
        }
    }
    
    func dismissPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(actionD))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        dropDownLabel.inputAccessoryView = toolBar
    }
    @objc func actionD() {
        endEditing(true)
    }
    
    //MARK: Drop down selection handlers
    func manifacturerSelected(value: String) {
        if let result = self.myModel?.dataSource?.getManifacturerCalcs(company: value) {
            infoLabel.text = "$\(result)"
        }
    }
    func categorySelected(value: String) {
        if let result = self.myModel?.dataSource?.getCategoryCalcs(category: value) {
            infoLabel.text = "$\(result)"
        }
    }
    func countrySelected(value: String) {
        if let result = self.myModel?.dataSource?.getCountryCalcs(country: value) {
            infoLabel.text = "$\(result)"
        }
    }
    func stateSelected(value: String) {
        if let result = self.myModel?.dataSource?.getStateCalcs(state: value) {
            infoLabel.text = "$\(result)"
        }
    }
    func itemsSelected(value: String) {
        if let result = self.myModel?.dataSource?.getItemsCalcs(item: value) {
            infoLabel.text = "\(Int(result))"
        }
    }
}

extension ListViewCell: UITextFieldDelegate {
    //    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    //        if textField == dropDownLabel {
    //            return false; //do not show keyboard nor cursor
    //        }
    //        return true
    //    }
}

