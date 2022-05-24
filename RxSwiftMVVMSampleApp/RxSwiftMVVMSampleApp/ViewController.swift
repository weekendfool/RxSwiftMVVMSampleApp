//
//  ViewController.swift
//  RxSwiftMVVMSampleApp
//
//  Created by Oh!ara on 2022/05/24.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var sampleTextField: UITextField!
    @IBOutlet weak var sampleLabel: UILabel!
    @IBOutlet weak var sampleButton: UIButton!
    
    // 購読の監視
    private var disposeBag: DisposeBag = DisposeBag()
    // model
//    var model: ModelProtocol
    // viewModel
    lazy var viewModel: ViewModel = ViewModel(model: Model())
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        sampleOne()
    }


    // textFieldの文字を即時labelに反映
    func sampleOne() {
        // 非監視者
//        var textFieldOvservable: BehaviorRelay<String?> = BehaviorRelay(value: "")
//        var labelOvservable: BehaviorRelay<String?> = BehaviorRelay(value: "label")
//
//        // 監視者
//        textFieldOvservable.subscribe { [weak self] text in
////            sampleLabel.rx.text.orEmpty = text
//        }
//
//        labelOvservable.bind(to: sampleLabel.rx.text).disposed(by: disposeBag)
        sampleTextField.rx.text.orEmpty.bind(to: sampleLabel.rx.text).disposed(by: disposeBag)

    }
}

