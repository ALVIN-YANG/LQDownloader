//
//  Drinking.swift
//  SwiftTips
//
//  Created by KON on 2017/3/9.
//  Copyright © 2017年 KON. All rights reserved.
//

import UIKit

class Drinking {
	typealias LiquidColor = UIColor
	
	var color: LiquidColor {
		return .clear
	}
	
	class func drinking(name: String) -> Drinking {
		
		var drinking: Drinking
		
		switch name {
			
			case "Coke":
			
				drinking = Coke()
			
			case "Beer":
			
				drinking = Beer()
			
		default:
			
			drinking = Drinking()
			
		}
		
		return drinking
		
	}
}

class Coke: Drinking {
	
	override var color: Drinking.LiquidColor {
		return .black
	}
}

class Beer: Drinking {
	override var color: LiquidColor {
		return .yellow
	}
}




