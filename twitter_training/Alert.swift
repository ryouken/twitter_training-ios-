import Foundation
import UIKit

class Alert {
    
    func validationError(vc: UIViewController, message: String) {
        let alert = UIAlertController(title: "エラー", message: message, preferredStyle:  UIAlertControllerStyle.Alert)
        let defaultAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler:{ action in
        })
        alert.addAction(defaultAction)
        vc.presentViewController(alert, animated: true, completion: nil)
    }
    
    func responseError(vc: UIViewController) {
        validationError(vc, message: "入力に誤りがあります。")
    }
    
    func loginError(vc: UIViewController) {
        validationError(vc, message: "入力情報が間違っています。")
    }
    
    func textCountError(vc: UIViewController) {
        validationError(vc, message: "適切な文字数で入力して下さい。")
    }
    
    func replyError(vc: UIViewController){
        validationError(vc, message: "既にツッコんだボケです。ボケてるんですか？")
    }
    
    func replyAction(vc: TimelineViewController, tweet: Timeline) {
        let alert = UIAlertController(title: "このボケに対して", message: nil, preferredStyle:  UIAlertControllerStyle.Alert)
        let defaultActionReply = UIAlertAction(title: "ツッコむ", style: UIAlertActionStyle.Default, handler: { action in
            // リプライページへの画面遷移
            vc.scene.replyTransition(vc, tweet: tweet)
        })
        let defaultActionShow = UIAlertAction(title: "ツッコミを見る", style: UIAlertActionStyle.Default, handler: { action in
            // リプライリストへの画面遷移
            vc.scene.replyListTransition(vc, tweet: tweet)
        })
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertActionStyle.Cancel, handler:{ action in
        })
        alert.addAction(cancelAction)
        alert.addAction(defaultActionReply)
        alert.addAction(defaultActionShow)
        vc.presentViewController(alert, animated: true, completion: nil)
    }
    
    func replyAction(vc: MyTweetViewController, tweet: Tweet) {
        let alert = UIAlertController(title: "このボケに対して", message: nil, preferredStyle:  UIAlertControllerStyle.Alert)
        let defaultActionShow = UIAlertAction(title: "ツッコミを見る", style: UIAlertActionStyle.Default, handler: { action in
            // リプライリストへの画面遷移
            vc.scene.replyListTransition(vc, tweet: tweet)
        })
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertActionStyle.Cancel, handler:{ action in
        })
        alert.addAction(cancelAction)
        alert.addAction(defaultActionShow)
        vc.presentViewController(alert, animated: true, completion: nil)
    }
    
    // TODO: 型の違いどうするの？
    func followAction(vc: UserListViewController, user: User) {
        let alert = UIAlertController(title: user.user_name, message: "フォローしますか？", preferredStyle:  UIAlertControllerStyle.Alert)
        let defaultAction = UIAlertAction(title: "フォロー", style: UIAlertActionStyle.Default, handler: { action in
            vc.http.createFollow(vc, user: user)
        })
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertActionStyle.Cancel, handler:{ action in
        })
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)
        vc.presentViewController(alert, animated: true, completion: nil)
    }
    
    func followAction(vc: FollowedListViewController, user: Followed) {
        let alert = UIAlertController(title: user.user_name, message: "フォローしますか？", preferredStyle:  UIAlertControllerStyle.Alert)
        let defaultAction = UIAlertAction(title: "フォロー", style: UIAlertActionStyle.Default, handler: { action in
            vc.http.createFollow(vc, user: user)
        })
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertActionStyle.Cancel, handler:{ action in
        })
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)
        vc.presentViewController(alert, animated: true, completion: nil)
    }
    
}