//
//  FoodsViewController.swift
//  HackDukeApp
//
//  Created by Andy Kotz on 12/5/20.
//

import UIKit
import CoreML
import Vision

class FoodsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource,  UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    @IBOutlet weak var LABEL: UILabel!
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    @IBOutlet weak var unitInput: UITextField!
    @IBOutlet weak var picker: UIPickerView!
    var pickedFood: String = ""
    
    

    @IBOutlet weak var imageViewPic: UIImageView!
    let imagePicker = UIImagePickerController()
    
    
    
    
    var pickerData = ["Choose one of the following", "Beef", "Lamb", "Cheese", "Chocolate","Coffee","Pork","Poultry","Farmed Fish","Fresh Fish","Eggs","Milk","Wheat","Sugar","Fruits & Vegetables"]
    var dicPick = ["Empty":0, "Beef":60, "Lamb":24, "Cheese":21, "Chocolate":19,"Coffee":17,"Pork":7,"Poultry":6,"Farmed Fish":5,"Fresh Fish":3,"Eggs":4.5,"Milk":3,"Wheat":1.5,"Sugar":3,"Fruits & Vegetables":0.5]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let sideView = UIPickerView()
        sideView.frame = self.view.frame
        // Connect data:
        self.picker.delegate = self
        self.picker.dataSource = self
        // Input the data into the array
        
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
        
        self.hideKeyboardWhenTappedAround()

    }
    
    
    @IBAction func cameraButtonTapped(_ sender: UIBarButtonItem) {
        print("hi")
        present(imagePicker, animated: true, completion: nil)
    }

    
    func detect(image: CIImage) {
        print("made it here")
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else {// new instance of the ml model
            fatalError("Loading coreml model failed")
        }
        let request = VNCoreMLRequest(model: model) { (request, error) in
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Could not reclassify model after processing image")
            }
            if let firstResult = results.first {
                print(firstResult, "HELLO")
                let first = firstResult.identifier
                self.setSelfPicked(for: first)
                print(self.pickedFood)
                
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

        
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickedFood = pickerData[row]
//        print(row)
    }
    


    @IBAction func addButtonpressed(_ sender: UIButton) {
        print(pickedFood)
        if let food = dicPick[pickedFood] {
            Total.subTotal = Float(food)*Float(unitInput.text!)!
            self.performSegue(withIdentifier: "foodToSelector" , sender: self)
        }
        print("There was an error - consider trying a better picture")
        self.performSegue(withIdentifier: "foodToSelector" , sender: self)
        
        
        //dismiss(animated: true, completion: nil)
        
    }
    
    func setSelfPicked(for first: String) {
        if first.contains("hotdog") || first.contains("pork"){
            self.pickedFood = "Pork"
        } else if first.contains("hamburger") || first.contains("cheeseburger") || first.contains("beef"){
            self.pickedFood = "Beef"
        } else if first.contains("lamb") {
            self.pickedFood = "Lamb"
        } else if first.contains("cheese") {
            self.pickedFood = "Cheese"
        } else if first.contains("chocolate") {
            self.pickedFood = "Chocolate"
        } else if first.contains("coffee") {
            self.pickedFood = "Coffee"
        } else if first.contains("cheese") {
            self.pickedFood = "Cheese"
        } else if first.contains("chicken") || first.contains("poultry") || first.contains("rotisserie"){
            self.pickedFood = "Poultry"
        } else if first.contains("cheese") {
            self.pickedFood = "Cheese"
        } else if first.contains("fish") {
            self.pickedFood = "Farmed Fish"
        } else if first.contains("eggs") {
            self.pickedFood = "Eggs"
        } else if first.contains("milk") || first.contains("packet") {
            self.pickedFood = "Milk"
        } else if first.contains("wheat") || first.contains("bread") {
            self.pickedFood = "Wheat"
        } else if first.contains("sugar") {
            self.pickedFood = "Sugar"
        } else if first.contains("fruit") || first.contains("vegetable") {
            self.pickedFood = "Fruits & Vegetables"
        }
        else {
            print("No options were selected from picture")
        }
    }
}
