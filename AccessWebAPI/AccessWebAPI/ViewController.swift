//
//  ViewController.swift
//  AccessWebAPI
//
//  Created by 阿部 潤平 on 2014/06/30.
//  Copyright (c) 2014年 Self. All rights reserved.
//

import Foundation
import UIKit

class ViewController:UIViewController {
    
    var vi: View?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vi = View(frame: self.view.bounds)
        
        self.view.addSubview(vi)
        NSLog("viewDidLoad")

    }
}