//
//  LoginViewController.swift
//  Do:Dat
//
//  Created by AnGie on 8/4/15.
//  Copyright (c) 2015 AnGie. All rights reserved.
//
/* View Controller for user-login/authentication */

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var userEmailTextField: UITextField!
    
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    let border_e = CALayer()
    let width_e = CGFloat(2.0)
    let border_p = CALayer()
    let width_p = CGFloat(2.0)
    
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
    
    @IBAction func loginButtonTapped(sender: UIButton) {
        
        //Authentication code
        performLoginAuthentication()
        userPasswordTextField.resignFirstResponder()

    }
    
    func displayMyAlertMessage(userMessage: String) {
        let myAlert = UIAlertController(title: nil, message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        
        myAlert.addAction(okAction)
        
        self.presentViewController(myAlert, animated: true, completion: nil)
        
    }

    func displayMyAlertMessage(userTitle: String, userMessage: String) {
        let myAlert = UIAlertController(title: userTitle, message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        
        myAlert.addAction(okAction)
        
        self.presentViewController(myAlert, animated: true, completion: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        //userEmailTextField.becomeFirstResponder()
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        userEmailTextField.delegate = self
        userPasswordTextField.delegate = self
        
        // Set up borders for email & password text fields
        initializeTextFieldBorder(border_e, width: width_e, field: userEmailTextField)
        initializeTextFieldBorder(border_p, width: width_p, field: userPasswordTextField)
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
    
    func dismissKeyboard(){
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == self.userEmailTextField {
            self.userPasswordTextField.becomeFirstResponder()
        }
        else{
            performLoginAuthentication()
            userPasswordTextField.resignFirstResponder()
        }
        return true
    }
    
    private func performLoginAuthentication(){
        let email = userEmailTextField.text!
        let password = userPasswordTextField.text!
        
        if(email == "" || password  == "") {
            displayMyAlertMessage("All fields are required!")
            return
        }
        else {
            let request:NSMutableURLRequest = NSMutableURLRequest(URL: NSURL(string: "https://web.njit.edu/~anp55/userLogin.php")!)
            request.HTTPMethod = "POST"
            let postString:NSString = "email=\(email)&password=\(password)"
            request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request){
                data, response, error in
                if error != nil{
                    print("error=\(error)")
                    return
                }
                let myDictionary: NSDictionary = (try! NSJSONSerialization.JSONObjectWithData(data!, options: [])) as! NSDictionary
                if let status:String = myDictionary["status"] as? String{
                    if status == "Success" {
                        let username:String = myDictionary["user_username"] as! String
                        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isUserLoggedIn")
                        NSUserDefaults.standardUserDefaults().setObject(username, forKey: "username")
                        NSUserDefaults.standardUserDefaults().synchronize()
                        self.dismissViewControllerAnimated(true, completion: nil)
                    }
                    else if status == "error" {
                        NSOperationQueue.mainQueue().addOperationWithBlock{
                            self.displayMyAlertMessage("Login Failed", userMessage: "Incorrect email and/or password")
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
