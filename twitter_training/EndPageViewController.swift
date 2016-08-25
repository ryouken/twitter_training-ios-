import UIKit
import Alamofire
import SwiftyJSON

class EndPageViewController: UIViewController {
    
    var delegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let scene = Scene()
    let http = HTTPRequest()
    var pageMenuVC: PageMenuViewController!

    // 会員情報編集ページへの画面遷移
    @IBAction func editButton(sender: AnyObject) {
        scene.preTransition(self, storyboardId: "EditFirst")
    }
    
    @IBAction func logoutButton(sender: AnyObject) {
        http.logout(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
