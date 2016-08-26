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
                json["users"].forEach { (_, user) in
                    vc.users.append(User.init(user: user))
                }
    //          vc.users = json["users"].map { (_, json) in User(user: json)}
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
                json["timeline"].forEach { (_, tweet) in
                    vc.tweets.append(Timeline(tweet: tweet))
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
                json["tweets"].forEach { (_, tweet) in
                    vc.tweets.append(Tweet(tweet: tweet))
                }
            vc.tableView?.reloadData()
        }
    }
    
    func getReplies(vc: ReplyListViewController, tweet_id: Int) {
        let json: [String: Int] = ["tweet_id": tweet_id]
        Alamofire.request(.POST, "\(Constant.url)/json/reply/list", parameters: json, encoding: .JSON)
            .responseJSON { response in
                guard let object = response.result.value else {
                    return
                }
                vc.replies.removeAll()
                let json = JSON(object)
                print(json)
                json["reply"].forEach { (_, reply) in
                    vc.replies.append(Reply(reply: reply))
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
                vc.users.removeAll()
                let json = JSON(object)
                print(json)
                json["follow"].forEach { (_, user) in
                    vc.users.append(Follow(user: user))
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
                json["followed"].forEach { (_, user) in
                    vc.users.append(Followed(user: user))
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
    
    func login(vc: LoginViewController, user: Login) {
        let json = ["email": user.email, "password": user.password]
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
    
    func createUser(vc: RegisterSecondViewController, user: User) {
        let json: [String: AnyObject] = [
            "user_id"      : 0,
            "email"        : user.email,
            "password"     : user.password,
            "user_name"    : user.user_name,
            "profile_text" : user.profile_text ?? "" ]
        
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
    
    // TODO: 型が違うだけ
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
    
    func updateUser(vc: EditSecondViewController, user: User) {
        let json: [String: AnyObject] = [
            "user_id"      : 0,
            "email"        : user.email,
            "password"     : user.password,
            "user_name"    : user.user_name,
            "profile_text" : user.profile_text ?? "" ]
        
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
    
    func createTweet(vc: TweetViewController, tweet_text: String) {
        let json: [String : AnyObject] = ["tweet_id": 0, "tweet_text": tweet_text]
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
    
    func createReply(vc: ReplyViewController, reply: ReplyCreate) {
        let json: [String : AnyObject] = ["reply_id": 0, "tweet_id": reply.tweet_id, "reply_text": reply.reply_text]
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
    
    // TODO: 型が違うだけ
    func createFollow(vc: UserListViewController, user: User) {
        let json: [String : Int] = ["relation_id": 0, "followed_id": user.user_id]
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
    
    func createFollow(vc: FollowedListViewController, user: Followed) {
        let json: [String: Int] = ["relation_id": 0, "followed_id": user.user_id]
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