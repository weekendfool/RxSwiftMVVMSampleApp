//
//  ViewModel.swift
//  RxSwiftMVVMSampleApp
//
//  Created by Oh!ara on 2022/05/24.
//

import Foundation
import RxSwift
import RxCocoa

protocol ViewModelInputs {
    var email: BehaviorRelay<String> { get }
    var password: BehaviorRelay<String> { get }
    
    var tap: PublishRelay<Void> { get }
}

protocol ViewModelOutputs {
    var isSignUpButtonEnabled: Driver<Bool> { get }
//    var resetTextField: Driver<String> { get }
}

protocol ViewModelType {
    var inputs: ViewModelInputs { get }
    var outputs: ViewModelOutputs { get }
}

class ViewModel: ViewModelType, ViewModelInputs, ViewModelOutputs {
    
    
    
    
    // MARK: - 変数
    var model: ModelProtocol
    
    var inputs: ViewModelInputs { return self }
    var outputs: ViewModelOutputs { return self }
    
    var count = 0
    
    // MARK: - inputs
    var email = BehaviorRelay<String>(value: "")
    var password = BehaviorRelay<String>(value: "")
    
    var tap: PublishRelay<Void>
    
    // MARK: - output
    var isSignUpButtonEnabled: Driver<Bool>
//    var resetTextField: Driver<String>
    
        
    // MARK: - 関数
    init(model: ModelProtocol) {
        
        self.model = model
        
        isSignUpButtonEnabled = Observable.combineLatest(email, password)
            .map({ (email, password) -> Bool in
                return model.isEnableEmail(email: email) && password.count > 5
            })
            .asDriver(onErrorDriveWith: .empty())
        
        // textField消去
//        resetTextField = Observable<String>
        
    }
    

}
