//
//  ViewController.swift
//  Filterer
//
//  Created by Jack on 2015-09-22.
//  Copyright © 2015 UofT. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var filteredImage: UIImage?
    let image = UIImage(named:"scenery")
    var filterType = 0
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var secondaryMenu: UIView!
    @IBOutlet var bottomMenu: UIView!
    
    @IBOutlet var filterButton: UIButton!
    
    @IBOutlet weak var compare: UIButton!
    @IBOutlet weak var imagebut: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        secondaryMenu.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        secondaryMenu.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = image
        filteredImage = image
        self.compare.enabled = false
        
            }

    // MARK: Share
    @IBAction func onShare(sender: AnyObject) {
        let activityController = UIActivityViewController(activityItems: ["Check out our really cool app", imageView.image!], applicationActivities: nil)
        presentViewController(activityController, animated: true, completion: nil)
    }
    
    // MARK: New Photo
    @IBAction func onNewPhoto(sender: AnyObject) {
        let actionSheet = UIAlertController(title: "New Photo", message: nil, preferredStyle: .ActionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .Default, handler: { action in
            self.showCamera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Album", style: .Default, handler: { action in
            self.showAlbum()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        self.presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    func showCamera() {
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .Camera
        
        presentViewController(cameraPicker, animated: true, completion: nil)
    }
    
    func showAlbum() {
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .PhotoLibrary
        
        presentViewController(cameraPicker, animated: true, completion: nil)
    }
    
    // MARK: UIImagePickerControllerDelegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        dismissViewControllerAnimated(true, completion: nil)
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = image
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: Filter Menu
    @IBAction func onFilter(sender: UIButton) {
        if (sender.selected) {
            hideSecondaryMenu()
            sender.selected = false
        } else {
            showSecondaryMenu()
            sender.selected = true
        }
    }
    
    @IBAction func RedFilter(sender: AnyObject) {
        self.compare.enabled = true
        var rgbImage = RGBAImage(image: image!)
        
        let avgRed = 107
        
        for y in 0..<rgbImage!.height {
            for x in 0..<rgbImage!.width{
                let index = y * rgbImage!.width + x
                var pixel = rgbImage!.pixels[index]
                let redDelta = Int(pixel.red) - avgRed
                var modifier = 1 + 4 * (Double(y)/Double(rgbImage!.height))
                if (Int(pixel.red)<avgRed){
                    modifier = 1
                }
                pixel.red = UInt8(max(min(255,Int(round(Double(avgRed) + modifier * Double(redDelta)))),0))
                rgbImage?.pixels[index] = pixel
                
            }
            
        }
        let result = rgbImage!.toUIImage()
        imageView.image = result
        filteredImage = result
        filterType = 1
        self.imageView.alpha = 0.5
        UIView.animateWithDuration(2) {
            self.imageView.alpha = 1.0
        }

    }
    
    @IBAction func GreenFilter(sender: AnyObject) {
         self.compare.enabled = true
        var rgbImage = RGBAImage(image: image!)
        
        let avgGreen = 110
        
        for y in 0..<rgbImage!.height {
            for x in 0..<rgbImage!.width{
                let index = y * rgbImage!.width + x
                var pixel = rgbImage!.pixels[index]
                let redDelta = Int(pixel.green) - avgGreen
                var modifier = 1 + 4 * (Double(y)/Double(rgbImage!.height))
                if (Int(pixel.green)<avgGreen){
                    modifier = 1
                }
                pixel.green = UInt8(max(min(255,Int(round(Double(avgGreen) + modifier * Double(redDelta)))),0))
                rgbImage?.pixels[index] = pixel
                
            }
            
        }
        let result = rgbImage!.toUIImage()
        imageView.image = result
        filteredImage = result
         filterType = 2
        self.imageView.alpha = 0.5
        UIView.animateWithDuration(2) {
            self.imageView.alpha = 1.0
        }
        
        
    }
    @IBAction func BlueFilter(sender: AnyObject) {
         self.compare.enabled = true
        var rgbImage = RGBAImage(image: image!)
        
        let avgBlue = 120
        
        for y in 0..<rgbImage!.height {
            for x in 0..<rgbImage!.width{
                let index = y * rgbImage!.width + x
                var pixel = rgbImage!.pixels[index]
                let redDelta = Int(pixel.blue) - avgBlue
                var modifier = 1 + 4 * (Double(y)/Double(rgbImage!.height))
                if (Int(pixel.blue)<avgBlue){
                    modifier = 1
                }
                pixel.blue = UInt8(max(min(255,Int(round(Double(avgBlue) + modifier * Double(redDelta)))),0))
                rgbImage?.pixels[index] = pixel
                
            }
            
        }
        let result = rgbImage!.toUIImage()
        imageView.image = result
        filteredImage = result
         filterType = 3
        self.imageView.alpha = 0.5
        UIView.animateWithDuration(2) {
            self.imageView.alpha = 1.0
        }
        
    }
    
    @IBAction func YellowFilter(sender: AnyObject) {
         self.compare.enabled = true
        var rgbImage = RGBAImage(image: image!)
        
        let avgBlue = 120
        
        for y in 0..<rgbImage!.height {
            for x in 0..<rgbImage!.width{
                let index = y * rgbImage!.width + x
                var pixel = rgbImage!.pixels[index]
                if (Int(pixel.blue)<avgBlue){
                pixel.blue = UInt8(0)
                }
                rgbImage?.pixels[index] = pixel
                
            }
            
        }
        let result = rgbImage!.toUIImage()
        imageView.image = result
        filteredImage = result
         filterType = 4
        self.imageView.alpha = 0.5
        UIView.animateWithDuration(2) {
            self.imageView.alpha = 1.0
        }

    }
    
    @IBAction func PurpleFilter(sender: AnyObject) {
         self.compare.enabled = true
        var rgbImage = RGBAImage(image: image!)
        
        let avgGreen = 110
        
        for y in 0..<rgbImage!.height {
            for x in 0..<rgbImage!.width{
                let index = y * rgbImage!.width + x
                var pixel = rgbImage!.pixels[index]
                if (Int(pixel.green)<avgGreen){
                    pixel.green = UInt8(0)
                }
                rgbImage?.pixels[index] = pixel
                
            }
            
        }
        let result = rgbImage!.toUIImage()
        imageView.image = result
        filteredImage = result
         filterType = 5
        self.imageView.alpha = 0.5
        UIView.animateWithDuration(2) {
            self.imageView.alpha = 1.0
        }

        
    }
    
    @IBAction func onCompare(sender: UIButton) {
        if (sender.selected) {
            imageView.image = filteredImage
            self.imageView.alpha = 0.5
            UIView.animateWithDuration(2) {
                self.imageView.alpha = 1.0
            }
            sender.selected = false
        } else {
            imageView.image = image
            self.imageView.alpha = 0.5
            UIView.animateWithDuration(2) {
                self.imageView.alpha = 1.0
            }
            sender.selected = true
        }

        
    }
    
    @IBAction func Butup(sender:AnyObject){
    imageView.image = filteredImage
        self.imageView.alpha = 0.5
        UIView.animateWithDuration(2) {
            self.imageView.alpha = 1.0
        }

    print("suleto")
    }
    
    @IBAction func Butdown(sender:AnyObject){
        imageView.image = image
        self.imageView.alpha = 0.5
        UIView.animateWithDuration(2) {
            self.imageView.alpha = 1.0
        }
        
        print("aplastado")
    }

    @IBAction func intensity(sender: UISlider) {
        let x = sender.value
        switch filterType {
       
        case 1:
            var rgbImage = RGBAImage(image: image!)
            
            let avgRed = x * 107
            
            for y in 0..<rgbImage!.height {
                for x in 0..<rgbImage!.width{
                    let index = y * rgbImage!.width + x
                    var pixel = rgbImage!.pixels[index]
                    let redDelta = Int(pixel.red) - Int(avgRed)
                    var modifier = 1 + 4 * (Double(y)/Double(rgbImage!.height))
                    if (Int(pixel.red)<Int(avgRed)){
                        modifier = 1
                    }
                    pixel.red = UInt8(max(min(255,Int(round(Double(avgRed) + modifier * Double(redDelta)))),0))
                    rgbImage?.pixels[index] = pixel
                    
                }
                
            }
            let result = rgbImage!.toUIImage()
            imageView.image = result
            filteredImage = result
            
            break
        case 2:
            var rgbImage = RGBAImage(image: image!)
            
            let avgGreen = x * 110
            
            for y in 0..<rgbImage!.height {
                for x in 0..<rgbImage!.width{
                    let index = y * rgbImage!.width + x
                    var pixel = rgbImage!.pixels[index]
                    let redDelta = Int(pixel.green) - Int(avgGreen)
                    var modifier = 1 + 4 * (Double(y)/Double(rgbImage!.height))
                    if (Int(pixel.green)<Int(avgGreen)){
                        modifier = 1
                    }
                    pixel.green = UInt8(max(min(255,Int(round(Double(avgGreen) + modifier * Double(redDelta)))),0))
                    rgbImage?.pixels[index] = pixel
                    
                }
                
            }
            let result = rgbImage!.toUIImage()
            imageView.image = result
            filteredImage = result
            break
        case 3:
            var rgbImage = RGBAImage(image: image!)
            
            let avgBlue = x * 120
            
            for y in 0..<rgbImage!.height {
                for x in 0..<rgbImage!.width{
                    let index = y * rgbImage!.width + x
                    var pixel = rgbImage!.pixels[index]
                    let redDelta = Int(pixel.blue) - Int(avgBlue)
                    var modifier = 1 + 4 * (Double(y)/Double(rgbImage!.height))
                    if (Int(pixel.blue)<Int(avgBlue)){
                        modifier = 1
                    }
                    pixel.blue = UInt8(max(min(255,Int(round(Double(avgBlue) + modifier * Double(redDelta)))),0))
                    rgbImage?.pixels[index] = pixel
                    
                }
                
            }
            let result = rgbImage!.toUIImage()
            imageView.image = result
            filteredImage = result
            break
        case 4:
            var rgbImage = RGBAImage(image: image!)
            
            let avgBlue = x * 120
            
            for y in 0..<rgbImage!.height {
                for x in 0..<rgbImage!.width{
                    let index = y * rgbImage!.width + x
                    var pixel = rgbImage!.pixels[index]
                    if (Int(pixel.blue)<Int(avgBlue)){
                        pixel.blue = UInt8(0)
                    }
                    rgbImage?.pixels[index] = pixel
                    
                }
                
            }
            let result = rgbImage!.toUIImage()
            imageView.image = result
            filteredImage = result
            break
        case 5:
            var rgbImage = RGBAImage(image: image!)
            
            let avgGreen = x * 110
            
            for y in 0..<rgbImage!.height {
                for x in 0..<rgbImage!.width{
                    let index = y * rgbImage!.width + x
                    var pixel = rgbImage!.pixels[index]
                    if (Int(pixel.green)<Int(avgGreen)){
                        pixel.green = UInt8(0)
                    }
                    rgbImage?.pixels[index] = pixel
                    
                }
                
            }
            let result = rgbImage!.toUIImage()
            imageView.image = result
            filteredImage = result
            break
        default: break
            
        }
        
    }

    
    func showSecondaryMenu() {
        view.addSubview(secondaryMenu)
        
        let bottomConstraint = secondaryMenu.bottomAnchor.constraintEqualToAnchor(bottomMenu.topAnchor)
        let leftConstraint = secondaryMenu.leftAnchor.constraintEqualToAnchor(view.leftAnchor)
        let rightConstraint = secondaryMenu.rightAnchor.constraintEqualToAnchor(view.rightAnchor)
        
        let heightConstraint = secondaryMenu.heightAnchor.constraintEqualToConstant(44)
        
        NSLayoutConstraint.activateConstraints([bottomConstraint, leftConstraint, rightConstraint, heightConstraint])
        
        view.layoutIfNeeded()
        
        self.secondaryMenu.alpha = 0
        UIView.animateWithDuration(0.4) {
            self.secondaryMenu.alpha = 1.0
        }
    }

    func hideSecondaryMenu() {
        UIView.animateWithDuration(0.4, animations: {
            self.secondaryMenu.alpha = 0
            }) { completed in
                if completed == true {
                    self.secondaryMenu.removeFromSuperview()
                }
        }
    }

}

