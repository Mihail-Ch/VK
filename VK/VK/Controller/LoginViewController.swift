//
//  LoginViewController.swift
//  VK
//
//  Created by Михаил Чертов on 20.12.2020.
//

import UIKit

class LoginViewController: UIViewController {
    
    //MARK: - @IBOutlet
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var loginInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    


    
     
     //MARK: - @IBAction
    
     @IBAction func pressButtonInput(_ sender: UIButton) {
        
     }
    
    
    // MARK: - Navigation

    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//MARK: - Keyboard

extension LoginViewController {
    
}
