//
//  RegisterPageViewController.swift
//  Do:Dat
//
//  Created by AnGie on 8/4/15.
//  Copyright (c) 2015 AnGie. All rights reserved.
//
/* View Controller for user registration */

import UIKit

class RegisterPageViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var userEmailTextField: UITextField!
    
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    @IBOutlet weak var userUsernameTextField: UITextField!
    
    let border_e = CALayer()
    let width_e = CGFloat(2.0)
    
    let border_p = CALayer()
    let width_p = CGFloat(2.0)
    
    let border_u = CALayer()
    let width_u = CGFloat(2.0)
    
    @IBAction func emailBeingEntered(sender: AnyObject) {
        border_e.opacity = 1.0
    }
    
    @IBAction func emailDoneEntering(sender: AnyObject) {
        border_e.opacity = 0.5
    }

    @IBAction func passwordBeingEntered(sender: AnyObject) {
        border_p.opacity = 1.0
    }
    
    @IBAction func passwordDoneEntering(sender: AnyObject) {
        border_p.opacity = 0.5
    }
    
    
    @IBAction func usernameBeingEntered(sender: AnyObject) {
        border_u.opacity = 1.0
    }
    
    @IBAction func usernameDoneEntering(sender: AnyObject) {
        border_u.opacity = 0.5
    }
    
    @IBAction func loginButtonTapped(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func signUpButtonTapped(sender: UIButton) {
        performUserRegistration()
        userUsernameTextField.resignFirstResponder()
    }

    func displayMyAlertMessage(userMessage: String) {
        let myAlert = UIAlertController(title: nil, message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
       
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        
        myAlert.addAction(okAction)
        
        self.presentViewController(myAlert, animated: true, completion: nil)
        
    }
    
    func displayMyAlertMessage(goTitle: String, userMessage: String) {
        let myAlert = UIAlertController(title: nil, message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
        
        let loginActionHandler = {(action: UIAlertAction!) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
        let gotologinAction = UIAlertAction(title: goTitle, style: UIAlertActionStyle.Default, handler: loginActionHandler)
        
        let okAction = UIAlertAction(title: "Try Again", style: UIAlertActionStyle.Default, handler: nil)
        
        myAlert.addAction(gotologinAction)
        myAlert.addAction(okAction)
        
        self.presentViewController(myAlert, animated: true, completion: nil)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        userEmailTextField.becomeFirstResponder()
    }
    
     override func viewDidLoad() {
        super.viewDidLoad()
        userEmailTextField.delegate = self
        userPasswordTextField.delegate = self
        userUsernameTextField.delegate = self
        
        // Set up borders for email, password, & username text fields
        initializeTextFieldBorder(border_e, width: width_e, field: userEmailTextField)
        initializeTextFieldBorder(border_p, width: width_p, field: userPasswordTextField)
        initializeTextFieldBorder(border_u, width: width_u, field: userUsernameTextField)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    private func initializeTextFieldBorder(border: CALayer, width: CGFloat, field: UITextField){
        border.borderColor = UIColor.whiteColor().CGColor
        border.opacity = 0.5
        border.frame = CGRect(x:0, y: field.frame.size.height - width, width: field.frame.size.width, height: field.frame.size.height)
        border.borderWidth = width
        field.layer.addSublayer(border)
        field.layer.masksToBounds = true
    }
    
    func dismissKeyboard() {
          view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == self.userEmailTextField {
            self.userPasswordTextField.becomeFirstResponder()
        }
        else if textField == self.userPasswordTextField {
            self.userUsernameTextField.becomeFirstResponder()
        }
        else {
            performUserRegistration()
            userPasswordTextField.resignFirstResponder()
        }
        return true
    }
    
    private func performUserRegistration(){
        let email = userEmailTextField.text!
        let password = userPasswordTextField.text!
        let username = userUsernameTextField.text!
        
        //Check for empty fields
        if (email == "" || password == "" || username == "") {
            
            //Display alert message
            displayMyAlertMessage("All fields are required!")
            return
        }
        else {
            let request:NSMutableURLRequest = NSMutableURLRequest(URL: NSURL(string: "https://web.njit.edu/~anp55/userRegister.php")!)
            request.HTTPMethod = "POST"
            let postString = "email=\(email)&password=\(password)&username=\(username)"
            request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request){
                data, response, error in
                if error != nil{
                    print("error=\(error)")
                    return
                }
                let myDictionary:NSDictionary = (try! NSJSONSerialization.JSONObjectWithData(data!, options: [])) as! NSDictionary
                if let status:String = myDictionary["status"] as? String{
                    if status == "Success"{
                        self.dismissViewControllerAnimated(true, completion: nil)
                    }
                    else if status == "error" {
                        NSOperationQueue.mainQueue().addOperationWithBlock {
                            self.displayMyAlertMessage("Go to Log in", userMessage: "An account with the email, \(email), already exists")
                        }
                    }
                    
                }
                
            }
            task.resume()
        }
    }


     override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
