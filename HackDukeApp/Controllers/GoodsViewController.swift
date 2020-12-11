//
//  GoodsViewController.swift
//  HackDukeApp
//
//  Created by Andy Kotz on 12/5/20.
//

import UIKit
import CoreML
import Vision

class GoodsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource,  UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var pickedFood: String = ""
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var imageViewPic: UIImageView!
    
    var pickerData = ["Choose one of the following", "Plastic Bottle","Soap/Shampoo","T-Shirt","Jeans", "Rain Jacket","Running Shoes"]
    var dicPick = ["Empty":0, "Plastic Bottle":4.5,"Soap/Shampoo":0.007,"T-Shirt":19.14,"Jeans":73.48, "Rain Jacket":39.6,"Running Shoes":30.8]
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let sideView = UIPickerView()
        sideView.frame = self.view.frame
        // Connect data:
        self.picker.delegate = self
        self.picker.dataSource = self
        
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
        
        self.hideKeyboardWhenTappedAround()
        
        
        // Input the data into the array

    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let userPickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageViewPic.image = userPickedImage
            
            guard let ciImage = CIImage(image: userPickedImage) else {
                fatalError("Could not convert to CIImage")
            }
            detect(image: ciImage)
            
            
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    
    func detect(image: CIImage) {
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else {// new instance of the ml model
            fatalError("Loading coreml model failed")
        }
        
        let request = VNCoreMLRequest(model: model) { (request, error) in
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Could not reclassify model after processing image")
            }
            if let firstResult = results.first {
                print(firstResult)
                /*
                 this is where the ml result is, could either send result to another class to process the results or have the if statements all here - just need 4 for this class
                 */
                let first = firstResult.identifier
                if first.contains("bottle") || first.contains("water") || first.contains("water bottle") {
                    self.pickedFood = "Plastic Bottle"
                } else if first.contains("soap") || first.contains("shampoo") {
                    self.pickedFood = "Soap/Shampoo"
                } else if first.contains("shirt") {
                    self.pickedFood = "T-Shirt"
                } else if first.contains("pant") {
                    self.pickedFood = "Jeans"
                } else if first.contains("jacket") {
                    self.pickedFood = "Rain Jacket"
                } else if first.contains("shoe"){
                    self.pickedFood = "Running Shoes"
                } else{
                    print("Unable to Identify object")
                    //self.label.text = "Not Hotdog"
                }
            }
            
        }
        let handler = VNImageRequestHandler(ciImage: image)
        do{
            try handler.perform([request])
        }
        catch{
            print(error)
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickedFood = pickerData[row]
    }
    
    @IBOutlet weak var unitInput: UITextField!
    
    @IBAction func leaveGoods(_ sender: UIButton) {
        if let thing = dicPick[pickedFood] {
            Total.subTotal = Float(thing)*Float(unitInput.text!)!
            //self.performSegue(withIdentifier: "goodsToSelector" , sender: self)
        }
        print("Try again with better picture")
        
        self.performSegue(withIdentifier: "goodsToSelector" , sender: self)
        //dismiss(animated: true, completion: nil)
    }

    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        present(imagePicker, animated: true, completion: nil)
    }
}

