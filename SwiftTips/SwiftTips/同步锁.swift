//
//  同步锁.swift
//  SwiftTips
//
//  Created by KON on 2017/3/10.
//  Copyright © 2017年 KON. All rights reserved.
//

import UIKit

/*
 “@synchronized 在幕后做的事情是调用了 objc_sync 中的 

	objc_sync_enter 和 objc_sync_exit 方法，并且加入了一些异常判断。”
 
 */

func myLock(anObj: AnyObject) {
  objc_sync_enter(anObj)
  
  //在 enter 和 exit 之间 anObj 不会被其他线程改变
  
  objc_sync_exit(anObj)
}

//更进一步 写一个全局的方法, 并接受一个闭包 封装

func synchronized(_ lock: AnyObject, closure: () -> ()) {
  
  objc_sync_enter(lock)
  
  closure()
  
  objc_sync_exit(lock)
  
}

