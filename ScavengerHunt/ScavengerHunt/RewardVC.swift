//
//  RewardVC.swift
//  ScavengerHunt
//
//  Created by Salman on 02/06/2017.
//  Copyright © 2017 Salman. All rights reserved.
//

import UIKit

class RewardVC: UIViewController {

    public static var reward: String?
    @IBOutlet weak var tv: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(RewardVC.reward)
        if RewardVC.reward != nil{
            tv.text = tv.text + " " + RewardVC.reward!
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        let next = storyboard?.instantiateViewController(withIdentifier: "fav_controller")
        show(UINavigationController(rootViewController: next!), sender: nil)
    }

}
