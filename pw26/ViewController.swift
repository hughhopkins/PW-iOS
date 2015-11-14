//
//  ViewController.swift
//  pw26
//
//  Created by Hugh Hopkins on 31/03/2015.
//  Copyright (c) 2015 io.pwapp. All rights reserved.
//

import UIKit
import CryptoSwift

class ViewController: UIViewController, UITextFieldDelegate {
    
    // animation elements
    @IBOutlet var container: UIView!
    @IBOutlet var containerSub: UIView!
    @IBOutlet var containerSubSub: UIView!
    
    // copy element
    @IBOutlet var copyToStyle: UIButton!
    
    override func viewDidLoad() {
        serviceInput.autocorrectionType = UITextAutocorrectionType.No
        serviceInput.autocapitalizationType = UITextAutocapitalizationType.None
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        serviceInput.delegate = self
        passwordInput.delegate = self
        copyToStyle.layer.cornerRadius = 5
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
    
    // pw code
    func update() {
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
                index++;
            }
            pwOutput.text = pwNew
        }
        updateTwo()
        
        func updateThree() {
            pwNew = ""
        }
        updateThree()
    }
    
    @IBAction func pwappLink(sender: AnyObject) {
        if let url = NSURL(string: "http://pwapp.io/?utm_source=iOS&utm_medium=link&utm_content=footer&utm_campaign=iOS") {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    @IBAction func animateButton(sender: AnyObject) {
        // copy to clipboard
        UIPasteboard.generalPasteboard().string = pwOutput.text
        print(pwOutput.text, terminator: "")
        
        // create a 'tuple' (a pair or more of objects assigned to a single variable)
        let views = (frontView: self.containerSub, backView: self.containerSubSub)
        
        // set a transition style
        let transitionOptions = UIViewAnimationOptions.TransitionCurlUp
        
        UIView.transitionWithView(self.container, duration: 1.0, options: transitionOptions, animations: {
            // remove the front object...
            views.frontView.removeFromSuperview()
            
            // ... and add the other object
            self.container.addSubview(views.backView)
            
            }, completion: { finished in
                // any code entered here will be applied
                // .once the animation has completed
        })
    }
    
// end
}

