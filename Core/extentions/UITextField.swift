//
//  UITextField.swift
//  MoosTestCase8
//
//  Created by Mostafa Youssef on 9/11/20.
//  Copyright © 2020 Phzio. All rights reserved.
//

import UIKit

extension UITextField {
func loadDropdownData(data: [String]) {
    self.inputView = PickerView(pickerData: data, dropdownField: self)
}}
