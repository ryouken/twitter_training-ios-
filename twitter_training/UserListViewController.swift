import UIKit
import SwiftyJSON

class UserListViewController: UIViewController {
    
//    
//    @IBOutlet weak var myTextView: UITableViewCell!
//    
//    @IBAction func tapBtn(sender: AnyObject) {
//        let URLstr = "http://express.heartrails.com/api/json?method=getStations&line=JR山手線"
//        // 日本語入りのURLなので、UTF8形式に変換する
//        let encodeURL:String = URLstr.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
//        if let url = NSURL(string: encodeURL) {
//            let request = NSURLRequest(URL: url)
//            // データの読み込みが終わったら dispStationsを実行
//            NSURLConnection.sendAsynchronousRequest(
//                request,
//                queue: .mainQueue(),
//                completionHandler: dispStations)
//        }
//    }
//    // 表示するメッセージを入れる変数
//    var msg:String = ""
//    // 返ってきたJSONデータを解析して駅名表示
//    func dispStations(res: NSURLResponse?, data: NSData?, error: NSError?){
//        if error == nil {
//            // JSONデータに変換する
//            let json = JSON(data:data!)
//            // 路線名を取得
//            let linename = json["response"]["station"][0]["line"]
//            msg += "路線名=\(linename)\n"
//            // 路線内の各駅名を取得
//            let linedata = json["response"]["station"]
//            for id in 0..<linedata.count {
//                let name = linedata[id]["name"]
//                msg += "駅[\(id)]=\(name)\n"
//            }
//            // 駅名リストを表示
//            myTextView.textLabel!.text = msg        }
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
   }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
