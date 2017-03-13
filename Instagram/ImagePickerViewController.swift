//
//  ImagePickerViewController.swift
//  Instagram
//
//  Created by Ulric Ye on 3/7/17.
//  Copyright © 2017 uye. All rights reserved.
//

import UIKit
import Parse

class ImagePickerViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var descriptionField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var photoShareButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        submitButton.isEnabled = false
        cancelButton.isEnabled = false
        descriptionField.delegate = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tapPhotoButton(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        //vc.sourceType = UIImagePickerControllerSourceType.camera for camera
        vc.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        self.present(vc, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        //let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        // Do something with the images (based on your use case)
        photoShareButton.setBackgroundImage(originalImage, for: .normal)
        photoShareButton.setTitle("", for: .normal)
        
        submitButton.isEnabled = true
        cancelButton.isEnabled = true
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onTap(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    @IBAction func cancelTap(_ sender: Any) {
        self.clearPicker()
    }
    
    @IBAction func submitTap(_ sender: Any) {
        if let image = photoShareButton.backgroundImage(for: .normal) {
            
            Post.postUserImage(image: image, withCaption: descriptionField.text, withCompletion: { (post: PFObject?, error: Error?) in
                if post != nil {
                    print("success")
                    self.clearPicker()
                    
                    let homeVC = self.tabBarController?.viewControllers?[0] as! HomeViewController
                    homeVC.posts?.insert(post!, at: 0)
                    homeVC.tableView.reloadData()
                    
                    self.tabBarController?.selectedIndex = 0
                } else {
                    print(error?.localizedDescription)
                }
            })
        }
    }
    
    
    
    func clearPicker() {
        descriptionField.text = ""
        submitButton.isEnabled = false
        cancelButton.isEnabled = false
        photoShareButton.setTitle("Tap to share photo", for: .normal)
        photoShareButton.setBackgroundImage(nil, for: .normal)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
