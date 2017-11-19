//
//  RxSwiftsignUpTests.swift
//  RxSwiftSignUpTextCodeTests
//
//  Created by park kyung suk on 2017/11/18.
//  Copyright © 2017年 park kyung suk. All rights reserved.
//

import XCTest
import RxSwift

@testable import RxSwiftSignUpTextCode

class RxSwiftsignUpTests: XCTestCase {
    
    let vm: SignUpViewModelType = SignUpViewModel()
    let bag = DisposeBag()
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_MailValidation_OK() {
        
        vm.output.validationErrorMessage
            .subscribe(onNext: { errorMsg in
                XCTAssertTrue(!errorMsg.isEmpty)
            })
            .disposed(by: bag)
        
        vm.input.inputEmail(email: "12345")
    }
    
    func test_閉じる() {
        
        vm.output.closeViewController
            .subscribe(onNext: { _ in
                XCTAssertTrue(true)
                
            })
            .disposed(by: bag)
    }
    
    func test_メール入力() {
        vm.output.passwordText
            .subscribe(onNext: { text in
                XCTAssertTrue(!text.isEmpty)
            })
            .disposed(by: bag)
        
        vm.input.inputPassword(password: "AAA")
        
    }
    
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
