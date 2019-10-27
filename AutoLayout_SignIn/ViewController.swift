//
//  ViewController.swift
//  AutoLayout_SignIn
//
//  Created by 양팀장 on 2019. 10. 27..
//  Copyright © 2019년 양팀장. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var emailError: UILabel!
    @IBOutlet weak var passwordError: UILabel!
    
    
    var emailErrorHeight: NSLayoutConstraint!
    var passwordErrorHeight: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // textfield 값이 변경될 때 캐치(기본 제공되는 메소드가 없음)
        emailTextField.addTarget(self, action: #selector(updateEmail), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(updateEmail), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(updateEmail), for: .editingChanged)
        
        emailErrorHeight = emailError.heightAnchor.constraint(equalToConstant: 0)
        passwordErrorHeight = passwordError.heightAnchor.constraint(equalToConstant: 0)
        
    }
    

    @objc func updateEmail (textField: UITextField) {
    
        if textField == emailTextField {
            print("changed emailTextField \(textField.text!)")
            if isValidEmail(email: textField.text) == true {
                // 에러표시 숨김
                emailErrorHeight.isActive = true
            } else {

                // 에러표시 노출
                emailErrorHeight.isActive = false
            }
            
        } else if textField == passwordTextField {
            print("changed passwordTextField \(textField.text!)")
            if isValidPassword(pw: textField.text) == true {
                passwordErrorHeight.isActive = true
                
            } else {
                passwordErrorHeight.isActive = false
                
            }
            
        }
        
        
        // 애니메이션 적용
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
    func isValidEmail(email: String?) -> Bool {
        
        guard email != nil else { return false }
        
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
        return pred.evaluate(with: email)  // evaluate: 정규식이 맞는지 체크
    }
    
    func isValidPassword (pw: String?) -> Bool {
        if let hasPassword = pw {
            if hasPassword.count < 8 {
                return false
            }
        }

        return true

    }
    

}

