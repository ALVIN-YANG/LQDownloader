//
//  安全的资源管理.swift
//  SwiftTips
//
//  Created by 杨卢青 on 2017/3/11.
//  Copyright © 2017年 KON. All rights reserved.
//

import UIKit

enum ImageName: String {
	
	case myImage = "my_image"
	
}

enum SegueName: String {
	
	case mySegue = "my_segue"
	
}

extension UIImage {
	
	convenience init!(imageName: ImageName) {
		
		self.init(named: imageName.rawValue)
		
	}
	
}

extension UIViewController {
	
	func performSegue(withName segueName: SegueName, sender: Any?) {
		
		performSegue(withIdentifier: segueName.rawValue, sender: sender)
		
	}
	
}

class testResources: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let _ = UIImage(imageName: .myImage)
		
		performSegue(withName: .mySegue, sender: self)
		
	}
}
