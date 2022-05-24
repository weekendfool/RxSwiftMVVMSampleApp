//
//  ViewModel.swift
//  RxSwiftMVVMSampleApp
//
//  Created by Oh!ara on 2022/05/24.
//

import Foundation
import RxSwift
import RxCocoa

class ViewModel {
    
    // MARK: - 変数
    
    var model: ModelProtocol
    
    private let disposeBag = DisposeBag()
    // MARK: - 関数
    
    init(model: ModelProtocol) {
        self.model = model
    }

}
