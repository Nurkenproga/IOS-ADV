//
//  ViewController.swift
//  Nurken
//
//  Created by Nurken on 02.02.2025.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var ThemeView: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let isDarkMode = UserDefaults.standard.value(forKey: "darkMode") as? Bool {
            ThemeView.isOn = isDarkMode
            overrideUserInterfaceStyle = isDarkMode ? .dark : .light
        }
        
    }
    
    @IBAction func SwitchToggled(_ sender: UISwitch) {
        let isDark = sender.isOn
        UserDefaults.standard.setValue(isDark, forKey: "darkMode")
        
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = scene.windows.first {
            window.overrideUserInterfaceStyle = isDark ? .dark : .light
        }

        
        
    }
}
