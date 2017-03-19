//
//  ViewController.swift
//  pw26
//
//  Created by Hugh Hopkins on 04/02/2017.
//  Copyright © 2017 io.pwapp. All rights reserved.
//

import UIKit
import CryptoSwift

class ViewController: UIViewController {
    
    // todo make a separate github for this
    let sitesThatPraticeBadSecruity = ["apple", "lloyds", "bank", "nike", "tesco", "easyjet", "glassdoor", "spearfishingstore", "europcar", "tsb", "hsbc", "rbs", "barclays", "expedia", "three", "nexmo", "wechat"]
    let sitesThatPraticeBetterSecruity = ["zendesk"]
    
    // UI copy buttons
    @IBOutlet weak var buttonCopyNormal: UIButton!
    @IBOutlet weak var buttonCopy15CharYes: UIButton!
    @IBOutlet weak var buttonCopySpecialChar: UIButton!
    @IBOutlet weak var buttonWebsiteLink: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        showHide()
        showHideLink()
        
        
        // little touches
        serviceInput.autocorrectionType = UITextAutocorrectionType.no
        serviceInput.autocapitalizationType = UITextAutocapitalizationType.none
        
        buttonCopyNormal.layer.cornerRadius = 5
        buttonCopy15CharYes.layer.cornerRadius = 5
        buttonCopySpecialChar.layer.cornerRadius = 5
        buttonWebsiteLink.layer.cornerRadius = 5
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true;
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // UI
    @IBOutlet weak var serviceInput: UITextField!
    @IBAction func serviceInputEdit(_ sender: Any) {
        update()
    }
    
    @IBOutlet weak var passwordInput: UITextField!
    @IBAction func passwordInputEdit(_ sender: Any) {
        update()
    }
    
    @IBOutlet weak var pwOutput: UILabel!
    
    // PW code
    var pwNew: String = ""
    var shorterPW: String = ""
    var shorterPWCopy: String = ""
    var specialCharPW: String = ""
    var specialCharPWCopy: String = ""
    
//    func visualisePWUpdates () {
//        if sitesThatPraticeBadSecruity.contains(serviceInput.text!.lowercased()) {
//            print("(" + "\(pwNew.characters.prefix(15))" + ")" + " " + "\(pwNew.characters.suffix(25))")
//        }
    
    func update() {
        showHide()
        showHideLink()
        
        let srv: String = serviceInput.text!
        let pass: String = passwordInput.text!
        let srvLower = srv.lowercased()
        var pwHash = "\(srvLower)||\(pass)||".sha1()
        
        var pwLowered = pwHash.lowercased()
        
        var index = 0
        
        func updateTwo() {
            for string in pwLowered.characters {
                let s = "\(string)"
                if index % 2 == 0 {
                    pwNew += s.uppercased()
                } else {
                    pwNew += s
                }
                index += 1;
            }
            test()
        }
        updateTwo()
        
        func updateThree() {
            pwNew = ""
        }
        updateThree()
    }
    
    // to do clean all of this up
    // to do play around with text colour change
    var shortershortPW: String = ""
    var restOfThePW: String = ""
    func test () {
        
        shortershortPW = String(pwNew.characters.prefix(15))
        restOfThePW = String(pwNew.characters.suffix(25))
        print("lets see if this is even working")
        print("shortershortPW = " + shortershortPW)
        print("restOfThePW = " + restOfThePW)
        if sitesThatPraticeBadSecruity.contains(serviceInput.text!.lowercased()) {
            print("(" + "\(shortershortPW)" + ")" + "\(restOfThePW)")
            pwOutput.text = "\(shortershortPW)" + "  " + "\(restOfThePW)"
        } else if sitesThatPraticeBetterSecruity.contains(serviceInput.text!.lowercased()) {
            pwOutput.text = "\(pwNew)" + " (*)"
            print(pwNew)
        } else {
            pwOutput.text = pwNew
        }
    }
    
    // buttons
    @IBAction func copyNormal(_ sender: Any) {
        UIPasteboard.general.string = pwOutput.text
    }
    
    @IBAction func copy15CharYes(_ sender: Any) {
        shorterPW = pwOutput.text!
        shorterPWCopy = String(shorterPW.characters.prefix(15))
        UIPasteboard.general.string = shorterPWCopy
    }
    
    @IBAction func copySpecialChar(_ sender: Any) {
        specialCharPW = pwOutput.text!
        specialCharPWCopy = "\(specialCharPW)" + "*"
        print("specialCharPWCopy = " + specialCharPWCopy)
    }
    
    
    @IBAction func websiteLink(_ sender: Any) {
        if let url = URL(string: "http://pwapp.io/?utm_source=iOS&utm_medium=link&utm_content=footer&utm_campaign=iOS") {
            UIApplication.shared.openURL(url)
        }
    }
    
    // Show / hide different UI elements
    
    func showHide () {
        if serviceInput.text! == "" && passwordInput.text! == "" {
            pwOutput.isHidden = true
            buttonCopyNormal.isHidden = true
            buttonCopy15CharYes.isHidden = true
            buttonCopySpecialChar.isHidden = true
        } else if sitesThatPraticeBadSecruity.contains(serviceInput.text!.lowercased()) {
            buttonCopyNormal.isHidden = false
            buttonCopy15CharYes.isHidden = false
        } else if sitesThatPraticeBetterSecruity.contains(serviceInput.text!.lowercased()) {
            buttonCopyNormal.isHidden = false
            buttonCopySpecialChar.isHidden = false
        } else {
            pwOutput.isHidden = false
            buttonCopyNormal.isHidden = false
            buttonCopy15CharYes.isHidden = true
        }
    }
    

    // todo hide buttonWebsiteLink on iPhone 5 SE
    func showHideLink () {
        if UIDeviceOrientationIsLandscape(UIDevice.current.orientation) {
            print("Landscape")
            buttonWebsiteLink.isHidden = true
        } else {
            buttonWebsiteLink.isHidden = false
        }
    }
    
// end
}

