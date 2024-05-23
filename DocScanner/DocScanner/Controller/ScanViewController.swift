//
//  ScanViewController.swift
//  DocScanner
//
//  Created by Pranav Athavale on 19/05/21.
//

import UIKit
import Vision
import TOCropViewController
import CoreImage
import CoreImage.CIFilterBuiltins

class ScanViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, TOCropViewControllerDelegate {
    
    
    let imagePicker = UIImagePickerController()
    let CropViewController = TOCropViewController()
    let context = CIContext()
    
    @IBOutlet weak var imageToScan: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
      
        //present(imagePicker, animated: true, completion: nil)
        
        //  imagePicker.sourceType = .photoLibrary
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func cameraButtonPressed(_ sender: UIBarButtonItem) {
        openCamera()
    }
    
    @IBAction func photoLibraryButtonPressed(_ sender: UIBarButtonItem) {
        choosePhoto()
    }
    
    
    
    func openCamera() {
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
    }

    
    func choosePhoto() {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        if let userPickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
       //     imageToScan.image = userPickedImage
            imagePicker.dismiss(animated: true, completion: nil)
            presentCropViewController(pickedImaged: userPickedImage)
            
        }
      
    }
    
    
    func presentCropViewController(pickedImaged: UIImage) {
      let image = pickedImaged
      let cropViewController = TOCropViewController(image: image)
      cropViewController.delegate = self
      present(cropViewController, animated: true, completion: nil)
    }

    func cropViewController(_ cropViewController: TOCropViewController, didCropTo image: UIImage, with cropRect: CGRect, angle: Int) {
        // 'image' is the newly cropped version of the original image
        if let imageToModify = CIImage(image: image) {
            let processedImage = scanFilter(imageToModify)
            imageToScan.image = UIImage(ciImage: processedImage!)
        }
                dismiss(animated: true, completion: nil)
        }
    
    func cropViewController(_ cropViewController: TOCropViewController, didFinishCancelled cancelled: Bool) {
        dismiss(animated: true, completion: nil)
    }
  
    func scanFilter(_ input: CIImage) -> CIImage? {
       
        let filter = CIFilter(name: "CIColorControls")
        filter?.setValue(input, forKey: kCIInputImageKey)
        filter?.setValue(5, forKey: kCIInputContrastKey) // Default 7
        filter?.setValue(1, forKey: kCIInputSaturationKey) //Default 1
        filter?.setValue(1, forKey: kCIInputBrightnessKey) //Default 1.2
      //  filter?.setValue(1, forKey: kCIInputSharpnessKey)
        return filter?.outputImage
    }
    
}







// MARK: - Navigation
/*
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */
