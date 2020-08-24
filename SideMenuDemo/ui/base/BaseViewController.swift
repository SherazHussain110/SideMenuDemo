//
//  BaseViewController.swift
//  SideMenuDemo
//
//  Created by Abdul Basit on 8/24/20.
//  Copyright © 2020 MushHub. All rights reserved.
//

import UIKit
import SideMenu

class BaseViewController: UIViewController {
    
    let indexPref = UserDefaults.standard
    let indexKey = "row_index"
    var indexValue = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSideMenu()
        updateMenus()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let sideMenuNavigationController = segue.destination as? SideMenuNavigationController else { return }
        sideMenuNavigationController.settings = makeSettings()
    }
    
    public func setupSideMenu() {
        // Define the menus
        SideMenuManager.default.leftMenuNavigationController = storyboard?.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? SideMenuNavigationController
//        SideMenuManager.default.rightMenuNavigationController = storyboard?.instantiateViewController(withIdentifier: "RightMenuNavigationController") as? SideMenuNavigationController
        
        // Enable gestures. The left and/or right menus must be set up above for these to work.
        // Note that these continue to work on the Navigation Controller independent of the View Controller it displays!
        SideMenuManager.default.addPanGestureToPresent(toView: navigationController!.navigationBar)
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: view)
    }
    
    
    public func updateMenus() {
        let settings = makeSettings()
        SideMenuManager.default.leftMenuNavigationController?.settings = settings
        SideMenuManager.default.rightMenuNavigationController?.settings = settings
    }
    
    private func makeSettings() -> SideMenuSettings {
        let modes: [SideMenuPresentationStyle] = [.menuSlideIn, .viewSlideOut, .viewSlideOutMenuIn, .menuDissolveIn]
        let presentationStyle = modes[0]
        presentationStyle.backgroundColor = .white
        presentationStyle.menuStartAlpha = CGFloat(1)
        presentationStyle.menuScaleFactor = CGFloat(1)
        presentationStyle.onTopShadowOpacity = 1
        presentationStyle.presentingEndAlpha = CGFloat(1)
        presentationStyle.presentingScaleFactor = CGFloat(1)
        
        var settings = SideMenuSettings()
        settings.presentationStyle = presentationStyle
        settings.menuWidth = min(view.frame.width, view.frame.height) * CGFloat(0.73)
        let styles:[UIBlurEffect.Style?] = [nil, .dark, .light, .extraLight]
        settings.blurEffectStyle = styles[0]
        settings.statusBarEndAlpha = 0
        
        return settings
        
    }
}

extension BaseViewController: SideMenuNavigationControllerDelegate {
    
    func sideMenuWillAppear(menu: SideMenuNavigationController, animated: Bool) {

//        let colorBlurAffect = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.5)
//        view.backgroundColor = colorBlurAffect
    }
    
    func sideMenuWillDisappear(menu: SideMenuNavigationController, animated: Bool) {
//        view.backgroundColor = .white
    }
    
}
