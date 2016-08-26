import Foundation
import SwiftyJSON

class User {
    var user_id: Int!
    var email: String!
    var user_name: String!
    var password: String!
    var profile_text: String?
    
    init(user: JSON) {
        self.user_id      = user["user_id"].intValue
        self.email        = user["email"].stringValue
        self.user_name    = user["user_name"].stringValue
        self.password     = user["password"].stringValue
        self.profile_text = user["profile_text"].string
    }
    
    // TODO: 型が違うだけ
    init(vc: RegisterSecondViewController) {
        self.user_id      = 0
        self.email        = vc.delegate.emailText.text!
        self.user_name    = vc.nameText.text!
        self.password     = vc.delegate.passwordText.text!
        self.profile_text = vc.profileText.text!
    }
    
    init(vc: EditSecondViewController) {
        self.user_id      = 0
        self.email        = vc.delegate.emailText.text!
        self.user_name    = vc.nameText.text!
        self.password     = vc.delegate.passwordText.text!
        self.profile_text = vc.profileText.text!
    }
}

class Tweet {
    var tweet_id: Int!
    var tweet_text: String!
    
    init(tweet: JSON) {
        self.tweet_id   = tweet["tweet_id"].intValue
        self.tweet_text = tweet["tweet_text"].stringValue
    }
    
    init(vc: TweetViewController) {
        self.tweet_id = 0
        self.tweet_text = vc.tweetText.text!
    }
}

class Timeline {
    var tweet_id: Int!
    var tweet_user_name: String!
    var tweet_text: String!
    
    init(tweet: JSON) {
        self.tweet_id        = tweet["tweet_id"].intValue
        self.tweet_user_name = tweet["tweet_user_name"].stringValue
        self.tweet_text      = tweet["tweet_text"].stringValue
    }
}

class Reply {
    var reply_id: Int!
    var reply_user_name: String!
    var reply_text: String!
    
    init(reply: JSON) {
        self.reply_id        = reply["reply_id"].intValue
        self.reply_user_name = reply["reply_user_name"].stringValue
        self.reply_text      = reply["reply_text"].stringValue
    }
    
}

class ReplyCreate {
    var tweet_id: Int!
    var reply_text: String!
    
    init(vc: ReplyViewController) {
        self.tweet_id = vc.tweetId
        self.reply_text = vc.replyText.text!
    }
}

class Follow {
    var user_name: String!
    var profile_text: String!
    
    init(user: JSON) {
        self.user_name    = user["user_name"].stringValue
        self.profile_text = user["profile_text"].stringValue
    }
}

class Followed {
    var user_id: Int!
    var user_name: String!
    var profile_text: String!
    
    init(user: JSON) {
        self.user_id      = user["user_id"].intValue
        self.user_name    = user["user_name"].stringValue
        self.profile_text = user["profile_text"].stringValue
    }
}

class Login {
    var email: String!
    var password: String!
    
    init(vc: LoginViewController) {
        self.email    = vc.emailText.text!
        self.password = vc.passwordText.text!
    }
}