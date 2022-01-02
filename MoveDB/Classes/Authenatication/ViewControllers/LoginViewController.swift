//
//  LoginViewController.swift
//  MoveDB
//
//  Created by Ahmed Shafik on 01/01/2022.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    private let dispose = DisposeBag()
    private var viewModel: LoginViewModel!
    
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }


    //MARK: - App LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    //MARK: - Methods
    private func navigateToHome(){
        let viewModel = HomeViewModel(api: HomeServiceHandler())
        let vc = HomeViewController(viewModel: viewModel)
        self.navigationController?.setViewControllers([vc], animated: true)
    }
}


extension LoginViewController{
    func bindViewModel() {
        let outputs = viewModel.configure(input: LoginViewModel.Input(username: emailTextField.rx.text.orEmpty.asObservable(), password: password.rx.text.orEmpty.asObservable()))
        outputs.isLoginAllowed.drive(loginBtn.rx.isEnabled).disposed(by: dispose)
        loginBtn.rx.tap.throttle(.seconds(1), scheduler: MainScheduler.instance).bind {[weak self] in
            guard let self = self else {return}
            debugPrint("Submit")
            self.navigateToHome()
        }.disposed(by: dispose)
    }
}
