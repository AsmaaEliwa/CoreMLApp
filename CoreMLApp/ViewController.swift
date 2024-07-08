//
//  ViewController.swift
//  CoreMLApp
//
//  Created by asmaa gamal  on 08/07/2024.
//

import UIKit
import Vision
import CoreML
class ViewController: UIViewController ,UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    @IBOutlet weak var imageView: UIImageView!
    let imagePicker = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
    }
     func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [ UIImagePickerController.InfoKey: Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = image
        }
        imagePicker.dismiss(animated: true)
    }
    @IBAction func cameraButton(_ sender: UIBarButtonItem) {
        present(imagePicker, animated: true, completion: nil)
    }
    
}

