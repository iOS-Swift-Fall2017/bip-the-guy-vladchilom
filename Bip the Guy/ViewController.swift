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
  
  override func viewDidLoad() {
    super.viewDidLoad()
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
  
  @IBAction func libraryPressed(_ sender: UIButton) {
  }
  
  @IBAction func cameraPressed(_ sender: UIButton) {
  }
  
  @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
    animateImage()
    playSound(soundName: "punchSound", audioPlayer: &audioPlayer)
  }
  
}
