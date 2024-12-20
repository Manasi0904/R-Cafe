//
//  ViewController.swift
//  R'Cafee
//
//  Created by Kumari Mansi on 21/11/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textButton: UIButton!
    @IBOutlet weak var textButton2: UIButton!
    @IBOutlet weak var textButton3: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        textButton.titleLabel?.font = UIFont(name: "Circe-Regular", size: 15)
        textButton2.titleLabel?.font = UIFont(name: "Circe-Regular", size: 15)
        textButton3.titleLabel?.font = UIFont(name: "Circe-Regular", size: 15)
        textButton.layer.cornerRadius = 10
        textButton2.layer.cornerRadius = 10
        textButton3.layer.cornerRadius = 10
      
    }
    
    
    @IBAction func btnTapped(_ sender: Any) {
        let Storyboard = self.storyboard?.instantiateViewController(identifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(Storyboard, animated: true)
    }
    
    


}

