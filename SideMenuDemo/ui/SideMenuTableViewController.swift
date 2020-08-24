//
//  SideMenuTableViewController.swift
//  SideMenuDemo
//
//  Created by Abdul Basit on 8/21/20.
//  Copyright © 2020 MushHub. All rights reserved.
//

import UIKit
import SideMenu

class SideMenuTableViewController: UITableViewController {
    
    @IBOutlet weak var navImageView: UIImageView!
    let indexPref = UserDefaults.standard
    let profilePref = UserDefaults.standard
    let indexKey = "row_index"
    var indexValue = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // refresh cell blur effect in case it changed
        tableView.reloadData()
        let selectedRow = indexPref.integer(forKey: indexKey)
        let index = IndexPath(row: selectedRow, section: 0)
        tableView.selectRow(at: index, animated: true, scrollPosition: .top)
        
        createCircularImagView()
        
        if let url = profilePref.url(forKey: "nav_pic") {
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    navImageView.image = image
                }
            }
        }
        
    }
    
    func createCircularImagView() {
        navImageView.layer.borderWidth = 1.0
        navImageView.layer.masksToBounds = false
        navImageView.layer.borderColor = UIColor.white.cgColor
        navImageView.layer.cornerRadius = navImageView.frame.size.width / 2
        navImageView.clipsToBounds = true
        navImageView.contentMode = .scaleAspectFit
    }
    
    
    @IBAction func navHeaderImageBtnTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallery()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            print("home selected")
            let homeViewController = storyboard?.instantiateViewController(identifier: "homeViewController") as! HomeViewController
            self.navigationController?.pushViewController(homeViewController, animated: true)
            
        }else if indexPath.row == 1 {
            print("Favourite selected")
            let favouriteViewController = storyboard?.instantiateViewController(identifier: "favouriteViewController") as! FavouriteViewController
            self.navigationController?.pushViewController(favouriteViewController, animated: true)
            
        }else if indexPath.row == 2 {
            print("Folders selected")
            let foldersViewController = storyboard?.instantiateViewController(identifier: "foldersViewController") as! FoldersViewController
            self.navigationController?.pushViewController(foldersViewController, animated: true)
            
        }
    }
    
}

extension SideMenuTableViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
        else {
            let alert  = UIAlertController(title: "Failure", message: "This device doesn't have the camera functionality", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }
        else {
            let alert  = UIAlertController(title: "Warning", message: "You don't have permission to access gallery.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        if let pickedImage = info[.originalImage] as? UIImage {
            
            let url = info[UIImagePickerController.InfoKey.imageURL] as? URL
            
            navImageView.image = pickedImage
            profilePref.set(url, forKey: "nav_pic")
            
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
}
