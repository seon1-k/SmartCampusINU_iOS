//
//  LoginViewController.swift
//  SmartCampus
//
//  Created by BLU on 2017. 3. 17..
//  Copyright © 2017년 INUAPPCENTER. All rights reserved.
//

import UIKit
import Toaster

final class LoginViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var autoLoginButton: CheckBox!
    
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(viewClicked))
        self.view.addGestureRecognizer(gesture)
        
    }
    
    func initView() {
        self.navigationItem.title = "smart campus"
        idTextField.text = "201203147"
        pwTextField.text = "1590118"
        
        idTextField.delegate = self
        pwTextField.delegate = self
        
        idTextField.layer.borderColor = UIColor.white.cgColor
        pwTextField.layer.borderColor = UIColor.white.cgColor
        loginButton.layer.borderColor = UIColor.clear.cgColor
    }
    
    
    // MARK: Actions
    
    func viewClicked() {
        self.view.endEditing(true)
    }
    
    func userLogin() {
        guard let userid = self.idTextField.text, !userid.isEmpty else { return }
        guard let password = self.pwTextField.text, !password.isEmpty else { return }
        AuthService.login(userid: userid, password: password) {  (success) -> () in
            switch (success) {
            case true: print("성공했다")
            
            let userDefaults = Foundation.UserDefaults.standard
            userDefaults.set(userid, forKey: "stuid")
            userDefaults.set(password, forKey: "stupw")
            userDefaults.set(self.autoLoginButton.isChecked, forKey:"autoLogin")
            
            print(gsno(userDefaults.string(forKey: "autoLogin")))
            
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mainnavcontroller")
            
            self.present(vc, animated: true, completion: nil)
            
            
            break;
                
            case false: print("실패했다")
                Toast(text:"학번 혹은 비밀번호가 틀립니다.").show()
            }
            
        }
        
    }
    
    @IBAction func loginButtonClicked(_ sender: Any) {
        self.userLogin()
        
    }
    
    // MARK: Text Field Delegates
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField.isEqual(self.idTextField)){ //titleField에서 리턴키를 눌렀다면
            self.pwTextField.becomeFirstResponder()//컨텐츠필드로 포커스 이동
            self.view.endEditing(true)
        }
        else if(textField.isEqual(self.pwTextField)){
            self.userLogin()
            self.view.endEditing(true)
        }
        
        return true
    }
    
}


