//
//  CoreData.swift
//  SwiftTips
//
//  Created by 杨卢青 on 2017/3/12.
//  Copyright © 2017年 KON. All rights reserved.
//

import UIKit


/**

	设想我们有这样一个需求，通过对于一副扑克牌的花色和牌面大小的 enum 类型，

	凑出一套不含大小王的扑克牌的数组。
*/

enum Suit: String {
	
	case spades = "黑桃"
	
	case heart = "红桃"
	
	case clubs = "草花"
	
	case diamonds = "方片"
	
}

enum Rank: Int, CustomStringConvertible {
	
	case ace = 1
	
	case two, three, four, five, six, seven, eight, nine, ten
	
	case jack, queen, king
	
	var description: String {
		
		switch self {
			
		case .ace:
			
			return "A"
		
		case .jack:
			
			return "J"
		
		case .queen:
			
			return "Q"
			
		case .king:
			
			return "K"
			
		default:
			
			return String(self.rawValue)
			
		}
	}
}


protocol EnumerableEnum {
	static var allValues: [Self] {get}
}

extension Suit: EnumerableEnum {
	
	static var allValues: [Suit] {
		
		return [.spades, .heart, .clubs, .diamonds]
	}
}

extension Rank: EnumerableEnum {

	static var allValues: [Rank] {
		
		return [.ace, .two, .three, .four, .five, .six, .seven,
		        .eight, .nine, .ten, .jack, .queen, .king]
	}
}


func testEnumerableEnum() {
	
	for suit in Suit.allValues {
		for rank in Rank.allValues {
			
			print("\(suit.rawValue)\(rank.rawValue)")
		}
	}
}











