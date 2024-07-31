//
//  SimpleTableViewController.swift
//  RxPractice
//
//  Created by 여성은 on 8/1/24.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

class SimpleTableViewController: UIViewController {
    let simpleTableView = UITableView()
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setTableView()
    }
    func setView() {
        view.backgroundColor = .systemBackground
        view.addSubview(simpleTableView)

        simpleTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        simpleTableView.backgroundColor = .systemYellow
    }
    func setTableView() {
        simpleTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        let items = Observable.just(
            (0..<20).map { "\($0)" }
        )

        items
            .bind(to: simpleTableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { (row, element, cell) in
                cell.textLabel?.text = "\(element) @row \(row)"
            }
            .disposed(by: disposeBag)


        simpleTableView.rx
            .modelSelected(String.self)
            .subscribe(onNext:  { value in
                self.showAlert(title: "\(value)")
            })
            .disposed(by: disposeBag)

        simpleTableView.rx
            .itemAccessoryButtonTapped
            .subscribe(onNext: { indexPath in
                self.showAlert(title: "Tapped Detail @ \(indexPath.section),\(indexPath.row)")
            })
            .disposed(by: disposeBag)

    }
    func showAlert(title: String) {
        
        let alert = UIAlertController(
            title: title,
            message: nil,
            preferredStyle: .alert)
        
        let open = UIAlertAction(title: "확인", style: .default)
        
        alert.addAction(open)
        
        present(alert, animated: true)
    }
   
    
}



