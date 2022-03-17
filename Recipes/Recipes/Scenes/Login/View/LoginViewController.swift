//
//  LoginViewController.swift
//  Recipes
//
//  Created by Taha on 16/03/2022.
//

import UIKit
import RxSwift

class LoginViewController: UIViewController {

    internal let disposeBag = DisposeBag()
    var viewModel: LoginViewModel!
    
    @IBOutlet weak var emailIcon: UIImageView!
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var passwordIcon: UIImageView!
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var loginButton: CustomButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Bind Data from View to ViewModel
        bindValidEmail()
        bindValidPassword()
        
        // Bind Data from ViewModel To View
        bindEmailField()
        bindPasswordField()
        
        bindLoginEnabled()
        bindErrorMessages()
        
    }

    @IBAction func signInPressed(_ sender: Any) {
        viewModel.login(email: emailTF.text ?? "", password: passwordTF.text ?? "")
    }
    
    @IBAction func processPressed(_ sender: Any) {
        viewModel.processPressed()
    }
    
    private func bindEmailField() {
        emailTF.rx.text.orEmpty
            .throttle(RxTimeInterval.seconds(1), latest: true, scheduler: MainScheduler.instance)
                .subscribe(onNext: { email in
                    self.viewModel.validateEmail(email: email)
                }, onDisposed: nil)
            .disposed(by: disposeBag)
    }

    private func bindPasswordField() {
        passwordTF.rx.text.orEmpty
            .throttle(RxTimeInterval.seconds(1), latest: true, scheduler: MainScheduler.instance)
                .subscribe(onNext: { password in
                    self.viewModel.validatePassword(password: password)
                }, onDisposed: nil)
            .disposed(by: disposeBag)
    }
    
    private func bindValidEmail() {
        viewModel.validEmail.asObservable().subscribe { isValidEmail in
            if isValidEmail.element ?? false {
                self.emailIcon.isHidden = false
            } else {
                self.emailIcon.isHidden = true
            }
        }.disposed(by: disposeBag)

    }

    private func bindValidPassword() {
        viewModel.validPassword.asObservable().subscribe { isValidPassword in
            if isValidPassword.element ?? false {
                self.passwordIcon.isHidden = false
            } else {
                self.passwordIcon.isHidden = true
            }
        }.disposed(by: disposeBag)

    }

    private func bindLoginEnabled() {
        viewModel.loginEnabled.asObservable().subscribe { isLoginEnabled in
            if isLoginEnabled.element ?? false {
                self.loginButton.isEnabled = true
                self.loginButton.backgroundColor = self.loginButton.backgroundColor?.withAlphaComponent(1)
            } else {
                self.loginButton.isEnabled = false
                self.loginButton.backgroundColor = self.loginButton.backgroundColor?.withAlphaComponent(0.2)
            }
        }.disposed(by: disposeBag)
    }
    
    private func bindErrorMessages() {
        viewModel.error.asObservable().subscribe { errorMessage in
            Helper.showErrorNotification(message: errorMessage)
        }.disposed(by: disposeBag)
    }
    
}
