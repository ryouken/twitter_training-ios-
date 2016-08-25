import Foundation
import UIKit

class Keyboard {
    func hideKeyboard(textField: UITextField) {
        // 他のところをタップしたらキーボードを隠す
        func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
            //非表示にする。
            if(textField.isFirstResponder()){
                textField.resignFirstResponder()
            }
        }
        // returnでキーボードを隠す
        func textFieldShouldReturn(textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
    }
}