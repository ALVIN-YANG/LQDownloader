//
//  转移内存管理权.swift
//  SwiftTips
//
//  Created by KON on 2017/3/10.
//  Copyright © 2017年 KON. All rights reserved.
//

import UIKit

/*
  __bridge 
 
  在 Objective-C 中 NS 对象 和 CF 对象之间进行转换时, 需要向编译器说明是否需要
  
  转移内存的管理权. 类型前面加上 __bridge 表示内存管理权不变

  Swift 中这样的转换可以省掉
 */

import AudioToolbox

class AudioTest {
  
  let fileURL = NSURL(string: "SomeURL")
  
  var theSoundID: SystemSoundID = 0
  
//  AudioServicesCreateSystemSoundID(fileURL!, &theSoundID)
  
}















