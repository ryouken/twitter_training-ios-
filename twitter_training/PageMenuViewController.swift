import UIKit

class PageMenuViewController: UIViewController {
    
    let scene = Scene()
    var pageMenu: CAPSPageMenu?
    var myTweetVC: MyTweetViewController!
    
    // ツイートページへの画面遷移
    @IBAction func tweetButton(sender: AnyObject) {
        scene.tweetTransition(self, myTweetVC: myTweetVC)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Viewを格納する配列
        var controllerArray: [UIViewController] = []
        
        // 追加するViewを作成
        let UserListVC = self.storyboard!.instantiateViewControllerWithIdentifier("UserList") as! UserListViewController
        UserListVC.title = "UserList"
        controllerArray.append(UserListVC)
        
        let TimelineVC = self.storyboard!.instantiateViewControllerWithIdentifier("Timeline")
        TimelineVC.title = "Timeline"
        controllerArray.append(TimelineVC)
        
        
        let MyTweetVC = self.storyboard!.instantiateViewControllerWithIdentifier("MyTweet")
        MyTweetVC.title = "MyTweet"
        controllerArray.append(MyTweetVC)
        myTweetVC = MyTweetVC as! MyTweetViewController
        
        let FollowListVC = self.storyboard!.instantiateViewControllerWithIdentifier("FollowList")
        FollowListVC.title = "FollowList"
        controllerArray.append(FollowListVC)
        UserListVC.timelineVC = TimelineVC as! TimelineViewController
        UserListVC.followListVC = FollowListVC as! FollowListViewController
        
        let FollowedListVC = self.storyboard!.instantiateViewControllerWithIdentifier("FollowedList") as! FollowedListViewController
        FollowedListVC.title = "FollowedList"
        controllerArray.append(FollowedListVC)
        FollowedListVC.userListVC = UserListVC 
        FollowedListVC.timelineVC = TimelineVC as! TimelineViewController
        FollowedListVC.followListVC = FollowListVC as! FollowListViewController
        
        let EndPageVC = self.storyboard!.instantiateViewControllerWithIdentifier("EndPage")
        EndPageVC.title = "Settings"
        controllerArray.append(EndPageVC)
        (EndPageVC as! EndPageViewController).pageMenuVC = self
        
        // PageMenuの設定
        let parameters: [CAPSPageMenuOption] = [
            .MenuItemSeparatorWidth(4.3),
            .MenuItemSeparatorPercentageHeight(0.1)
        ]
        
        // PageMenuのビューのサイズを設定
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRectMake(0.0, 50.0, self.view.frame.width, self.view.frame.height), pageMenuOptions: parameters)
        
        // PageMenuのビューをToolbarの後ろに追加
        self.view.addSubview(pageMenu!.view)
        self.view.sendSubviewToBack(pageMenu!.view)
    }
    
}