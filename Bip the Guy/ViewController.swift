//
//  ViewController.swift
//  Bip the Guy
//
//  Created by Vlad Chilom on 9/19/17.
//  Copyright © 2017 chilom. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
  
  
  @IBOutlet weak var imageToPunch: UIImageView!
  var audioPlayer = AVAudioPlayer()
  var imagePicker = UIImagePickerController()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    imagePicker.delegate = self
  }
  
  func animateImage() {
    let bounds = self.imageToPunch.bounds
    let shrinkValue: CGFloat = 60
    self.imageToPunch.bounds = CGRect(x: self.imageToPunch.bounds.origin.x + shrinkValue, y: self.imageToPunch.bounds.origin.y + shrinkValue, width: self.imageToPunch.bounds.size.width - shrinkValue, height: self.imageToPunch.bounds.size.height - shrinkValue)
    UIView.animate(withDuration: 0.25, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: [], animations: { self.imageToPunch.bounds = bounds }, completion: nil)
  }
  
  func playSound(soundName: String, audioPlayer: inout AVAudioPlayer) {
    if let sound = NSDataAsset(name: soundName) {
      do {
        try audioPlayer = AVAudioPlayer(data: sound.data)
        audioPlayer.play()
      } catch {
        print("ERROR: Data from \(soundName) could not be played")
      }
    } else {
      print("ERROR: Could not load data from file \(soundName)")
    }
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
    imageToPunch.image = selectedImage
    dismiss(animated: true, completion: nil)
  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    dismiss(animated: true, completion: nil)
  }
  
  func showAlert(title: String, message: String) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    alertController.addAction(defaultAction)
    present(alertController, animated: true, completion: nil)
  }
  
  @IBAction func libraryPressed(_ sender: UIButton) {
    imagePicker.sourceType = .photoLibrary
    present(imagePicker, animated: true, completion: nil)
  }
  
  @IBAction func cameraPressed(_ sender: UIButton) {
    if UIImagePickerController.isSourceTypeAvailable(.camera) {
      imagePicker.sourceType = .camera
      present(imagePicker, animated: true, completion: nil)
    } else {
      showAlert(title: "Camera Not Available", message: "There is no camera available on this device.")
    }
  }
  
  @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
    animateImage()
    playSound(soundName: "punchSound", audioPlayer: &audioPlayer)
  }
  
}
