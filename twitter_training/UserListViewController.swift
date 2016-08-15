import UIKit
import Alamofire
import SwiftyJSON

class UserListViewController: UIViewController, UITableViewDataSource {
    var users: [[String: String?]] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func button(sender: AnyObject) {
        tableView.dataSource = self
        getUsers()
    }
    @IBAction func tweetButton(sender: AnyObject) {
        // ツイートページの画面遷移
        let storyboard: UIStoryboard = self.storyboard!
        let nextVC = storyboard.instantiateViewControllerWithIdentifier("Tweet") as! TweetViewController
        self.presentViewController(nextVC, animated: true, completion: nil)
    }
    @IBAction func editButton(sender: AnyObject) {
        // 会員編集ページの画面遷移
        let storyboard: UIStoryboard = self.storyboard!
        let nextVC = storyboard.instantiateViewControllerWithIdentifier("EditFirst") as! EditFirstViewController
        self.presentViewController(nextVC, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func getUsers() {
        Alamofire.request(.GET, "http://localhost:9000/json/user/list")
            .responseJSON { response in
                guard let object = response.result.value else {
                    return
                }
                let json = JSON(object)
                json.forEach { (_, json) in
                    json.forEach { (_, user) in
                    let user: [String: String?] = [
                        "user_name": user["user_name"].string,
                    ]
                    self.users.append(user)
                    }
                }
            self.tableView.reloadData()
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "cell")
        let user = users[indexPath.row]
        cell.textLabel?.text = user["user_name"]!
        return cell
    }
}
