//
//  AddingNumbersViewController.swift
//  RxPractice
//
//  Created by 여성은 on 8/1/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class AddingNumbersViewController: UIViewController {
    let number1TextField = UITextField()
    let number2TextField = UITextField()
    let number3TextField = UITextField()
    let plusLabel = UILabel()
    let resultLabel = UILabel()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        calculateNums()
    }
    func setView() {
        view.backgroundColor = .systemBackground
        view.addSubview(number1TextField)
        view.addSubview(number2TextField)
        view.addSubview(number3TextField)
        view.addSubview(plusLabel)
        view.addSubview(resultLabel)
        
        number1TextField.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(100)
            make.height.equalTo(44)
        }
        number2TextField.snp.makeConstraints { make in
            make.top.equalTo(number1TextField.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(100)
            make.height.equalTo(44)
        }
        number3TextField.snp.makeConstraints { make in
            make.top.equalTo(number2TextField.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(100)
            make.height.equalTo(44)
        }
        plusLabel.snp.makeConstraints { make in
            make.trailing.equalTo(number3TextField.snp.leading).offset(8)
            make.size.equalTo(44)
        }
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(number3TextField.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(100)
            make.height.equalTo(44)
        }
        number1TextField.layer.borderColor = UIColor.lightGray.cgColor
        number1TextField.layer.borderWidth = 1
        number2TextField.layer.borderColor = UIColor.lightGray.cgColor
        number2TextField.layer.borderWidth = 1
        number3TextField.layer.borderColor = UIColor.lightGray.cgColor
        number3TextField.layer.borderWidth = 1
        number1TextField.textAlignment = .right
        number2TextField.textAlignment = .right
        number3TextField.textAlignment = .right
        resultLabel.textAlignment = .right
        resultLabel.backgroundColor = .systemYellow
        plusLabel.text = "+"
    }
    func calculateNums() {
        Observable.combineLatest(number1TextField.rx.text.orEmpty, number2TextField.rx.text.orEmpty, number3TextField.rx.text.orEmpty) { value1, value2, value3 -> Int in
            return ((Int(value1)) ?? 0) + ((Int(value2)) ?? 0) + ((Int(value3)) ?? 0)
        }
        .map { $0.description }
        .bind(to: resultLabel.rx.text)
        .disposed(by: disposeBag)
    }
    
}
