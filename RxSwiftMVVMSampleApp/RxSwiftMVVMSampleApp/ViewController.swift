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
    @IBOutlet weak var samplePasswordTextField: UITextField!
    @IBOutlet weak var sampleButton: UIButton!
    
    // 購読の監視
    private var disposeBag: DisposeBag = DisposeBag()
    // model
//    var model: ModelProtocol
    // viewModel
    var viewModel: ViewModelType!
    var viewModel2: ViewModel2 = ViewModel2()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        sampleOne()
        
//        sampleTwo()
        
//        sampleThree()
        
//        sampleFour()
        
//        sampleFive()
        
//        sampleSix()
        
//        sampleSeven()
        
//        sampleEight()
        
//        sampleNine()
        
//        sampleTen()
        
//        sampleEleven()
        
//        sampleTwelve()
        
        sampleThirteen()
        

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
    
    func sampleTwo() {
        // 非監視者
        var textFieldOvservable = sampleTextField.rx.text.asObservable()
        var labelOvservable = sampleLabel.rx.text.asObserver()

        
        textFieldOvservable.subscribe { text in
            print("text: \(text)")
            
        }.disposed(by: disposeBag)
    }
    
    func sampleThree() {
        // 非監視者
        var textFieldOvservable = sampleTextField.rx.text.asObservable()
        var labelOvservable = sampleLabel.rx.text.asObserver()

        
        textFieldOvservable.subscribe { text in
            // ただ代入したい時はrx不必要？
            self.sampleLabel.text = text
            
        }.disposed(by: disposeBag)
    }
    
    private let subject = PublishSubject<String>()
    public var observable: Observable<String> {
        return subject.asObserver()
    }
    
    func sampleFour() {
        subject.onNext(sampleTextField.text!)
//        subject.onCompleted()
        
        observable.subscribe { event in
            print("event: \(event)")
        } onCompleted: {
            print("onCompleted")
       
        }

        
    }
    
    func sampleFive() {
        sampleTextField.rx.text.subscribe(onNext: { [weak self] text in
            self?.sampleLabel.text = text
        }).disposed(by: disposeBag)
    }
    
    func sampleSix() {
        let userNameValid = sampleTextField.rx.text
            .map { text -> Bool in
                print("validation")
                
                return text!.count >= 1
            }
        
        // userNameValidの動きに対応させたいものをbind(to:)にかく
        userNameValid.bind(to: sampleLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        userNameValid.bind(to: sampleButton.rx.isHidden)
            .disposed(by: disposeBag)
    }
    
    func sampleSeven() {
        viewModel = ViewModel(model: Model())
        
        sampleTextField.rx.text.orEmpty
            .bind(to: viewModel.inputs.email)
            .disposed(by: disposeBag)
        
        samplePasswordTextField.rx.text.orEmpty
            .bind(to: viewModel.inputs.password)
            .disposed(by: disposeBag)
        
        viewModel.outputs.isSignUpButtonEnabled.drive(sampleButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        
        // input
//        sampleButton.rx.tap.asSignal()
//            .emit(to: viewModel.inputs.tap)
//            .disposed(by: disposeBag)
        
        // output
//        sampleButton.rx.tap.asSignal()
//            .asDriver(onErrorDriveWith: sampleLabel.rx.isEnabled)
//            .disposed(by: disposeBag)
    }
    
    func sampleEight() {
    
        var labelObservable = sampleTextField.rx.text.orEmpty.asObserver()
        var buttonObservable = sampleButton.rx.tap.asObservable()
        
        buttonObservable.subscribe { [weak self] in
            print("ok")
            self!.sampleLabel.text = "ok"
        }
        
//        sampleButton.isHidden = true
//        labelObservable.onNext("a")
        
//        labelObservable.subscribe { [weak self] in
//            print("text: \(text)")
//            if text.count >= 4 {
//
//            }
//        }
//
        
        
    }
    
    func sampleNine() {
        // textFieldを購読
        //　sampleTextFieldのテキストを監視
        // sampleLabelが購読
        // ストリームがsampleTextFieldのテキスト
        sampleTextField.rx.text.bind(to: sampleLabel.rx.text)
            .disposed(by: disposeBag)
        
    }
    
    func sampleTen() {
        sampleTextField.rx.text.subscribe { [weak self] text in
            self!.sampleLabel.text = text
        }
        .disposed(by: disposeBag)

    }
    
    func sampleEleven() {
        // bindを行う
        sampleTextField.rx.text.orEmpty.asObservable()
            .subscribe { [weak self] in
                // viewModelに値の変更を通知
                guard let self = self else { return }
                guard let value = $0.element else  { return }
                self.viewModel2.set(text: value)
            }
            .disposed(by: disposeBag)
        
        viewModel2.title.asObservable()
            .subscribe { [weak self] in
                // viewModelの更新を受け取る
                guard let self = self else { return }
                self.sampleLabel.text = $0.element
            }
            .disposed(by: disposeBag)
    }
    
    func sampleTwelve() {
        // buttonのタップのbindを行う
        sampleButton.rx.tap.asObservable()
            .subscribe { [weak self] event in
                // viewModel2にタップを通知
                guard let self = self else { return }
//                guard let tap = $0.self else { return }
                self.viewModel2.setting(tap: event.element!)
            }
            .disposed(by: disposeBag)
        
        viewModel2.title.asObservable()
            .subscribe { [weak self] in
                // viewModel2の更新を受け取る
                guard let self = self else { return }
                self.sampleLabel.text = $0.element
            }
            .disposed(by: disposeBag)

    }
    
    func sampleThirteen() {
        // 初期化
        sampleLabel.text = "No Neme"
        
        // input
        // bainndを行う
        sampleTextField.rx.text.orEmpty.asObservable()
            .subscribe { [weak self] in
                guard let self = self else { return }
                guard let value = $0.element else { return }
                self.viewModel2.set(text: value)
            }
            .disposed(by: disposeBag)
        
        sampleButton.rx.tap.asObservable()
            .subscribe { [weak self] in
                guard let self = self else { return }
                self.viewModel2.setting(tap: $0.element!)
            }
            .disposed(by: disposeBag)
        
        // output
        viewModel2.statue.asObservable()
            .subscribe { [weak self] in
                guard let self = self else { return }
                
                if $0.element! {
                    self.sampleButton.backgroundColor = .red
                } else {
                    self.sampleButton.backgroundColor = .blue
                }
            }
            .disposed(by: disposeBag)
        

    }
    
    
}

