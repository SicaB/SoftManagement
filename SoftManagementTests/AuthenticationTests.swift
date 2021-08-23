//
//  AuthenticationTests.swift
//  SoftManagementTests
//
//

import XCTest
@testable import SoftManagement
class AuthenticationTests: XCTestCase {
    
    var logInViewModel: LogInViewModel!
    var signUpViewModel: SignUpViewModel!
    var mockAuthentication: MockAuthentication!

    override func setUp() {
        mockAuthentication = MockAuthentication()
        logInViewModel = .init(authentication: mockAuthentication)
        signUpViewModel = .init(authentication: mockAuthentication)
    }
    func test_login_with_correct_details_and_set_signedIn_to_true() {
        mockAuthentication.result = .success(())
        logInViewModel.send(action: .login)
        XCTAssertTrue(logInViewModel.signedIn)
    }
    func test_login_failed_and_error_is_set() {
        mockAuthentication.result = .failure(NSError(domain: "", code: -1, userInfo: nil))
        logInViewModel.send(action: .login)
        XCTAssertNotNil(logInViewModel.error)
    }
    func test_forgot_password_send_an_email_and_set_emailSend_to_true() {
        mockAuthentication.result = .success(())
        logInViewModel.send(action: .forgotPassword)
        XCTAssertTrue(logInViewModel.emailSend)
    }
    func test_forgot_password_wrong_email_and_error_is_set() {
        mockAuthentication.result = .failure(NSError(domain: "", code: -1, userInfo: nil))
        logInViewModel.send(action: .forgotPassword)
        XCTAssertNotNil(logInViewModel.error)
    }
    func test_signup_with_correct_details_and_set_signedIn_to_true() {
        signUpViewModel.user = mockAuthentication.user
        signUpViewModel.send(action: .signup)
        XCTAssertTrue(signUpViewModel.isValidForm)
        XCTAssertTrue(signUpViewModel.signedIn)
    }
    func test_signup_with_incorrect_details_and_isValidForm_is_false() {
        signUpViewModel.user = mockAuthentication.user2
        signUpViewModel.send(action: .signup)
        XCTAssertFalse(signUpViewModel.isValidForm)
    }
}
