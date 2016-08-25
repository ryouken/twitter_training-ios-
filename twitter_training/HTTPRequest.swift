import Foundation
import Alamofire
import SwiftyJSON

class HTTPRequest{
    
    func getUsers(vc: UserListViewController) {
        Alamofire.request(.GET, "\(Constant.url)/json/user/list")
            .responseJSON { response in
                guard let object = response.result.value else {
                    return
                }
                vc.users.removeAll()
                let json = JSON(object)
                print(json)
                json.forEach { (_, json) in
                    json.forEach { (_, user) in
                        let user: [String: String?] = [
                            "user_id": user["user_id"].description,
                            "user_name": user["user_name"].string,
                            "profile_text": user["profile_text"].string
                        ]
                        vc.users.append(user)
                    }
                }
            vc.tableView.reloadData()
        }
    }


    func getTimeline(vc: TimelineViewController) {
        Alamofire.request(.GET, "\(Constant.url)/json/tweet/timeline")
            .responseJSON { response in
                guard let object = response.result.value else {
                    return
                }
                vc.tweets.removeAll()
                let json = JSON(object)
                print(json)
                json.forEach { (_, tweet) in
                    let tweet: [String: String?] = [
                        "tweet_id": tweet["tweet_id"].string,
                        "tweet_user_name": tweet["tweet_user_name"].string,
                        "tweet_text": tweet["tweet_text"].string
                    ]
                    vc.tweets.append(tweet)
                }
            vc.tableView?.reloadData()
        }
    }
    
    func getMyTweet(vc: MyTweetViewController) {
        Alamofire.request(.GET, "\(Constant.url)/json/tweet/mylist")
            .responseJSON { response in
                guard let object = response.result.value else {
                    return
                }
                vc.tweets.removeAll()
                let json = JSON(object)
                print(json)
                json.forEach { (_, json) in
                    json.forEach { (_, tweet) in
                        let tweet: [String: String?] = [
                            "tweet_id": tweet["tweet_id"].description,
                            "tweet_text": tweet["tweet_text"].string
                        ]
                        vc.tweets.append(tweet)
                    }
                }
            vc.tableView?.reloadData()
        }
    }
    
    func getReplies(vc: ReplyListViewController, json: [String: Int]) {
        Alamofire.request(.POST, "\(Constant.url)/json/reply/list", parameters: json, encoding: .JSON)
            .responseJSON { response in
                guard let object = response.result.value else {
                    return
                }
                vc.replies.removeAll()
                let json = JSON(object)
                print(json)
                json.forEach { (_, reply) in
                    let reply: [String: String?] = [
                        "reply_id": reply["reply_id"].string,
                        "reply_user_name": reply["reply_user_name"].string,
                        "reply_text": reply["reply_text"].string
                    ]
                    vc.replies.append(reply)
                }
            vc.tableView.reloadData()
        }
    }


    
    func getFollowList(vc: FollowListViewController) {
        Alamofire.request(.GET, "\(Constant.url)/json/follow/list")
            .responseJSON { response in
                guard let object = response.result.value else {
                    return
                }
                vc.follows.removeAll()
                let json = JSON(object)
                print(json)
                json.forEach { (_, follow) in
                    let follow: [String: String?] = [
                        "user_name": follow["user_name"].string,
                        "profile_text": follow["profile_text"].string
                    ]
                    vc.follows.append(follow)
                }
            vc.tableView?.reloadData()
        }
    }
    
    func getFollowedList(vc: FollowedListViewController) {
        Alamofire.request(.GET, "\(Constant.url)/json/followed/list")
            .responseJSON { response in
                guard let object = response.result.value else {
                    return
                }
                let json = JSON(object)
                print(json)
                json.forEach { (_, follow) in
                    let follow: [String: String?] = [
                        "user_id": follow["user_id"].description,
                        "user_name": follow["user_name"].string,
                        "profile_text": follow["profile_text"].string
                    ]
                    vc.follows.append(follow)
                }
            vc.tableView.reloadData()
        }
    }
    
    func logout(vc: EndPageViewController) {
        Alamofire.request(.GET, "\(Constant.url)/json/user/logout")
            .responseJSON { response in
                guard let object = response.result.value else {
                    return
                }
                let json = JSON(object)
                print(json)
                json.forEach {(_, json) in
                    if (response.response?.statusCode == 200) {
                        print(json)
                        let parentVC = vc.pageMenuVC.presentingViewController
                        parentVC!.dismissViewControllerAnimated(false, completion: {
                            (parentVC as? UINavigationController)?.popToRootViewControllerAnimated(false)
                        })
                    } else {
                        // エラー
                    }
                }
        }
    }
    
