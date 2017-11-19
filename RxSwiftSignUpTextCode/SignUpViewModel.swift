//
//  SignUpViewModel.swift
//  RxSwiftSignUpTextCode
//
//  Created by park kyung suk on 2017/11/18.
//  Copyright © 2017年 park kyung suk. All rights reserved.
//

import RxSwift


// 프로토콜에 사용할 메소드를 먼저 선언하고 나서 실장을 한다.
protocol SignUpViewModelInput {
    
    func viewDidLoad()
    func closeBtnTapped()
    func inputEmail(email: String)
    func inputPassword(password: String)
    func registUserInfo()
    
}
protocol SignUpViewModelOutput {
   
    var closeViewController: Observable<Void> { get }
    var emailtext: Observable<String> { get }
    var passwordText: Observable<String> { get }
    var showAlertView: Observable<Void> { get }
    var validationErrorMessage: Observable<String> { get }
}

protocol SignUpViewModelType {
    
    var input: SignUpViewModelInput { get }
    var output: SignUpViewModelOutput { get }
}


class SignUpViewModel: SignUpViewModelInput, SignUpViewModelOutput, SignUpViewModelType {
   
    let bag = DisposeBag()
    
    //----------------------------------------------------
    // Input
    private var ViewDidLoadProperty = Variable<Void>(())
    func viewDidLoad() {
        self.ViewDidLoadProperty.value = ()
    }
    
    private var closeBtnTappedProperty = Variable<Void>(())
    func closeBtnTapped() {
        self.closeBtnTappedProperty.value = ()
    }
    
    private var inputEmailProperty = Variable<String>("")
    func inputEmail(email: String) {
        self.inputEmailProperty.value = email
    }
    
    private var inputPasswordProperty = Variable<String>("")
    func inputPassword(password: String) {
        self.inputPasswordProperty.value = password
    }
    
    private var registBtnTappedProperty = Variable<Void>(())
    func registUserInfo() {
        registBtnTappedProperty.value = ()
    }
    
    //------------------------------------------------------
    // Output
    private var closeViewControllerProperty = Variable<Void>(())
    var closeViewController: Observable<Void> {
        return closeBtnTappedProperty.asObservable().skip(1)
    }
    
    private var emailTextProperty = Variable<String>("")
    var emailtext: Observable<String> {
        return emailTextProperty.asObservable().skip(1)
    }
    
    private var passwordTextProperty = Variable<String>("")
    var passwordText: Observable<String> {
        return passwordTextProperty.asObservable().skip(1)
    }
   
    private var showAlertViewProperty = Variable<Void>(())
    var showAlertView: Observable<Void> {
        return showAlertViewProperty.asObservable().skip(1)
    }
    
    private var validationErrorMessageProperty = Variable<String>("")
    var validationErrorMessage: Observable<String> {
        return validationErrorMessageProperty.asObservable().skip(1)
    }
    
    
    var input: SignUpViewModelInput { return self }
    
    var output: SignUpViewModelOutput { return self }
    
    
    init() {
        
        //크로즈 버튼이 눌렸을때
        self.closeBtnTappedProperty.asObservable()
            .subscribe(onNext: { _ in
                print("closeBtnTappedProperty triggered!")
                self.closeViewControllerProperty.value = ()
            })
            .disposed(by: bag)
        
        // 유저로부터 입력된 이메일을 emailTextProperty에 격납
        
        
        let inputEmail = self.inputEmailProperty.asObservable()
            
        inputEmail
            .subscribe(onNext: { email in
                print("inputEmailProperty triggered!: \(email)")
                self.emailTextProperty.value = email
            })
            .disposed(by: bag)
        
        inputEmail
            .subscribe(onNext: { email in
                if email.count < 5  {
                    self.validationErrorMessageProperty.value = "10までだよ！"
                } else {
                    self.validationErrorMessageProperty.value = "登録してもいいよ！"
                }
            })
            .disposed(by: bag)
        
        // 유저로부터 입력된 패스워드를 passwordTextProperty에 격납
        self.inputPasswordProperty.asObservable()
            .subscribe(onNext: { password in
                print("inputPasswordProperty triggered!: \(password)")
                self.passwordTextProperty.value = password
            })
            .disposed(by: bag)
        
        // 유저가 등록버튼을 누르면 성공 얼럿을 표시함
        self.registBtnTappedProperty.asObservable()
            .subscribe(onNext: { _ in
                print("registBtnTappedProperty triggered!")
                self.showAlertViewProperty.value = ()
            })
            .disposed(by: bag)
    }
    
    
}






















