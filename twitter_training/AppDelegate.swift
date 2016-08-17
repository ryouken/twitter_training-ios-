//
//  AppDelegate.swift
//  twitter_training
//
//  Created by 小島領剣 on 2016/08/11.
//  Copyright © 2016年 Ryouken Kojima. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var emailText: UITextField!
    var passwordText: UITextField!

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        //ページコントロールのカラーを変更する。
        let pageControl = UIPageControl.appearance()
        pageControl.backgroundColor = UIColor.whiteColor()
        pageControl.pageIndicatorTintColor = UIColor.blueColor()
        pageControl.currentPageIndicatorTintColor = UIColor.greenColor()
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
    }

    func applicationDidEnterBackground(application: UIApplication) {
    }

    func applicationWillEnterForeground(application: UIApplication) {
    }

    func applicationDidBecomeActive(application: UIApplication) {
    }

    func applicationWillTerminate(application: UIApplication) {
    }


}

