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
            if let ciImage = CIImage(image: image) {
                detectImage(ciImage: ciImage )
            }
        }
        imagePicker.dismiss(animated: true)
    }
    func detectImage(ciImage: CIImage){
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model)else {
            return
        }
        let request = VNCoreMLRequest(model: model){ response, error in
            guard let result = response.results as? [ VNClassificationObservation] else {
               return
            }
            print(result.first?.identifier)
            if result.first?.identifier.contains("dam") ?? false{
                self.navigationItem.title = "Water!"
            }else{
                self.navigationItem.title = "Hot Dog"
            }
        }
        let handler = VNImageRequestHandler(ciImage: ciImage)
        try! handler.perform([request])
    }
    @IBAction func cameraButton(_ sender: UIBarButtonItem) {
        present(imagePicker, animated: true, completion: nil)
    }
    
}

