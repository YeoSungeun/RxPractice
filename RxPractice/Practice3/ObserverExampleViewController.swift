//
//  ObserverExampleViewController.swift
//  RxPractice
//
//  Created by 여성은 on 8/1/24.
//

import UIKit
import RxSwift

class ObserverExampleViewController: UIViewController {
    
    let itemA = [3.3, 2.3, 2.5, 8.5, 2.1, 6.4]
    let itemB = [4.3, 2.3, 1.2, 7.3, 2.1, 1.6]
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setJust()
        setOf()
        setFrom()
        setTake()
    }
    func setJust() {
        Observable.just(itemA)
            .subscribe { value in
                print("just - \(value)")
            } onError: { error in
                print("just - error")
            } onCompleted: {
                print("just completed")
            } onDisposed: {
                print("just disposed")
            }
            .disposed(by: disposeBag)
    }
    func setOf() {
        Observable.of(itemA, itemB)
            .subscribe { value in
                print("of - \(value)")
            } onError: { error in
                print("of - error")
            } onCompleted: {
                print("of completed")
            } onDisposed: {
                print("of disposed")
            }
            .disposed(by: disposeBag)
    }
    func setFrom() {
        Observable.from(itemA)
            .subscribe { value in
                print("from - \(value)")
            } onError: { error in
                print("from - error")
            } onCompleted: {
                print("from completed")
            } onDisposed: {
                print("from disposed")
            }
            .disposed(by: disposeBag)
    }
    func setTake() {
        Observable.repeatElement("Jack")
            .take(5)
            .subscribe { value in
                print("repeat - \(value)")
            } onError: { error in
                print("repeat - error")
            } onCompleted: {
                print("repeat completed")
            } onDisposed: {
                print("repeat disposed")
            }
            .disposed(by: disposeBag)
    }
}
