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
		
		testHelloSelf()
		
		var mutableArray = [1,2,3]
		for _ in mutableArray {
			mutableArray.removeLast()
			printLog(mutableArray)
		}
		printLog(mutableArray)
		
		let array = [1, 2, 3, 4, 5, 6]
		let arrays = array[1...5]
		
		print(arrays[1])
		
		
		
		
		struct Person {
			
			var store = "dasd"
			
			var name: String {
				 get {
					return store
				}
			}
		}
		
		var p = Person()
		p.store = "ooooooo"
		
		print(p.name)
		p.store = "KKKK"
		
		print(p.name)
		
		
		let length1 = "string".characters.count
		let length2 = "string".data(using: .utf8)
		let length3 = ("string" as NSString).length
  }
	
	
	
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
	
	
  
}

class Book {
	var array = [Book]()
	
	typealias Element = Book
	
	init(arrayLiteral elements: [Element]) {
		array = elements
	}
}

class BookListGenerator : IteratorProtocol {
	typealias Element = Book
	var currentIndex:Int = 3
	var bookList:[Book]?
	init(bookList: [Book]) {
		self.bookList = bookList
	}
	func next() -> Element? {
		guard let list = bookList else { return  nil }
		if currentIndex < list.count {
			let element = list[currentIndex]
			currentIndex += 1
			return element
		}else {
			return nil
		}
	}
}



struct Affine {
	var a: Int
	var b: Int
}

func ~=(lhs: Affine, rhs: Int) -> Bool {
	
	return lhs.a > rhs
}
