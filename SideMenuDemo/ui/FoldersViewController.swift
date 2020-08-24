//
//  FoldersViewController.swift
//  SideMenuDemo
//
//  Created by Abdul Basit on 8/21/20.
//  Copyright © 2020 MushHub. All rights reserved.
//

import UIKit
import SideMenu

class FoldersViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        indexPref.set(2, forKey: indexKey)
        
    }
    

    @IBAction func menuBtnTapped(_ sender: UIBarButtonItem) {
//         let menu = storyboard!.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as! SideMenuNavigationController
//        present(menu, animated: true, completion: nil)
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
