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
    debugPrint("md5: \(String(describing: Drinking.self).MD5)")
    
    //关联类型
    let a = MyClass()
    
    printTitle(a)
    
    a.title = "Swifter.tips"
    
    printTitle(a)
    
    
    //封装同步锁
    
    synchronized(a) {
      //a 不会被其他线程改变
    }
    
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  
}

