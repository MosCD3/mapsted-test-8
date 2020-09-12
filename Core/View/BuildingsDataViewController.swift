//
//  BuildingsDataViewController.swift
//  MoosTestCase8
//
//  Created by Mostafa Youssef on 9/11/20.
//  Copyright © 2020 Phzio. All rights reserved.
//

import UIKit


protocol BuildingsDataViewControllerDelegate: AnyObject {
    
}
class BuildingsDataViewController: GeneralCollectionViewController {
    
    init(coordinator: GenericCoordinatorProtocol, uiConfig: UIConfigurationProtocol) {
        
        //Section subs
        
       
        let section1Items: [CollectionViewItem] = [
                   CollectionViewItem(label: "Manufacturer",
                                      cellHeight: 60 ,
                                      itemTag: "manufacturerInfo"),
                   CollectionViewItem(label: "Category",
                                      cellHeight: 60,
                                      itemTag: "categoryInfo"),
                   CollectionViewItem(label: "Country",
                                      cellHeight: 60,
                                      itemTag: "countryInfo"),
                   CollectionViewItem(label: "State",
                                      cellHeight: 60,
                                      itemTag: "stateInfo")]
        
        let section2Items: [CollectionViewItem] = [
                   CollectionViewItem(label: "Item",
                                      cellHeight: 60 ,
                                      itemTag: "itemsInfo")]
        
        let section3Items: [CollectionViewItem] = [
            CollectionViewItem(label: "Building",
                               cellHeight: 60 ,
                               itemTag: "buildingInfo")]
        
        //Main Sections
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
        

        
        super.init(mainCoordinator: coordinator,
                   items: items,
                   dataSource: CollectionViewDataSource(pageMdoel: CollectionPageModel.buildingsDataPage,
                                                        itemsArray: items,
                                                        mapper: ModelMapping()),
                   uiConfig: uiConfig)
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


extension BuildingsDataViewController:  BuildingDataManagerDelegate {
    func gotBuildingInfo() {
        ()
    }
}
