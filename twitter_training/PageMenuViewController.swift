import UIKit

class PageMenuViewController: UIViewController {
    
    var pageMenu: CAPSPageMenu?
    
    @IBAction func tweetButton(sender: AnyObject) {
        // ツイートページの画面遷移
        let storyboard = self.storyboard!
        let nextVC = storyboard.instantiateViewControllerWithIdentifier("Tweet") as! TweetViewController
        self.presentViewController(nextVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Viewを格納する配列
        var controllerArray: [UIViewController] = []
        
        // 追加するViewを作成
        let UserListVC = self.storyboard!.instantiateViewControllerWithIdentifier("UserList")
        UserListVC.title = "UserList"
        controllerArray.append(UserListVC)
        
        let TimelineVC = self.storyboard!.instantiateViewControllerWithIdentifier("Timeline")
        TimelineVC.title = "Timeline"
        controllerArray.append(TimelineVC)
        
        let MyTweetVC = self.storyboard!.instantiateViewControllerWithIdentifier("MyTweet")
        MyTweetVC.title = "MyTweet"
        controllerArray.append(MyTweetVC)
        
        let FollowListVC = self.storyboard!.instantiateViewControllerWithIdentifier("FollowList")
        FollowListVC.title = "FollowList"
        controllerArray.append(FollowListVC)
        
        let FollowedListVC = self.storyboard!.instantiateViewControllerWithIdentifier("FollowedList")
        FollowedListVC.title = "FollowedList"
        controllerArray.append(FollowedListVC)
        
        let EndPageVC = self.storyboard!.instantiateViewControllerWithIdentifier("EndPage")
        EndPageVC.title = "Settings"
        controllerArray.append(EndPageVC)
        
        // PageMenuの設定
        let parameters: [CAPSPageMenuOption] = [
            .MenuItemSeparatorWidth(4.3),
            .MenuItemSeparatorPercentageHeight(0.1)
        ]
        
        // PageMenuのビューのサイズを設定
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRectMake(0.0, 50.0, self.view.frame.width, self.view.frame.height), pageMenuOptions: parameters)
        
        // PageMenuのビューを親のビューに追加
        self.view.addSubview(pageMenu!.view)
        // PageMenuのビューをToolbarの後ろへ移動
        self.view.sendSubviewToBack(pageMenu!.view)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}