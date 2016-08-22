import UIKit
import Alamofire
import SwiftyJSON

class EndPageViewController: UIViewController {
    var delegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var pageMenuVC: PageMenuViewController!

    @IBAction func editButton(sender: AnyObject) {
        // 会員情報編集ページの画面遷移
        let storyboard = self.storyboard!
        let nextVC = storyboard.instantiateViewControllerWithIdentifier("EditFirst") as! EditFirstViewController
        self.presentViewController(nextVC, animated: true, completion: nil)
    }
    
    @IBAction func logoutButton(sender: AnyObject) {
        Alamofire.request(.GET, "\(Constant.url)/json/user/logout")
            .responseJSON { response in
                print(response.response) // URL response
                
                guard let object = response.result.value else {
                    return
                }
                
                let json = JSON(object)
                json.forEach {(_, json) in
                    if (json == "logout_success") {
                        print(json)
                        let parentVC = self.pageMenuVC.presentingViewController
                        parentVC!.dismissViewControllerAnimated(false, completion: {
                            (parentVC as? UINavigationController)?.popToRootViewControllerAnimated(false)
                        })
                    } else {
                        let alertLabel: UILabel = UILabel(frame: CGRectMake(0,0,200,50))
                        alertLabel.text = "ログアウトに失敗しました。"
                        self.view.addSubview(alertLabel)
                    }
                }
            }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
