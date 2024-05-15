//
//  AlertUtils.swift
//  TravelTaipei-HW
//
//  Created by Ting on 2024/5/15.
//

import UIKit

class AlertUtils {
    
    static func showAlert(title: String?, message: String?, actions: [UIAlertAction], presentingViewController: UIViewController?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        for action in actions {
            alert.addAction(action)
        }
        
        presentingViewController?.present(alert, animated: true, completion: nil)
    }

    
    static func showLanguageSelectionAlert(languages: [LanguageCode], presentingViewController: UIViewController, selectionHandler: @escaping (LanguageCode) -> Void) {
        let alert = UIAlertController(title: "Select Language", message: nil, preferredStyle: .actionSheet)
        
        for language in languages {
            let action = UIAlertAction(title: language.rawValue, style: .default) { _ in
                selectionHandler(language)
            }
            alert.addAction(action)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        presentingViewController.present(alert, animated: true, completion: nil)
    }
}
