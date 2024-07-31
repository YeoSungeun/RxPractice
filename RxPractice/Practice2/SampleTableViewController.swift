//
//  SampleTableViewController.swift
//  RxPractice
//
//  Created by 여성은 on 8/1/24.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

class SampleTableViewController: UIViewController {
    let simpleTableView = UITableView()
    let simpleLabel = UILabel()
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setTableView()
    }
    func setView() {
        view.backgroundColor = .systemBackground
        view.addSubview(simpleLabel)
        view.addSubview(simpleTableView)
        

        simpleLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(44)
        }
        simpleTableView.snp.makeConstraints { make in
            make.top.equalTo(simpleLabel.snp.bottom).offset(20)
            make.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        simpleTableView.backgroundColor = .systemYellow
        simpleLabel.backgroundColor = .systemBlue
    }
    func setTableView() {
        simpleTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        let items = Observable.just([
            "First Item",
            "Second Item",
            "Third Item"
        ])
        items
            .bind(to: simpleTableView.rx.items) { (tableView, row, element) in
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
                cell.textLabel?.text = "\(element) @ row \(row)"
                
                return cell
            }
            .disposed(by: disposeBag)
        
        simpleTableView.rx.modelSelected(String.self)
            .map{ data in
                "\(data)를 클릭했습니다."
            }
            .bind(to: simpleLabel.rx.text)
            .disposed(by: disposeBag)
    }
   
   
    
}
