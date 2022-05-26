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
    
    //　nameSubjectが外部に値を渡すために設けた窓口のイメージ
    var name: Observable<String> {
        return nameSubject
    }
    
    var statue: Observable<Bool> {
        return statueSubject
    }
    
    private let statueSubject = PublishSubject<Bool>()
    
    // カプセル化、このクラスのみで使用可能にする
    private let nameSubject = PublishSubject<String>()
    
    enum statue {
        case on
        case off
    }
    
    private var mine: statue = .off
    
    func set(text: String) {
        titleSubject.onNext(text)
    }
    
    func setting(tap: Void) {
        if mine == .off {
            mine = .on
            print("onになったよ")
            statueSubject.onNext(true)
        } else {
            mine = .off
            print("offになったよ")
            statueSubject.onNext(false)
        }
    }
    
    func getUserName(name: String) {
        print("name\(name)")
        titleSubject.onNext(name)
    }
}

