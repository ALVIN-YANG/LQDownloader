//
//  尾递归.swift
//  SwiftTips
//
//  Created by 杨卢青 on 2017/3/12.
//  Copyright © 2017年 KON. All rights reserved.
//

import UIKit

/**
	每次递归调用都需要在调用栈上保存当前的状态, 

	如果调用栈足够深的时候栈空间被消耗尽而导致错误, 也就是栈溢出

	尾递归是解决栈溢出的好方法

	尾递归就是让函数里的最后一个动作是函数调用的形式, 

	这个调用的返回值将直接被当前函数返回, 从而避免在栈上保存状态.

*/

func tailSum(_ n: UInt) -> UInt {

	func sumInternal(_ n: UInt, current: UInt) -> UInt {
	
		if n == 0 {
			
			return current
			
		} else {
			
			return sumInternal(n - 1, current: current + n)
			
		}
		
	}
	
	return sumInternal(n, current: 0)
}

/**

	但是在项目中直接运行这段代码还是会报错, 因为在 Debug 模式下 Swift 编译器

	并不会对尾递归进行优化. 我们可以再 scheme 设置中将 Run 的配置从 Debug 

	改为 Release, 这段代码就能正常运行了.
*/
