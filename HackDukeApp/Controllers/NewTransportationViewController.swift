//
//  NewTransportationViewController.swift
//  HackDukeApp
//
//  Created by Niam Kothari on 12/5/20.
//

import UIKit
import CoreML
import Vision

class NewTransportationViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let imagePicker = UIImagePickerController()
    @IBOutlet weak var imageViewPic: UIImageView!
    
    @IBOutlet weak var unitOutput: UILabel!
    @IBOutlet weak var userInput: UITextField!
    
    @IBOutlet weak var userOutputCarMPG: UILabel!
    @IBOutlet weak var userInputCarMPG: UITextField!
    
    @IBOutlet weak var busButton: UIButton!
    @IBOutlet weak var planeButton: UIButton!
    @IBOutlet weak var carButton: UIButton!
    @IBOutlet weak var trainButton: UIButton!
    
    
    var units: String = ""
    var unitsforCar: String = ""
    var inputMilesDriven: String = ""
    var milesDriven: Double = 0
    var inputConversion: String = ""
    var unitpermile: Double = 0
    
    var subtotal: Double = 0

    var car: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        makeBorder(button: busButton)
        makeBorder(button: carButton)
        makeBorder(button: trainButton)
        makeBorder(button: planeButton)
        
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
        
        self.hideKeyboardWhenTappedAround()
        
 
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
                if firstResult.identifier.contains("plane"){
                    self.planePressed(self.planeButton)
                    //self.navigationController?.title = "Hotdog!"
                    //self.label.text = "Hotdog"
                } else if firstResult.identifier.contains("car") {
                    self.carPressed(self.carButton)
                } else if firstResult.identifier.contains("train") {
                    self.trainPressed(self.trainButton)
                } else if firstResult.identifier.contains("bus") {
                    self.busPressed(self.busButton)
                } else {
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
    
    
    
    @IBAction func carPressed(_ sender: UIButton) {
//        milesDriven = Double(userInput.text ?? "0") ?? 0
//        unitpermile = Double(userInput.text ?? "0") ?? 0
//        unitpermile = Double(inputConversion) ?? 0
        units = "miles"
        unitOutput.text = units
        unitsforCar = "mpg"
        userOutputCarMPG.text = unitsforCar
        userInputCarMPG.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        userOutputCarMPG.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//        subtotal = milesDriven * unitpermile
        car = 1
    }
    @IBAction func busPressed(_ sender: UIButton) {
//        milesDriven = Double(userInput.text ?? "0")!
        unitpermile = 0.36 // pounds per mile
        units = "miles"
        unitOutput.text = units
        userInputCarMPG.backgroundColor = #colorLiteral(red: 0.4646554589, green: 0.7401437163, blue: 0.5439468622, alpha: 1)
        userOutputCarMPG.textColor = #colorLiteral(red: 0.4646554589, green: 0.7401437163, blue: 0.5439468622, alpha: 1)
        
//        subtotal = milesDriven * unitpermile
    }
    
    @IBAction func trainPressed(_ sender: UIButton) {
//        milesDriven = Double(userInput.text ?? "0")!
        unitpermile = 0.0807 // avg of long distance, commuter, subway
        units = "miles"
        unitOutput.text = units
        userInputCarMPG.backgroundColor = #colorLiteral(red: 0.4646554589, green: 0.7401437163, blue: 0.5439468622, alpha: 1)
        userOutputCarMPG.textColor = #colorLiteral(red: 0.4646554589, green: 0.7401437163, blue: 0.5439468622, alpha: 1)
//        subtotal = milesDriven * unitpermile
    }
    
    @IBAction func planePressed(_ sender: UIButton) {
//        milesDriven = Double(userInput.text ?? "0")!
        unitpermile = 0.176
        units = "miles"
        unitOutput.text = units
        userInputCarMPG.backgroundColor = #colorLiteral(red: 0.4646554589, green: 0.7401437163, blue: 0.5439468622, alpha: 1)
        userOutputCarMPG.textColor = #colorLiteral(red: 0.4646554589, green: 0.7401437163, blue: 0.5439468622, alpha: 1)
//        subtotal = milesDriven * unitpermile
    }
    
    @IBAction func addPressed(_ sender: UIButton) {
        if car == 1 {
            subtotal = Double(userInput.text!)! / Double(userInputCarMPG.text!)! * 6.7
            Total.subTotal = Float(subtotal)
            self.performSegue(withIdentifier: "TranspotoSelector", sender: self)
            
        }
        else {
            Total.subTotal = Float(unitpermile * (Double(userInput.text!) ?? 0.0))
            self.performSegue(withIdentifier: "TranspotoSelector", sender: self)
            
        }
        //dismiss(animated: true, completion: viewDidLoad)
        
    }
    
    
    @IBAction func cameraButtonPressed(_ sender: UIBarButtonItem) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    func makeBorder(button: UIButton) {
        button.layer.borderWidth = 1.5
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = busButton.bounds.width / 8
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
