//
//  UIViewController.swift
//  PrimeDateWeather
//
//  Created by Manab Kumar Mal on 19/07/21.
//

import Foundation
import UIKit
extension UIViewController {
    // MARK: - Message Error
    func showMessage( title: String, message: String, handler: ((_ action: UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController( title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(
            UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: handler)
        )
        present(alert, animated: true, completion: nil)
    }
}
