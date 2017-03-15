//
//  ViewController.swift
//  LQDownload
//
//  Created by 杨卢青 on 2017/1/6.
//  Copyright © 2017年 杨卢青. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		debugPrint("\(LQDownload().downloadDirectory())")
	}
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    LQDownload.shared().download("http://music.gowithtommy.com/%E6%AC%A7%E6%B4%B2/%E6%8D%B7%E5%85%8B/%E5%B8%83%E6%8B%89%E6%A0%BC/%E4%BC%8F%E5%B0%94%E5%A1%94%E7%93%A6%E6%B2%B3.mp3", progress: { (cur, end, progress) in
      print("progress: \(progress)")
    }) { (state) in
      
      switch state {
        
      case .begin:  //开始下载
        print("开始下载")
      case .complete:
        print("下载完成")
      case .failed:
        print("下载失败")
      case .pause:
        print("下载暂停")
      }
    }
  }

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

