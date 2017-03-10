//
//  随机数生成.swift
//  SwiftTips
//
//  Created by KON on 2017/3/10.
//  Copyright © 2017年 KON. All rights reserved.
//

import UIKit

/*
  由 CPU 时钟，进程和线程所构建出的世界中，是没有真正的随机的。
 
  在给定一个随机种子后，使用某些神奇的算法我们可以得到一组伪随机的序列。
 
  Swift 的 Int 是和 CPU 架构 有关的: 在 32 位的 CPU 上
  
  (也就是 iPhone5 和 前任们) 实际上是 Int32, 
 
  而在 64 位 CPU ( iPhone5s 以及 以后的机型) 上是 Int64
 
  arc4random 所返回的值不论在什么平台上都是一个 UInt32,
 
  于是在 32 位 的平台上就有一半几率在进行 Int 转换时越界, 进而崩溃
 
  所以需要限制传入的参数
 
 */

func random(in range: Range<Int>) -> Int {
  
  let count = UInt32(range.upperBound - range.lowerBound)
  
  return Int(arc4random_uniform(count)) + range.lowerBound
  
}

func test() {
  for _ in 0...100 {
    let range = Range<Int>(1...6)
    
    print(random(in: range))
  }
}
