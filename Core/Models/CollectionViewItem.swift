//
//  CollectionViewItem.swift
//  MoosTestCase8
//
//  Created by Mostafa Youssef on 9/11/20.
//  Copyright © 2020 Phzio. All rights reserved.
//

class CollectionViewItemBase {
    var width: Double?
    var height: Double?
    var itemTag: String?
}
class CollectionViewItem: CollectionViewItemBase {
    var iconName: String?
    var label: String
    var accessoryIconName: String?
    var isSection: Bool = false
    var sectionVisible: Bool = true
    var subItems: [CollectionViewItem]?
    weak var dataSource: CollectionViewDataSourceProtocol?
    
    init(label: String,
         iconName: String? = nil,
         accessoryIconName: String? = nil,
         cellWidth: Double? = nil,
         cellHeight: Double?,
         itemTag: String? = nil,
         isSection: Bool = false,
         sectionVisible: Bool = true,
         subItems: [CollectionViewItem]? = nil) {
    
        self.label = label
        self.iconName = iconName
        self.accessoryIconName = accessoryIconName
        self.isSection = isSection
        self.sectionVisible = sectionVisible
        self.subItems = subItems
        
        super.init()
        self.width = cellWidth
        self.height = cellHeight
        self.itemTag = itemTag
    }
}
