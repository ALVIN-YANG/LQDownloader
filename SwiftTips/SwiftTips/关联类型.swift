//
//  关联类型.swift
//  SwiftTips
//
//  Created by KON on 2017/3/10.
//  Copyright © 2017年 KON. All rights reserved.
//

import UIKit

class MyClass {

}

private var key: Void?

extension MyClass {
  
  var title: String? {
    
    get {
      
      return objc_getAssociatedObject(self, &key) as? String

    }
    
    set {
      
      objc_setAssociatedObject(self, &key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
      
    }
    
  }
		
}

//测试

func printTitle(_ input: MyClass) {
  
  if let title = input.title {
    
    print("Title: \(title)")
    
  } else {
    
    print("没有设置")
    
  }
  
}
