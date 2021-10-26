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
import RxSwift
import RxCocoa

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
        super.configureVC()
        addView()
        setLayout()
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
            $0.right.equalTo(valueLabel.snp.left).offset(-20)
        }
        decreaseButton.snp.makeConstraints {
            $0.top.equalTo(valueLabel.snp.bottom).offset(10)
            $0.left.equalTo(valueLabel.snp.right).offset(20)
        }
        
        activityBar.center = self.view.center 
    }
    func bind(reactor: CounterViewReactor) {
        increaseButton.rx.tap
            .map{Reactor.Action.increase}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        decreaseButton.rx.tap
            .map{Reactor.Action.decrease}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state
            .map{$0.value}
            .distinctUntilChanged()
            .map{ "\($0)"}
            .bind(to: valueLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state
            .map{$0.isLoading}
            .distinctUntilChanged()
            .bind(to: activityBar.rx.isAnimating)
            .disposed(by: disposeBag)
        
        reactor.pulse(\.$aleartMessage)
            .compactMap{ $0 }
            .subscribe(onNext: { [weak self] text in
                let alert = UIAlertController(title: nil, message: text, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self?.present(alert, animated: true)
            })
            .disposed(by: disposeBag)
    }
}
