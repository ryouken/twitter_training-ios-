import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    var initialPageNC: UINavigationController?
    var window: UIWindow?
    var emailText: UITextField!
    var passwordText: UITextField!

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        //ナビゲーションコントローラ
        initialPageNC = UINavigationController(rootViewController: storyboard.instantiateViewControllerWithIdentifier("InitialPage"))
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window?.rootViewController = initialPageNC
        self.window?.makeKeyAndVisible()
        
        // ナビゲーションのバーの色を変更したり下線を削除したり
        UINavigationBar.appearance().barTintColor = UIColor.hexStr("66CCFF", alpha: 1)
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        UINavigationBar.appearance().shadowImage = UIImage()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {}
    func applicationDidEnterBackground(application: UIApplication) {}
    func applicationWillEnterForeground(application: UIApplication) {}
    func applicationDidBecomeActive(application: UIApplication) {}
    func applicationWillTerminate(application: UIApplication) {}

}

extension UIColor {
    class func hexStr (hexStr: NSString, alpha: CGFloat) -> UIColor {
        let hexStr = hexStr.stringByReplacingOccurrencesOfString("#", withString: "")
        let scanner = NSScanner(string: hexStr as String)
        var color: UInt32 = 0
        if scanner.scanHexInt(&color) {
            let r = CGFloat((color & 0xFF0000) >> 16) / 255.0
            let g = CGFloat((color & 0x00FF00) >> 8) / 255.0
            let b = CGFloat(color & 0x0000FF) / 255.0
            return UIColor(red:r,green:g,blue:b,alpha:alpha)
        } else {
            print("invalid hex string")
            return UIColor.whiteColor();
        }
    }
}

