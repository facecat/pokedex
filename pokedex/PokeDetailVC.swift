//
//  PokeDetailVC.swift
//  pokedex
//
//  Created by 邱国邦 on 16/1/3.
//  Copyright © 2016年 FaceCat. All rights reserved.
//

import UIKit

class PokeDetailVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    
    @IBAction func backBtnPressed() {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
