//
//  ConcentrationThemeViewController.swift
//  concentration
//
//  Created by HuangMing on 2018/4/8.
//  Copyright © 2018年 Fruit. All rights reserved.
//

import UIKit

class ConcentrationThemeViewController: UIViewController, UISplitViewControllerDelegate {
    
    let themeSettings = ["Sports": "⚽️🏀🏈⚾️🎾🏐🏉🎱🏓🏸🥅🏒", "Faces": "😁🤣🙂😍😚😛😎😒😕😒🤡🤠", "Animals": "🦋🐌🐚🐞🐶🐰🐨🐷🐱🦊🐯🐽"]


    override func awakeFromNib() {
        splitViewController?.delegate = self
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        if let concenrationVC = secondaryViewController as? ConcentrationViewController {
            if concenrationVC.theme == nil {
                return true
            }
        }
        return false
    }
    
    @IBAction func themeButton(_ sender: UIButton) {
        if let concentrationVC = splitViewDetailConcentrationVC {
            if let themeChoose = sender.currentTitle, let themeString = themeSettings[themeChoose] {
                concentrationVC.theme = themeString
            }
        } else if let concentrationVC = lastedSegueToConcentrationVC {
            if let themeChoose = sender.currentTitle, let themeString = themeSettings[themeChoose] {
                concentrationVC.theme = themeString
            }
            navigationController?.pushViewController(concentrationVC, animated: true)
        } else {
            performSegue(withIdentifier: "Theme", sender: sender)
        }
        
        
    }
    
    private var splitViewDetailConcentrationVC: ConcentrationViewController? {
        return splitViewController?.viewControllers.last as? ConcentrationViewController
    }
    private var lastedSegueToConcentrationVC: ConcentrationViewController?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "Theme" else {
            return
        }
        if let theme = (sender as? UIButton)?.currentTitle, let themeString = themeSettings[theme] {
            let destination = segue.destination as! ConcentrationViewController
            destination.theme = themeString
            lastedSegueToConcentrationVC = destination
        }

    }
  

}
