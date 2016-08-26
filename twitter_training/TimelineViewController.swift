import UIKit
import SwiftyJSON
import Alamofire

class TimelineViewController: UIViewController {
    
    let scene = Scene()
    let alert = Alert()
    let http = HTTPRequest()
    var pageMenu : CAPSPageMenu?
    var tweets: [Timeline] = []
    
    @IBOutlet weak var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView!.dataSource = self
        tableView!.delegate = self
        tableView!.estimatedRowHeight = 80
        tableView!.rowHeight = UITableViewAutomaticDimension
        http.getTimeline(self)
    }
    
}

extension TimelineViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    // TODO: cellの書き方
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "cell")
        let tweet = tweets[indexPath.row]
        cell.textLabel?.text = tweet.tweet_text
        cell.textLabel?.font = UIFont(name: "Arial", size: 24)
        cell.detailTextLabel?.text = "@" + tweet.tweet_user_name
        cell.detailTextLabel?.font = UIFont(name: "Arial", size: 16)
        cell.textLabel?.numberOfLines=0
        cell.detailTextLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath:NSIndexPath) {
        let tweet = tweets[indexPath.row]
        alert.replyAction(self, tweet: tweet)
    }

}

