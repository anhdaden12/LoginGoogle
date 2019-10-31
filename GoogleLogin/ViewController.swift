//
//  ViewController.swift
//  GoogleLogin
//
//  Created by Apple on 10/31/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import GoogleSignIn

class ViewController: UIViewController {

    @IBOutlet weak var imageGoogleAcc: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.delegate = self
        
        // Do any additional setup after loading the view.
        GIDSignIn.sharedInstance()?.presentingViewController = self
        // Automatically sign in the user. dang nhap vao account da dang nhap truoc do
        //GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        
//        let loginButton = GIDSignInButton.init()
//        loginButton.center = self.view.center
//        self.view.addSubview(loginButton)
    }

    @IBAction func onClickLogin(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    @IBAction func onClickLogout(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signOut()
        title = "Google Login 🤯"
        imageGoogleAcc.image = UIImage(named: "imagei")
    }
    
}

extension ViewController: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let err = error {
            if (err as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                print("The user has not signed in before or they have since signed out.")
            } else {
                print("\(err.localizedDescription)")
            }
            return
        }
        
         // Perform any operations on signed in user here.
        let userID = user.userID // For client-side use only!
        let idToken = user.authentication.idToken  // Safe to send to the server
        let fullName = user.profile.name
        let givenName = user.profile.givenName
        let familyName = user.profile.familyName
        let email = user.profile.email
        
        if user.profile.hasImage {
            guard let pic = user.profile.imageURL(withDimension: 240) else { return }
            let data = try! Data(contentsOf: pic)
            imageGoogleAcc.image = UIImage(data: data)
            title = email
        }
        
//        if (GIDSignIn.sharedInstance()?.currentUser != nil) {
//            let dashboardVC: UIViewController = ViewController2()
//            present(dashboardVC, animated: true, completion: nil)
//        }
        
      }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        print("adu mat mang")
        // ...
    }
}

