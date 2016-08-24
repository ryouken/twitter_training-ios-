import Foundation
import SwiftCop

extension SwiftCop {
    
    func minimum_2(textField: UITextField) {
        addSuspect(Suspect(view:textField, sentence: "2文字以上でご入力下さい。", trial: Trial.Length(.Minimum, 2)))
    }
    
    func minimum_8(textField: UITextField) {
        addSuspect(Suspect(view: textField, sentence: "8文字以上でご入力下さい。", trial: Trial.Length(.Minimum, 8)))
    }
    
    func max_20(textField: UITextField) {
        addSuspect(Suspect(view: textField, sentence: "20文字以下でご入力下さい。", trial: Trial.Length(.Maximum, 20)))
    }
    
    func email(textField: UITextField) {
        addSuspect(Suspect(view:textField, sentence: "emailの形式でご入力下さい。", trial: Trial.Email))
    }
}
