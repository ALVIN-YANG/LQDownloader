//
//  ViewController.swift
//  SwiftTips
//
//  Created by KON on 2017/3/6.
//  Copyright © 2017年 KON. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
	
		printLog(message: self.view)
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		let task = delay(5) {
			print("拨打110")
		}
		
		let _ = delay(3) {
			print("还是不打了")
			cancel(task)
		}
		
		let coke = Drinking.drinking(name: "Coke")
		
		
		
		let cokeClass = NSStringFromClass(type(of: coke))
		
		let beer = Drinking.drinking(name: "Beer")
		
		let beerClass = NSStringFromClass(type(of: beer))
		
		print("\(cokeClass)/\(beerClass)")
		debugPrint(String(describing: Drinking.self).MD5)
		
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

