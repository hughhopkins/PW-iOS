//
//  ViewController.swift
//  pw26
//
//  Created by Hugh Hopkins on 31/03/2015.
//  Copyright (c) 2015 io.pwapp. All rights reserved.
//

import UIKit
import CryptoSwift
import GoSquared

class ViewController: UIViewController, UITextFieldDelegate {
    
    // GoSquared Chat
    @IBAction func presentGoSquaredChat(sender: AnyObject) {
        self.gs_presentChatViewController();
    }
    
    // copy element
    @IBOutlet var copyToStyle: UIButton!
    @IBOutlet weak var chatButton: UIButton!
    @IBOutlet weak var pwappLinkButton: UIButton!
    @IBOutlet weak var copy15CharYes: UIButton!
    @IBOutlet weak var copy15CharNo: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // hide the other buttons
        copyToStyle.hidden = true
        copy15CharYes.hidden = true
        copy15CharNo.hidden = true
        
        serviceInput.autocorrectionType = UITextAutocorrectionType.No
        serviceInput.autocapitalizationType = UITextAutocapitalizationType.None
        
        serviceInput.delegate = self
        passwordInput.delegate = self
        
        // round those corners!
        copyToStyle.layer.cornerRadius = 5
        chatButton.layer.cornerRadius = 5
        pwappLinkButton.layer.cornerRadius = 5
        copy15CharYes.layer.cornerRadius = 5
        copy15CharNo.layer.cornerRadius = 5
        
        let notifCenter = NSNotificationCenter.defaultCenter()
        let notifHandler = #selector(ViewController.unreadNotificationHandler(_:))
        
        notifCenter.addObserver(self, selector: notifHandler, name: GSUnreadMessageNotification, object:nil)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true;
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet var pwOutput: UILabel!
    
    @IBOutlet var serviceInput: UITextField!
    @IBAction func serviceInputEdit(sender: UITextField) {
        update()
    }

    @IBOutlet var passwordInput: UITextField!
    @IBAction func passwordInputEdit(sender: UITextField) {
        update()
    }
    
    //
    var pwNew: String = ""
    var shorterPW: String = ""
    var shorterPWcopy: String = ""
    
    // Show hide differnt copy buttons
    func showHidePWOutput() {
        let sites = ["apple", "lloyds", "bank", "nike", "tesco", "easyjet", "glassdoor", "spearfishingstore", "europcar", "tsb", "hsbc", "rbs", "barclays" ]
        if serviceInput.text! == "" && passwordInput.text! == "" {
            pwOutput.hidden = true
            copyToStyle.hidden = true
            copy15CharYes.hidden = true
            copy15CharNo.hidden = true
        } else if sites.contains(serviceInput.text!.lowercaseString) {
            copyToStyle.hidden = true
            copy15CharYes.hidden = false
            copy15CharNo.hidden = false
        } else {
            pwOutput.hidden = false
            copyToStyle.hidden = false
            copy15CharYes.hidden = true
            copy15CharNo.hidden = true
        }
    }
    
    // pw code
    func update() {
        showHidePWOutput()
        
        var srv: String = serviceInput.text!
        var pass: String = passwordInput.text!
        var srvLower = srv.lowercaseString
        var pwHash = "\(srvLower)||\(pass)||".sha1()
        var pwString = String(pwHash)
        var pwLowered = pwString.lowercaseString
        var index = 0
        
        func updateTwo() {
            for string in pwLowered.characters {
                let s = "\(string)"
                if index % 2 == 0 {
                    pwNew += s.uppercaseString
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
    
    // copy buttons 
    // Original
    @IBAction func copyOriginal(sender: AnyObject) {
        UIPasteboard.generalPasteboard().string = pwOutput.text
        print(pwOutput.text, terminator: "")

    }
    
    @IBAction func normalCopyDuringSpecialCase(sender: AnyObject) {
        UIPasteboard.generalPasteboard().string = pwOutput.text
        print(pwOutput.text, terminator: "")
    }
    
    @IBAction func CharCopyDuringSpecialCase(sender: AnyObject) {
        shorterPW = pwOutput.text!
        shorterPWcopy = String(shorterPW.characters.prefix(15))
        UIPasteboard.generalPasteboard().string = shorterPWcopy
        print(shorterPWcopy)
    }
    
    @IBAction func pwappLink(sender: AnyObject) {
        if let url = NSURL(string: "http://pwapp.io/?utm_source=iOS&utm_medium=link&utm_content=footer&utm_campaign=iOS") {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    // GoSquared - function for handling notification
    func unreadNotificationHandler(notification: NSNotification) {
        let count = notification.userInfo![GSUnreadMessageNotificationCount]
        // update ui with count
        
        if let unreadCount = count as? Int {
            if unreadCount == 0 {
                chatButton.setTitle("      Chat      ", forState: .Normal)
            } else {
                chatButton.setTitle("      Chat (\(unreadCount))      ", forState: .Normal)
            }
        }
    }
// end
}

