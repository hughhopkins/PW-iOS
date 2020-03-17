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
    
    // this wasn't such a great idea in practice. Enable 15 char for everything but maybe highlight it instead?
    let sitesThatPraticeBadSecruity = ["apple", "lloyds", "bank", "nike", "tesco", "easyjet", "glassdoor", "spearfishingstore", "europcar", "tsb", "hsbc", "rbs", "barclays", "expedia", "three", "nexmo", "wechat", "line", "natwest"]
    // Even worse than the above. Should just create new version.
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
    
    func update() {
        showHide()
        showHideLink()
        
        let srv: String = serviceInput.text!
        let pass: String = passwordInput.text!
        let srvLower = srv.lowercased()
        var pwHash = "\(srvLower)||\(pass)||".sha1()
        var pwLowered = pwHash.lowercased()
        var index = 0
        
        func pwCapitalising() {
            for string in pwLowered {
                let s = "\(string)"
                if index % 2 == 0 {
                    pwNew += s.uppercased()
                } else {
                    pwNew += s
                }
                index += 1;
            }
            pwTextFormatting()
        }
        pwCapitalising()
        pwRefresh()
    }
    
    // to do clean all of this up
    // to do play around with text colour change
    var shortershortPW: String = ""
    var restOfThePW: String = ""
    var normalPWToBeCopiedToClipboard = ""
    
    func pwTextFormatting () {
        
        normalPWToBeCopiedToClipboard = pwNew
        
        shortershortPW = String(pwNew.prefix(15))
        restOfThePW = String(pwNew.suffix(25))
        if sitesThatPraticeBadSecruity.contains(serviceInput.text!.lowercased()) {
            pwOutput.text = "\(shortershortPW)" + "  " + "\(restOfThePW)"
        } else if sitesThatPraticeBetterSecruity.contains(serviceInput.text!.lowercased()) {
            pwOutput.text = "\(pwNew)" + " (*)"
        } else {
            pwOutput.text = pwNew
        }
    }
    
    func pwRefresh() {
        pwNew = ""
    }
    
    // buttons
    // this needs fixing!!!!!
    @IBAction func copyNormal(_ sender: Any) {
        UIPasteboard.general.string = normalPWToBeCopiedToClipboard
    }
    
    @IBAction func copy15CharYes(_ sender: Any) {
        shorterPW = pwOutput.text!
        shorterPWCopy = String(shorterPW.prefix(15))
        UIPasteboard.general.string = shorterPWCopy
    }
    
    @IBAction func copySpecialChar(_ sender: Any) {
        specialCharPW = pwOutput.text!
        specialCharPWCopy = "\(specialCharPW)" + "*"
    }
    
    @IBAction func websiteLink(_ sender: Any) {
        if let url = URL(string: "http://pwapp.io/?utm_source=iOS&utm_medium=link&utm_content=footer&utm_campaign=iOS") {
            UIApplication.shared.openURL(url)
        }
    }
    
    // Show / hide different UI elements
    func showHide () {
        if serviceInput.text! == "" && passwordInput.text! == "" {
            // When the text field is blank
            pwOutput.isHidden = true
            buttonCopyNormal.isHidden = true
            buttonCopy15CharYes.isHidden = true
            buttonCopySpecialChar.isHidden = true
        } else if sitesThatPraticeBadSecruity.contains(serviceInput.text!.lowercased()) {
            // when it should show the 15 character option
            buttonCopyNormal.isHidden = false
            buttonCopy15CharYes.isHidden = false
        } else if sitesThatPraticeBetterSecruity.contains(serviceInput.text!.lowercased()) {
            // when it should be a special characater
            buttonCopyNormal.isHidden = false
            buttonCopySpecialChar.isHidden = false
        } else {
            // when it is every other password and should just be normal
            pwOutput.isHidden = false
            buttonCopyNormal.isHidden = false
            buttonCopy15CharYes.isHidden = false
            buttonCopySpecialChar.isHidden = true
        }
    }
    
    // todo hide buttonWebsiteLink on iPhone 5 SE
    func showHideLink () {
        if UIDevice.current.orientation.isLandscape {
            print("Landscape")
            buttonWebsiteLink.isHidden = true
        } else {
            buttonWebsiteLink.isHidden = false
        }
    }
    
// end
}
