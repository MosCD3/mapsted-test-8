//
//  GeneralCollectionViewController.swift
//  MoosTestCase8
//
//  Created by Mostafa Youssef on 9/10/20.
//  Copyright © 2020 Phzio. All rights reserved.
//

import UIKit

private let reuseIdentifier = "ListCell"
private let resuseIdentifierHeader = "HeaderCell"

protocol GeneralCollectionViewControllerDelegate: AnyObject {
    func viewDidLoad()
}


class GeneralCollectionViewController: UICollectionViewController {

    weak var delegate: GeneralCollectionViewControllerDelegate?
    var mainCoordinator: GenericCoordinatorProtocol?
    let defaultCellHeight: Double = 50
    var sections: [CollectionViewItem]?
    var items: [CollectionViewItem]?
    var dataSource: CollectionViewDataSourceProtocol
    var uiConfig: UIConfigurationProtocol
    
    
    
    init(mainCoordinator: GenericCoordinatorProtocol?,
         items: [CollectionViewItem]?,
         dataSource: CollectionViewDataSourceProtocol,
         uiConfig: UIConfigurationProtocol) {
        self.mainCoordinator = mainCoordinator
        self.items = items
        self.dataSource = dataSource
        self.uiConfig = uiConfig
        
        if let modelItems = items  {
            let sections = modelItems.filter { row in
                return row.isSection == true
            }
            if sections.count > 0 {
                self.sections = sections
            }
        }

  
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //Use this for xib based cells
        self.collectionView.register(ListViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView.register(UINib(nibName: "HeaderCollectionViewCell", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: resuseIdentifierHeader)
        
        collectionView.backgroundColor = .white
        

        // Do any additional setup after loading the view.
        //if this page has dynamic content, load it
        if dataSource.sourceType() == .dynamicCollection {
            ProgressService.shared.show()
            dataSource.loadCollectionItemsData {
                items in
                if let itemsArr = items {
                   self.items = items
                }
                self.collectionView.reloadData()
               
                ProgressService.shared.hide()
            }
        }
        
        delegate?.viewDidLoad()
        
    }

    // MARK: UICollectionViewDelegate
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if let sections = self.sections, sections.count > 0 {
            return sections.count
        }
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        if
            let sections = self.sections, sections.count > 0,
            let sectionModel = sections.getElement(at: section),
            let subItems = sectionModel.subItems, subItems.count > 0 {
            return subItems.count
        }
        
        if let items = self.items {
            return items.count
        }
        
        return 0
    }
    
    //Header Cell
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        guard kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: resuseIdentifierHeader, for: indexPath) as! HeaderCollectionViewCell

        view.label.text = String(indexPath.section + 1)
        
        if let sections = self.sections, let element = sections.getElement(at: indexPath.section) {
            view.label.text = element.label
        }
        return view
    }

    //Row Cell
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let items = self.sections else {
            LogService.shared.log(message: "92 Items nil!", type: .minor)
            return UICollectionViewCell()
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ListViewCell
        
        if let sections = self.sections, sections.count > 0, let sectionModel = sections.getElement(at: indexPath.section) {
            if let cellModel = sectionModel.subItems?.getElement(at: indexPath.row) {
                
                cell.uiConfig = self.uiConfig
                cellModel.dataSource = self.dataSource
                
                cell.myModel = cellModel
            }
            
        } else {
            if let cellModel = items.getElement(at: indexPath.row) {
                cellModel.dataSource = self.dataSource
               cell.myModel = cellModel
            }
            
        }
        
        cell.backgroundColor = UIColor(hexString: "#eaeaea")
        return cell
    }
    
    //MARK: Event Handlers
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        guard
            let items = self.items,
            let item = items.getElement(at: indexPath.row) else {
                LogService.shared.log(message: "Items nil or no tag", type: .minor)
            return
        }
        
        listitemSelected(item: item, index: indexPath.row)
    }
    

    
    open func listitemSelected(item: CollectionViewItem, index: Int) {
        
    }

    

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}


extension GeneralCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        var height:CGFloat = 0
        if let visible = sections?.getElement(at: section)?.sectionVisible, visible {
            height = 64
        }
        return CGSize(width: collectionView.bounds.size.width, height: height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cellWidth = collectionView.frame.width
        var cellHeight = CGFloat(defaultCellHeight)
        
        
        if
            let items = self.items,
            let item = items.getElement(at: indexPath.row) {
            if let _w = item.width {
                cellWidth = CGFloat(_w)
            }
            if let _h = item.height {
                cellHeight = CGFloat(_h)
            }
            
            
        }
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
    }
}
