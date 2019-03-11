//
//  ConcentrationThemeChooserViewController.swift
//  Concentration
//
//  Created by Stanislav on 11.03.2019.
//  Copyright © 2019 Stanislav Kozlov. All rights reserved.
//

import UIKit

class ConcentrationThemeChooserViewController: UIViewController, UISplitViewControllerDelegate {

    
    let themes = [
        "Bodyparts": "👅👁👍👄👂🧠",
        "Faces": "😀😇😍🤬🤢🤠",
        "Animals": "🐶🐻🐭🦊🦁🐯",
        "Sports": "⚽️🏒🚴‍♂️🏉🏋️‍♀️🥊",
        "Food": "🍩🍏🥕🌶🍖🌽",
        "Transport": "🚗🚃🚦🚁✈️🏍"
    ]
    
    override func awakeFromNib() {
        splitViewController?.delegate = self
    }
    //if we want to show the first view controller in split view when in iPhone mode
    func splitViewController(_ splitViewController: UISplitViewController,
                             collapseSecondary secondaryViewController: UIViewController,
                             onto primaryViewController: UIViewController
        ) -> Bool {
        if let cvc = secondaryViewController as? ConcentrationViewController{
            if cvc.theme == nil {
                return true
            }
        }
        return false
    }
    
    @IBAction func changeTheme(_ sender: UIButton) {
        //For iPad we have a split view controller
        if let cvc  = slitViewDetailConcentrationViewController {
            if let themeName = sender.currentTitle, let theme = themes[themeName] {
                cvc.theme = theme
            }
        }//for iPhone we need to show view controller from stack
        else if let cvc = lastSeguedToConcentrationViewController {
            if let themeName = sender.currentTitle, let theme = themes[themeName] {
                cvc.theme = theme
            }
            navigationController?.pushViewController(cvc, animated: true)
        }
        else {
            performSegue(withIdentifier: "Choose Theme", sender: sender)
        }
        
    }
    private var slitViewDetailConcentrationViewController: ConcentrationViewController?{
        return splitViewController?.viewControllers.last as? ConcentrationViewController
    }
    
    // MARK: - Navigation
    
    private var lastSeguedToConcentrationViewController: ConcentrationViewController?

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                if let cvc = segue.destination as? ConcentrationViewController {
                    cvc.theme = theme
                    lastSeguedToConcentrationViewController = cvc
                }
            }
            
        }
    }
 

}
