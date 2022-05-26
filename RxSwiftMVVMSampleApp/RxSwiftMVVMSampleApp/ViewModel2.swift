//
//  Model2.swift
//  RxSwiftMVVMSampleApp
//
//  Created by Oh!ara on 2022/05/27.
//

import Foundation
import RxSwift
import RxCocoa

class ViewModel2 {
    var title: Observable<String> {
        return titleSubject
    }
    
    private let titleSubject = PublishSubject<String>()
    
    var tapped: Observable<Bool> {
        return tapSubject
    }
    
    private let tapSubject = PublishSubject<Bool>()
    
    func set(text: String) {
        titleSubject.onNext(text)
    }
    
    func setting(tap: Void) {
        print("okok")
        titleSubject.onNext("五条悟")
    }
}

