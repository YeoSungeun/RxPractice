//
//  SampleSwitchViewContorller.swift
//  RxPractice
//
//  Created by 여성은 on 8/1/24.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

class SampleSwitchViewContorller: UIViewController {
    let simpleSwitch = UISwitch()
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setSwitch()
    }
    func setView() {
        view.backgroundColor = .systemBackground
        view.addSubview(simpleSwitch)

        simpleSwitch.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(44)
        }
        simpleSwitch.backgroundColor = .systemBlue
    }
    func setSwitch() {
        Observable.of(false)
            .bind(to: simpleSwitch.rx.isOn)
            .disposed(by: disposeBag)
    }

}
