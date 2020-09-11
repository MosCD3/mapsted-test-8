//
//  BuildingsDataViewController.swift
//  MoosTestCase8
//
//  Created by Mostafa Youssef on 9/11/20.
//  Copyright © 2020 Phzio. All rights reserved.
//

import UIKit

class BuildingsDataViewController: GeneralCollectionViewController {

    
    init(coordinator: GenericCoordinatorProtocol) {
        
        let section1Items: [CollectionViewItem] = [
                   CollectionViewItem(label: "Purchase Costs",
                                      cellHeight: 60 ,
                                      itemTag: "zoneInfo"),
                   CollectionViewItem(label: "Zone Info.",
                                      cellHeight: 60,
                                      itemTag: "zoneInfo"),
                   CollectionViewItem(label: "My Listings",
                                      cellHeight: 60,
                                      itemTag: "viewMyListings"),
                   CollectionViewItem(label: "Sign Out",
                                      cellHeight: 60,
                                      itemTag: "logOut")]
        
        let section2Items: [CollectionViewItem] = [
                   CollectionViewItem(label: "Purchase Costs",
                                      cellHeight: 60 ,
                                      itemTag: "zoneInfo"),
                   CollectionViewItem(label: "Zone Info.",
                                      cellHeight: 60,
                                      itemTag: "zoneInfo")]
        
        let section3Items: [CollectionViewItem] = [CollectionViewItem(label: "Purchase Costs", cellHeight: 60 , itemTag: "zoneInfo")]
        
        let items: [CollectionViewItem] = [
            CollectionViewItem(label: "Purchase Costs",
                               cellHeight: 60,
                               isSection: true,
                               subItems: section1Items),
            CollectionViewItem(label: "Number of Purchases",
                               cellHeight: 60,
                               isSection: true,
                               subItems: section2Items),
            CollectionViewItem(label: "Most Total Purchases",
                               cellHeight: 60,
                               isSection: true,
                               subItems: section3Items)]
        

        
        super.init(mainCoordinator: coordinator, items: items, dataSource: CollectionViewDataSource(pageMdoel: CollectionPageModel.buildingsDataPage, itemsArray: items))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
