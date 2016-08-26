import UIKit
import SwiftyJSON
import Alamofire

class FollowListViewController: UIViewController {
    
    var pageMenu : CAPSPageMenu?
    let http = HTTPRequest()
    var users: [Follow] = []
    
    @IBOutlet weak var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView!.dataSource = self
        tableView!.estimatedRowHeight = 80
        tableView!.rowHeight = UITableViewAutomaticDimension
        http.getFollowList(self)
    }

}

extension FollowListViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    // TODO: cellの書き方
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "cell")
        let user = users[indexPath.row]
        cell.textLabel?.text = user.profile_text
        cell.textLabel?.font = UIFont(name: "Arial", size: 24)
        cell.detailTextLabel?.text = "@" + user.user_name
        cell.detailTextLabel?.font = UIFont(name: "Arial", size: 16)
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
        return cell
    }
    
}