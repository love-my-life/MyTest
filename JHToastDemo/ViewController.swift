//
//  ViewController.swift
//  JHToast
//
//  Created by hanchen on 16/10/9.
//  Copyright © 2016年 LiJianhui. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
    
    }
    @IBAction func btn(_ sender: UIButton) {
        JHToast().showToast(text:"结束，结束，结束，结束，结束，结束，结束",type:.JHToastShowTypeBottom)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

