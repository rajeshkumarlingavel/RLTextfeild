//
//  RLTextField
//  RLTextField
//
//  Created by rajeshkumar.l on 27/12/16.
//  Copyright © 2016 rajesh-2098. All rights reserved.
//

import UIKit

class RLTextField: UIView {
    
    private var titlePostionView:UIView!
    private var textfieldPostionView:UIView!
    
    private var inputTextField:UITextField!
    private var titleLabel:UILabel!
    
    private var textFont = UIFont.systemFontOfSize(18)
    private var titleFont = UIFont.systemFontOfSize(14)
    
    var maximumLength:Int = 10
    
    var keyboardType = UIKeyboardType.Default
    
    var lineHeight:CGFloat = 1
    var selectedLineHeight:CGFloat = 2
    var lineColor = UIColor.blackColor()
    var selectedLineColor = UIColor.blackColor()
    
    
    var placeholderText = "Email"
    var placeholderTitleColor = UIColor.orangeColor()
    
    var RLTintColor  = UIColor.blueColor()
    
    var errorText = "Error"
    var errorColor = UIColor.redColor()
    
    var lineLayer:CALayer!
    
    override init(frame:CGRect) {
        super.init(frame: frame)
    }
    
    override func willMoveToSuperview(newSuperview: UIView?) {
        createViews()
        deFocused()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func deFocused() -> Void {
        
        inputTextField.resignFirstResponder()
        lineLayer.removeFromSuperlayer()
        lineLayer = textfieldPostionView.addBorder(UIRectEdge.Bottom, color:lineColor, thickness: lineHeight)
        textfieldPostionView.layer.addSublayer(lineLayer)
        inputTextField.placeholder = placeholderText
        
        titleLabel.textColor = UIColor.grayColor()
        
        if inputTextField.text == nil || inputTextField.text!.isEmpty{
            titleLabel.text = ""
        }
        
    }
    
    private func getFocused() -> Void{
        
        inputTextField.placeholder = ""
        titleLabel.text = placeholderText
        titleLabel.textColor = placeholderTitleColor
        lineLayer.removeFromSuperlayer()
        lineLayer = textfieldPostionView.addBorder(UIRectEdge.Bottom, color:placeholderTitleColor, thickness: selectedLineHeight)
        textfieldPostionView.layer.addSublayer(lineLayer)
        
    }
    
}


// MARK: - Createing Initial View
extension RLTextField {
    
    
    /// This method for creating inital views
    private func createViews(){
        
        addTitlePostionView()
        addTextFieldPostionView()
        addInputTextField()
        addTitleLabel()
        
    }
    
    
    private func addTitlePostionView(){
        
        titlePostionView = UIView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height/3))
        //        titlePostionView.backgroundColor = UIColor.redColor()
        addSubview(titlePostionView)
    }
    
    private func addTextFieldPostionView(){
        
        textfieldPostionView = UIView(frame: CGRect(x: 0, y:titlePostionView.frame.height, width: frame.width, height: frame.height - titlePostionView.frame.height))
        lineLayer = textfieldPostionView.addBorder(UIRectEdge.Bottom, color:lineColor, thickness: lineHeight)
        textfieldPostionView.layer.addSublayer(lineLayer)
        addSubview(textfieldPostionView)
    }
    
    private func addInputTextField(){
        
        inputTextField = UITextField(frame:textfieldPostionView.bounds)
        inputTextField.delegate = self
        inputTextField.placeholder = placeholderText
    
        inputTextField.keyboardType = keyboardType
        inputTextField.font = textFont
        textfieldPostionView.addSubview(inputTextField)
        
    }
    
    private func addTitleLabel(){
        
        if titleLabel != nil{
            return
        }
        
        titleLabel = UILabel(frame: titlePostionView.bounds)
        titleLabel.textColor = placeholderTitleColor
        titleLabel.text = ""
        titleLabel.font = titleFont
        titlePostionView.addSubview(titleLabel)
        
    }
    
}

extension RLTextField:UITextFieldDelegate{
    
    func textFieldDidBeginEditing(textField: UITextField) {
        getFocused()
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        deFocused()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        deFocused()
        
        return true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        return !(textField.text?.characters.count == maximumLength && string != "")
    }
}

private extension UIView {
    
    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) -> CALayer{
        
        let border = CALayer()
        
        switch edge {
        case UIRectEdge.Top:
            border.frame = CGRectMake(0, 0, CGRectGetHeight(self.frame), thickness)
            break
        case UIRectEdge.Bottom:
            border.frame = CGRectMake(0, CGRectGetHeight(self.frame) - thickness, UIScreen.mainScreen().bounds.width, thickness)
            break
        case UIRectEdge.Left:
            border.frame = CGRectMake(0, 0, thickness, CGRectGetHeight(self.frame))
            break
        case UIRectEdge.Right:
            border.frame = CGRectMake(CGRectGetWidth(self.frame) - thickness, 0, thickness, CGRectGetHeight(self.frame))
            break
        default:
            break
        }
        
        border.backgroundColor = color.CGColor
        
        return border
    }
}


