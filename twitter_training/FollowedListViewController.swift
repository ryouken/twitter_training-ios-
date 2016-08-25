import UIKit
import SwiftyJSON
import Alamofire

class FollowedListViewController: UIViewController {
    
    let alert = Alert()
    let http = HTTPRequest()
    var pageMenu: CAPSPageMenu?
    var userListVC: UserListViewController!
    var timelineVC: TimelineViewController!
    var followListVC: FollowListViewController!
    var follows: [[String: String?]] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        http.getFollowedList(self)
    }
    
}

extension FollowedListViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return follows.count
    }
    
    // TODO: cellの書き方
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "cell")
        let follow = follows[indexPath.row]
        cell.textLabel?.text = follow["profile_text"]!
        cell.textLabel?.font = UIFont(name: "Arial", size: 24)
        cell.detailTextLabel?.text = "@" + follow["user_name"]!!
        cell.detailTextLabel?.font = UIFont(name: "Arial", size: 16)
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath:NSIndexPath) {
        let follow = follows[indexPath.row]
        let num: Int? = follow["user_id"]!.flatMap{ Int($0) }
        let json: [String : Int] = ["relation_id": 0, "followed_id": num!]
        alert.followAction(self, follow: follow, json: json)
    }
    
}