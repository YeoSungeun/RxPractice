//
//  SampleButtonViewController.swift
//  RxPractice
//
//  Created by 여성은 on 8/1/24.
//
import UIKit
import RxCocoa
import RxSwift
import SnapKit

class SampleButtonViewController: UIViewController {
    let signName = UITextField()
    let signEmail = UITextField()
    let signButton = UIButton()
    let simpleLabel = UILabel()
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setSign()
    }
    func setView() {
        view.backgroundColor = .systemBackground
        view.addSubview(simpleLabel)
        view.addSubview(signName)
        view.addSubview(signEmail)
        view.addSubview(signButton)
   
        simpleLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(44)
        }
        signName.snp.makeConstraints { make in
            make.top.equalTo(simpleLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(44)
        }
        signEmail.snp.makeConstraints { make in
            make.top.equalTo(signName.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(44)
        }
        signButton.snp.makeConstraints { make in
            make.top.equalTo(signEmail.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(44)
        }
        
        
        signName.backgroundColor = .systemBlue
        signEmail.backgroundColor = .systemCyan
        signButton.backgroundColor = .systemYellow
        simpleLabel.backgroundColor = .systemGray
    }
    func setSign() {
        Observable.combineLatest(signName.rx.text.orEmpty, signEmail.rx.text.orEmpty) { value1, value2 in
            return "이름은 \(value1)이고, 이메일은 \(value2)입니다"
        }
        .bind(to: simpleLabel.rx.text)
        .disposed(by: disposeBag)
        
        signName.rx.text.orEmpty
            .map { $0.count < 4 }
            .bind(to: signEmail.rx.isHidden, signButton.rx.isHidden)
            .disposed(by: disposeBag)
        signEmail.rx.text.orEmpty
            .map { $0.count > 4 }
            .bind(to: signButton.rx.isEnabled)
            .disposed(by: disposeBag)
        signButton.rx.tap
            .subscribe { _ in
//                self.showAlert()
            }
            .disposed(by: disposeBag)
    }

}