    func login(vc: LoginViewController, json:[String: String]) {
        Alamofire.request(.POST, "\(Constant.url)/json/user/authenticate", parameters: json, encoding: .JSON)
            .responseJSON { response in
                guard let object = response.result.value else {
                    return
                }
                let json = JSON(object)
                print(json)
                json.forEach {(_, json) in
                    if (response.response?.statusCode == 200) {
                        // メインページへの画面遷移
                        vc.scene.preTransition(vc, storyboardId: "PageMenu")
                    } else {
                        vc.alert.loginError(vc)
                    }
                }
        }

    }
    
    func createUser(vc: RegisterSecondViewController, json: [String: AnyObject]) {
        Alamofire.request(.POST, "\(Constant.url)/json/user/create", parameters: json, encoding: .JSON)
            .responseJSON { response in
                guard let object = response.result.value else {
                    vc.alert.responseError(vc)
                    return
                }
                let json = JSON(object)
                print(json)
                json.forEach {(_, json) in
                    if (response.response?.statusCode == 200) {
                        // ログインページへ画面遷移
                        vc.scene.navTransition(vc, storyboardId: "Login")
                    } else {
                        vc.alert.responseError(vc)
                    }
                }
        }
    }
    
    func getUser(vc: EditFirstViewController) {
        Alamofire.request(.GET, "\(Constant.url)/json/user/edit")
            .responseJSON { response in
                guard let object = response.result.value else {
                    return
                }
                JSON(object).forEach { (_, user) in
                    vc.emailText.text = user["email"].string!
                }
        }
    }
    
    func getUser(vc: EditSecondViewController) {
        Alamofire.request(.GET, "\(Constant.url)/json/user/edit")
            .responseJSON { response in
                guard let object = response.result.value else {
                    return
                }
                JSON(object).forEach { (_, user) in
                    vc.nameText.text = user["user_name"].string!
                    vc.profileText.text = user["profile_text"].string!
                }
        }
    }
    
    func updateUser(vc: EditSecondViewController, json: [String: AnyObject]) {
        Alamofire.request(.PUT, "\(Constant.url)/json/user/update", parameters: json, encoding: .JSON)
            .responseJSON { response in
                guard let object = response.result.value else {
                    return
                }
                let json = JSON(object)
                print(json)
                json.forEach {(_, json) in
                    if (response.response?.statusCode == 200) {
                        // メインページへ画面遷移
                        vc.dismissViewControllerAnimated(false, completion: nil)
                        vc.editFirstVC.dismissViewControllerAnimated(false, completion: nil)
                    } else {
                        // エラー
                    }
                }
        }
    }
    
    func createTweet(vc: TweetViewController, json: [String: AnyObject]) {
        Alamofire.request(.POST, "\(Constant.url)/json/tweet/create", parameters: json, encoding: .JSON)
            .responseJSON { response in
                guard let object = response.result.value else {
                    return
                }
                let json = JSON(object)
                print(json)
                json.forEach {(_, json) in
                    if (response.response?.statusCode == 200) {
                        // メインページへの画面遷移
                        vc.dismissViewControllerAnimated(false, completion: {
                            vc.http.getMyTweet(vc.myTweetVC)
                        })
                    } else {
                        // エラー
                    }
                }
        }
    }
    
    func createReply(vc: ReplyViewController, json: [String: AnyObject]) {
        Alamofire.request(.POST, "\(Constant.url)/json/reply/create", parameters: json, encoding: .JSON)
            .responseJSON { response in
                guard let object = response.result.value else {
                    vc.alert.replyError(vc)
                    return
                }
                let json = JSON(object)
                print(json)
                json.forEach {(_, json) in
                    if (response.response?.statusCode == 200) {
                        // メインページへの画面遷移
                        vc.dismissViewControllerAnimated(false, completion: {
                        })
                    } else {
                        // エラー
                    }
                }
        }
    }
    
    func createFollow(vc: UserListViewController, json: [String: Int]) {
        Alamofire.request(.POST, "\(Constant.url)/json/follow/create", parameters: json, encoding: .JSON)
            .responseJSON { response in
                guard let object = response.result.value else {
                    return
                }
                let json = JSON(object)
                json.forEach {(_, json) in
                    print(json)
                    if (response.response?.statusCode == 200) {
                        vc.http.getUsers(vc)
                        vc.http.getTimeline(vc.timelineVC)
                        vc.http.getFollowList(vc.followListVC)
                    } else {
                    }
                }
            }
    }
    
    func createFollow(vc: FollowedListViewController, json: [String: Int]) {
        Alamofire.request(.POST, "\(Constant.url)/json/follow/create", parameters: json, encoding: .JSON)
            .responseJSON { response in
                guard let object = response.result.value else {
                    return
                }
                let json = JSON(object)
                json.forEach {(_, json) in
                    if (response.response?.statusCode == 200) {
                        vc.http.getUsers(vc.userListVC)
                        vc.http.getTimeline(vc.timelineVC)
                        vc.http.getFollowList(vc.followListVC)
                    } else {
                    }
                }
        }
    }

}