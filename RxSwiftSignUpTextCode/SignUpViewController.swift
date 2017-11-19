//
//  SignUpViewController.swift
//  RxSwiftSignUpTextCode
//
//  Created by park kyung suk on 2017/11/18.
//  Copyright © 2017年 park kyung suk. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SignUpViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    let bag = DisposeBag()
    let viewModel: SignUpViewModelType = SignUpViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }

    private func bindViewModel() {
        
        // ViewModel Input
        emailTextField.rx.text.asObservable()
            .subscribe(onNext: { [unowned self] email in
                self.viewModel.input.inputEmail(email: email!)
            })
            .disposed(by: bag)
        
        passTextField.rx.text.asObservable()
            .subscribe(onNext: { [unowned self] password in
                
                self.viewModel.input.inputPassword(password: password!)
            })
            .disposed(by: bag)
        
        
        // ViewModel Output
        self.viewModel.output.closeViewController
            .subscribe(onNext: { [unowned self] in
                self.dismiss(animated: true, completion: nil)
            })
            .disposed(by: bag)
        
        self.viewModel.output.emailtext
            .subscribe(onNext: { [unowned self] email in
                self.emailTextField.text = email
            })
            .disposed(by: bag)
        
        self.viewModel.output.passwordText
            .subscribe(onNext: { [unowned self] password in
                self.passTextField.text = password
            })
            .disposed(by: bag)
        
        self.viewModel.output.showAlertView
            .subscribe(onNext: { [unowned self] in
                let alert = UIAlertController(title: "はい", message: "登録できましたよ", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default)
                alert.addAction(ok)
                self.present(alert, animated: true)
            })
            .disposed(by: bag)
        
        self.viewModel.output.validationErrorMessage
            .subscribe(onNext: { [unowned self] errorMessage in
                self.errorLabel.text = errorMessage
            })
            .disposed(by: bag)
    }
    
    @IBAction func closeBtnTapped(_ sender: Any) {
        self.viewModel.input.closeBtnTapped()
    }
    @IBAction func registBtnTapped(_ sender: Any) {
        self.viewModel.input.registUserInfo()
    }
    
     
}
