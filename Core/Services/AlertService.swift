//
//  AlertService.swift
//  MoosTestCase8
//
//  Created by Mostafa Youssef on 9/11/20.
//  Copyright © 2020 Phzio. All rights reserved.
//

import UIKit


protocol AlertServiceDelegate {
    func alertBoxReleased()
}
class AlertService {
    
    var delegate: AlertServiceDelegate?
    
    var ph_attention: String
    var ph_ok: String
    var ph_yes: String
    var ph_cancel: String
    var ph_save: String
    var ph_inputpl: String
    var mainCoordinator: GenericCoordinatorProtocol?
    
    init() {
//        ph_attention = Language.shared.getPhrase(key: "Alert_Att")
//        ph_ok = Language.shared.getPhrase(key: "Ph_Ok")
//        ph_cancel = Language.shared.getPhrase(key: "Ph_Cancel")
//        ph_save = Language.shared.getPhrase(key: "Ph_Save")
//        ph_yes = Language.shared.getPhrase(key: "Ph_Yes")
//        ph_inputpl = Language.shared.getPhrase(key: "Ph_InputPlaceholder")
        ph_attention = "Attention"
        ph_ok = "Ok"
        ph_cancel = "Cancel"
        ph_save = "Save"
        ph_yes = "Yes"
        ph_inputpl = "Enter text"
        
    }
    
    public func setCoordinator(coordinator: GenericCoordinatorProtocol?) {
        self.mainCoordinator = coordinator
    }
    
    func displayAlert(source: UIViewController? = nil, title: String? = nil, message: String, dismissTitle: String? = nil,  ignoreLang: Bool = false, callback:  (()->Void)?  ) {
        
        guard let mainCoordinator = self.mainCoordinator else {
            print("coordinator?!!")
            return
        }
        
        let dismissBtTitle = dismissTitle ?? ph_ok
        let _title = title ?? (ignoreLang ? "Attention!" : ph_attention)
        
        LogService.shared.log(message: "^^ AlertDisplayed ^^ : \(message)", type: .verbose)
        let presenterVc: UIViewController? = source != nil ? source : mainCoordinator.getCurrentVC()
        
        guard let _ = presenterVc else {
            LogService.shared.error(message: "1:AlertService, Cannot get current vc. Alert:[\(message)]", type: .logicalError)
            return
        }
        
        let alert = UIAlertController(title: _title, message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction (title: dismissBtTitle, style: .default) { (UIAlertAction) in
            callback?()
            self.delegate?.alertBoxReleased()
        }
        alert.addAction(dismissAction)
        presenterVc!.present(alert, animated: true, completion: nil)
    
       
    }

    
    func displayInputAlert(title: String? = nil, titleAction: String? = nil, message: String, callback:  ((String?)->Void)? ) {
        
        
        guard let mainCoordinator = self.mainCoordinator else {
            print("coordinator?!!")
            return
        }
        
        let _title = title ?? ph_attention
        let _titleAction = titleAction ?? ph_save
        
        let alertController = UIAlertController(title: _title, message: message, preferredStyle: .alert)
//        let config: TextField.Config = { textField in
//            textField.becomeFirstResponder()
//            textField.textColor = .black
//            textField.placeholder = "Type something"
//            textField.left(image: image, color: .black)
//            textField.leftViewPadding = 12
//            textField.borderWidth = 1
//            textField.cornerRadius = 8
//            textField.borderColor = UIColor.lightGray.withAlphaComponent(0.5)
//            textField.backgroundColor = nil
//            textField.keyboardAppearance = .default
//            textField.keyboardType = .default
//            textField.isSecureTextEntry = true
//            textField.returnKeyType = .done
//            textField.action { textField in
//                // validation and so on
//            }
//        }
        

        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = self.ph_inputpl
        }
        
        let saveAction = UIAlertAction(title: _titleAction, style: UIAlertAction.Style.default, handler: {
            alert -> Void in
            if let firstTextField = alertController.textFields?[0] {
                callback?(firstTextField.text)
            }
            
        })
        let cancelAction = UIAlertAction(title: ph_cancel, style: UIAlertAction.Style.default, handler: {
            (action : UIAlertAction!) -> Void in
            callback?(nil)
        })
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        if let vc = mainCoordinator.getCurrentVC() {
            vc.present(alertController, animated: true, completion: nil)
        } else {
            LogService.shared.error(message: "2:AlertService, Cannot get current vc. Alert:[\(message)]", type: .logicalError)
        }
    }
    
    func displayConfirmAlert(title: String? = nil, titleDismiss: String? = nil, titleConfirm: String? = nil, message: String, callback:  ((Bool)->Void)?  ) {
        
        
        guard let mainCoordinator = self.mainCoordinator else {
            print("coordinator?!!")
            return
        }
        
        let _title = title ?? ph_attention
        let _titleDismiss = titleDismiss ?? ph_cancel
        let _titleConfirm = titleConfirm ?? ph_yes
        
        LogService.shared.log(message: "^^ AlertConfirmDisplayed ^^ : \(message)", type: .verbose)
        guard let vc = mainCoordinator.getCurrentVC() else {
            LogService.shared.error(message: "128:AlertService, Cannot get current vc. Alert:[\(message)]", type: .logicalError)
            return
        }
        let alert = UIAlertController(title: _title, message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction (title: _titleDismiss, style: .default) { (UIAlertAction) in
            callback?(false)
        }
        let confirmAction = UIAlertAction (title: _titleConfirm, style: .default) { (UIAlertAction) in
            callback?(true)
        }
        alert.addAction(dismissAction)
        alert.addAction(confirmAction)
        vc.present(alert, animated: true, completion: nil)
    }

    
    
    func displayActionsheet( target:UIViewController? = nil,  title: String, message: String? , actions: [(String, UIAlertAction.Style)], completion: @escaping (_ index: String) -> Void) {
        
        guard let mainCoordinator = self.mainCoordinator else {
            print("coordinator?!!")
            return
        }
        
        
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        for (_, (title, style)) in actions.enumerated() {
            
           
            //because ipad doesn't display cancel button so turn it to regular action
            var newStyle = style
            if UIDevice.current.userInterfaceIdiom == .pad && style == .cancel {
                newStyle = UIAlertAction.Style.default
            }
            let alertAction = UIAlertAction(title: title, style: newStyle) { (_) in
                completion(title)
            }
            alertViewController.addAction(alertAction)
        }
        
        let vc: UIViewController? = target != nil ? target! : mainCoordinator.getCurrentVC()
        
        guard let presenterVc = vc else {
            LogService.shared.error(message: "164:AlertService, Cannot get current vc. Alert:[\(message)]", type: .logicalError)
            return
        }
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            if let popoverController = alertViewController.popoverPresentationController {
                popoverController.sourceView = vc!.view
                popoverController.sourceRect = CGRect(x: presenterVc.view.bounds.midX, y: presenterVc.view.bounds.midY, width: 0, height: 0)
                popoverController.permittedArrowDirections = []
            }
        }
        
        
        presenterVc.present(alertViewController, animated: true, completion: nil)
        
        
    }
    
    
    public static let shared: AlertService = AlertService()
}
