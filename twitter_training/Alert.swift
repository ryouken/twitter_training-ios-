import Foundation
import UIKit

class Alert {
    
    func validationError(vc: UIViewController) {
        let alert = UIAlertController(title: "エラー", message: "指定の方式で入力して下さい。", preferredStyle:  UIAlertControllerStyle.Alert)
        let defaultAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler:{ action in
        })
        alert.addAction(defaultAction)
        vc.presentViewController(alert, animated: true, completion: nil)
    }
    
    func responseError(vc: UIViewController) {
        let alert = UIAlertController(title: "エラー", message: "入力に問題があります。", preferredStyle: UIAlertControllerStyle.Alert)
        let defaultAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler:{ action in
        })
        alert.addAction(defaultAction)
        vc.presentViewController(alert, animated: true, completion: nil)
    }
    
    func loginError(vc: UIViewController) {
        let alert = UIAlertController(title: "エラー", message: "入力情報が間違っています。", preferredStyle: UIAlertControllerStyle.Alert)
        let defaultAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler:{ action in
        })
        alert.addAction(defaultAction)
        vc.presentViewController(alert, animated: true, completion: nil)
    }
    
    func textCountError(vc: UIViewController) {
        let alert = UIAlertController(title: "エラー", message: "適切な文字数で入力して下さい。", preferredStyle: UIAlertControllerStyle.Alert)
        let defaultAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler:{ action in
        })
        alert.addAction(defaultAction)
        vc.presentViewController(alert, animated: true, completion: nil)
    }
    
    func replyError(vc: UIViewController){
        let alert = UIAlertController(title: "エラー", message: "既にツッコんだボケです。ボケてるんですか？", preferredStyle: UIAlertControllerStyle.Alert)
        let defaultAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler:{ action in
        })
        alert.addAction(defaultAction)
        vc.presentViewController(alert, animated: true, completion: nil)
    }
    
    func replyAction(vc: TimelineViewController, num: Int?, text: String?) {
        let alert = UIAlertController(title: "このボケに対して", message: nil, preferredStyle:  UIAlertControllerStyle.Alert)
        let defaultActionReply = UIAlertAction(title: "ツッコむ", style: UIAlertActionStyle.Default, handler: { action in
            // リプライページへの画面遷移
            vc.scene.replyTransition(vc, num: num)
        })
        let defaultActionShow = UIAlertAction(title: "ツッコミを見る", style: UIAlertActionStyle.Default, handler: { action in
            // リプライリストへの画面遷移
            vc.scene.replyListTransition(vc, num: num, text: text)
        })
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertActionStyle.Cancel, handler:{ action in
        })
        alert.addAction(cancelAction)
        alert.addAction(defaultActionReply)
        alert.addAction(defaultActionShow)
        vc.presentViewController(alert, animated: true, completion: nil)
    }
    
    func replyAction(vc: MyTweetViewController, num: Int?, text: String?) {
        let alert = UIAlertController(title: "このボケに対して", message: nil, preferredStyle:  UIAlertControllerStyle.Alert)
        let defaultActionShow = UIAlertAction(title: "ツッコミを見る", style: UIAlertActionStyle.Default, handler: { action in
            // リプライリストへの画面遷移
            vc.scene.replyListTransition(vc, num: num, text: text)
        })
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertActionStyle.Cancel, handler:{ action in
        })
        alert.addAction(cancelAction)
        alert.addAction(defaultActionShow)
        vc.presentViewController(alert, animated: true, completion: nil)
    }
    
    func followAction(vc: UserListViewController, user: [String: String?], json: [String: Int]) {
        let alert = UIAlertController(title: user["user_name"]!, message: "フォローしますか？", preferredStyle:  UIAlertControllerStyle.Alert)
        let defaultAction = UIAlertAction(title: "フォロー", style: UIAlertActionStyle.Default, handler: { action in
            vc.http.createFollow(vc, json: json)
        })
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertActionStyle.Cancel, handler:{ action in
        })
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)
        vc.presentViewController(alert, animated: true, completion: nil)
    }
    
    func followAction(vc: FollowedListViewController, follow: [String: String?], json: [String: Int]) {
        let alert = UIAlertController(title: follow["user_name"]!, message: "フォローしますか？", preferredStyle:  UIAlertControllerStyle.Alert)
        let defaultAction = UIAlertAction(title: "フォロー", style: UIAlertActionStyle.Default, handler: { action in
            vc.http.createFollow(vc, json: json)
        })
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertActionStyle.Cancel, handler:{ action in
        })
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)
        vc.presentViewController(alert, animated: true, completion: nil)
    }
    
}