import Foundation
import UIKit

class Scene {
    
    func navTransition(vc: UIViewController, storyboardId: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = storyboard.instantiateViewControllerWithIdentifier(storyboardId)
        vc.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func preTransition(vc: UIViewController, storyboardId: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = storyboard.instantiateViewControllerWithIdentifier(storyboardId)
        vc.presentViewController(nextVC, animated: true, completion: nil)
    }
    
    func editTransition(vc: EditFirstViewController) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = storyboard.instantiateViewControllerWithIdentifier("EditSecond") as! EditSecondViewController
        nextVC.editFirstVC = vc
        vc.presentViewController(nextVC, animated: true, completion: nil)
    }
    
    func tweetTransition(vc: UIViewController, myTweetVC: MyTweetViewController?) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = storyboard.instantiateViewControllerWithIdentifier("Tweet") as! TweetViewController
        nextVC.myTweetVC = myTweetVC
        vc.presentViewController(nextVC, animated: true, completion: nil)
    }
    
    func replyTransition(vc: UIViewController, num: Int?) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = storyboard.instantiateViewControllerWithIdentifier("Reply") as! ReplyViewController
        nextVC.tweetId = num!
        vc.presentViewController(nextVC, animated: true, completion: nil)
    }
    
    func replyListTransition(vc: UIViewController, num: Int?, text: String?) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = storyboard.instantiateViewControllerWithIdentifier("ReplyList") as! ReplyListViewController
        nextVC.tweetId = num!
        nextVC.tweetText = text!
        vc.presentViewController(nextVC, animated: true, completion: nil)
    }
}
