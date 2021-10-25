//
//  CounterVC.swift
//  prac_reactor
//
//  Created by baegteun on 2021/10/26.
//

import UIKit
import Then
import SnapKit
import ReactorKit

class CounterVC: baseVC, View{
    // MARK: - Properties
    private let valueLabel = UILabel().then {
        $0.text = "0"
        $0.font = .systemFont(ofSize: 30)
    }
    
    private let increaseButton = UIButton().then {
        $0.setTitle("Plus", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 20)
    }
    
    private let decreaseButton = UIButton().then {
        $0.setTitle("Minus", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 20)
    }
    
    private let activityBar = UIActivityIndicatorView().then {
        $0.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        $0.color = .gray
        $0.hidesWhenStopped = true
        $0.style = UIActivityIndicatorView.Style.large
    }
    
    var disposeBag: DisposeBag = .init()
    
    // MARK: - Helpers
    override func configureVC() {
        
    }
    private func addView(){
        [valueLabel, increaseButton, decreaseButton, activityBar].forEach{view.addSubview($0)}
    }
    private func setLayout(){
        valueLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        increaseButton.snp.makeConstraints {
            $0.top.equalTo(valueLabel.snp.bottom).offset(10)
            $0.right.equalTo(valueLabel.snp.left).inset(20)
        }
        decreaseButton.snp.makeConstraints {
            $0.top.equalTo(valueLabel.snp.bottom).offset(10)
            $0.left.equalTo(valueLabel.snp.right).offset(20)
        }
    }
    func bind(reactor: CounterViewReactor) {
        
    }
}
