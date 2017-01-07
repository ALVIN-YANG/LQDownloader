//
//  ViewController.swift
//  LQDownload
//
//  Created by 杨卢青 on 2017/1/6.
//  Copyright © 2017年 杨卢青. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		debugPrint("\(LQDownload().downloadDirectory())")
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

