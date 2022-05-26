//
//  ViewModel.swift
//  RxSwiftMVVMSampleApp
//
//  Created by Oh!ara on 2022/05/24.
//

import Foundation
import RxSwift
import RxCocoa


// protocolを噛ませることでinputかoutputかの判別をしやすく
protocol ViewModelInputs {
    var email: BehaviorRelay<String> { get }
    var password: BehaviorRelay<String> { get }
    
//    var tap: Observable<Void> { get }
}

protocol ViewModelOutputs {
    var isSignUpButtonEnabled: Driver<Bool> { get }
//    var resetTextField: PublishSubject<Void> { get }
    
//    var reset: Driver<Bool> { get }
}

// ViewModelTypeを噛ませることでinputかoutputかの判別をしやすく
protocol ViewModelType {
    
    var inputs: ViewModelInputs { get }
    var outputs: ViewModelOutputs { get }
}

class ViewModel: ViewModelType, ViewModelInputs, ViewModelOutputs {
  
    // MARK: - 変数
    var model: ModelProtocol
    //　inputsは情報の受け取りだからobserver
    var inputs: ViewModelInputs { return self }
    //　outputsは情報を処理して発信側するからobservable
    var outputs: ViewModelOutputs { return self }
    
    
    // MARK: - inputs
    var email = BehaviorRelay<String>(value: "")
    var password = BehaviorRelay<String>(value: "")
    
//    var tap: Observable<Void>
    
    // MARK: - output
    var isSignUpButtonEnabled: Driver<Bool>
//    var resetTextField: PublishSubject<Void>
//    var reset: Driver<Bool>
   
        
    // MARK: - 関数
    init(model: ModelProtocol) {
        
        self.model = model
        
        isSignUpButtonEnabled = Observable.combineLatest(email, password)
            .map({ (email, password) -> Bool in
                return model.isEnableEmail(email: email) && password.count > 5
            })
            .asDriver(onErrorDriveWith: .empty())
        
//        reset = inputs.tap.subscribe
        
    }
    

}
