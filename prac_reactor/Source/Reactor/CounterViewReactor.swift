//
//  CounterViewReactor.swift
//  prac_reactor
//
//  Created by baegteun on 2021/10/26.
//

import ReactorKit
import RxSwift

class CounterViewReactor: Reactor{
    enum Action{
        case increase
        case decrease
    }
    
    
    enum Mutation{
        case increaseValue
        case decreaseValue
        case setLoading(Bool)
        case setAlertMessage(String)
    }
    
    // State is a current View State
    struct State{
        var value: Int
        var isLoading: Bool
        @Pulse var aleartMessage: String?
    }
    let initialState: State
    init(){
        self.initialState = State(value: 0, isLoading: false)
    }
    
    // Action -> Mutation
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .increase:
            return Observable.concat([
                Observable.just(Mutation.setLoading(true)),
                Observable.just(Mutation.increaseValue).delay(.milliseconds(500), scheduler: MainScheduler.instance),
                Observable.just(Mutation.setLoading(false)),
                Observable.just(Mutation.setAlertMessage("Increased"))
            ])
        case .decrease:
            return Observable.concat([
                Observable.just(Mutation.setLoading(true)),
                Observable.just(Mutation.decreaseValue).delay(.milliseconds(500), scheduler: MainScheduler.instance),
                Observable.just(Mutation.setLoading(false)),
                Observable.just(Mutation.setAlertMessage("Decreased"))
            ])
        }
    }
    
    
}
