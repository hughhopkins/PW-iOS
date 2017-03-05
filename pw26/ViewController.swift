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
    
    // UI copy buttons
    @IBOutlet weak var buttonCopyNormal: UIButton!
    @IBOutlet weak var buttonCopy15CharYes: UIButton!
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
            pwOutput.text = pwNew
        }
        updateTwo()
        
        func updateThree() {
            pwNew = ""
        }
        updateThree()
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
    
    @IBAction func websiteLink(_ sender: Any) {
        if let url = URL(string: "http://pwapp.io/?utm_source=iOS&utm_medium=link&utm_content=footer&utm_campaign=iOS") {
            UIApplication.shared.openURL(url)
        }
    }
    
    // Show / hide different UI elements
    func showHide () {
        let sites = ["apple", "lloyds", "bank", "nike", "tesco", "easyjet", "glassdoor", "spearfishingstore", "europcar", "tsb", "hsbc", "rbs", "barclays", "expedia", "three", "nexmo", "wechat"]
        if serviceInput.text! == "" && passwordInput.text! == "" {
            pwOutput.isHidden = true
            buttonCopyNormal.isHidden = true
            buttonCopy15CharYes.isHidden = true
        } else if sites.contains(serviceInput.text!.lowercased()) {
            buttonCopyNormal.isHidden = false
            buttonCopy15CharYes.isHidden = false
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

