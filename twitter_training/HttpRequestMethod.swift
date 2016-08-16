//import UIKit
//import SwiftyJSON
//import Alamofire
//
//class HttpRequestMethod {
//    
//    
//    func loginRequest(var json) {
//        Alamofire.request(.POST, "http://localhost:9000/json/user/authenticate", parameters: json, encoding: .JSON)
//            .responseJSON { response in
//                print(response.response) // URL response
//                
//                guard let object = response.result.value else {
//                    return
//                }
//                
//                let json = JSON(object)
//                json.forEach {(_, json) in
//                    if (json == "login_success") {
//                        // メインページへの画面遷移
//                        let storyboard = self.storyboard!
//                        let nextVC = storyboard.instantiateViewControllerWithIdentifier("PageMenu") as! PageMenuViewController
//                        self.presentViewController(nextVC, animated: true, completion: nil)
//                    } else {
//                        let alertLabel: UILabel = UILabel(frame: CGRectMake(0,0,200,50))
//                        alertLabel.text = "ログイン認証に失敗しました。emailかpasswordが間違っています。"
//                        self.view.addSubview(alertLabel)
//                    }
//                }
//        }
//    }
//    
//}
