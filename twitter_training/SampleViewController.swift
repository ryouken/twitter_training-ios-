//import UIKit
//
//class SampleViewController: UIViewController, UITextFieldDelegate {
//    
//    private let maxLength = 30
//    private var previousText = ""
//    private var lastReplaceRange: NSRange!
//    private var lastReplacementString = ""
//    
//    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
//        self.previousText = textView.text
//        self.lastReplaceRange = range
//        self.lastReplacementString = text
//        
//        return true
//    }
//    
//    func textViewDidChange(textView: UITextView) {
//        if textView.markedTextRange != nil {
//            return
//        }
//        
//        if count(textView.text) > maxLength {
//            var offset = maxLength - count(textView.text)
//            var replacementString = (lastReplacementString as NSString).substringToIndex(count(lastReplacementString) + offset)
//            var text = (previousText as NSString).stringByReplacingCharactersInRange(lastReplaceRange, withString: replacementString)
//            var position = textView.positionFromPosition(textView.selectedTextRange!.start, offset: offset)
//            var selectedTextRange = textView.textRangeFromPosition(position, toPosition: position)
//            
//            textView.text = text
//            textView.selectedTextRange = selectedTextRange
//        }
//    }
//}