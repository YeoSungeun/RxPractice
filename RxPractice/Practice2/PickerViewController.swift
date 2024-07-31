//
//  PickerViewController.swift
//  RxPractice
//
//  Created by 여성은 on 8/1/24.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

class PickerViewController: UIViewController {
    let simplePickerView = UIPickerView()
    let simpleLabel = UILabel()
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setPickerView()
    }
    func setView() {
        view.backgroundColor = .systemBackground
        view.addSubview(simplePickerView)
        view.addSubview(simpleLabel)
        
        simplePickerView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(44)
        }
        simpleLabel.snp.makeConstraints { make in
            make.top.equalTo(simplePickerView.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(44)
        }
        simplePickerView.backgroundColor = .systemYellow
        simpleLabel.backgroundColor = .systemBlue
    }
    func setPickerView() {
        let items = Observable.just([
            "영화",
            "드라마",
            "애니메이션",
            "기타"
        ])
        items
            .bind(to: simplePickerView.rx.itemTitles) { (row, elemnet) in
                return elemnet
            }
            .disposed(by: disposeBag)
        
        simplePickerView.rx.modelSelected(String.self)
            .map{ $0.description }
            .bind(to: simpleLabel.rx.text)
            .disposed(by: disposeBag)
    }
   
    
}

