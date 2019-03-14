//
//  Signal+Extension.swift
//  RACMVVMDemo
//
//  Created by yang on 2019/3/14.
//  Copyright © 2019 xdyang. All rights reserved.
//

import ReactiveSwift

extension Signal {
    func mapToEmpty() -> Signal<(), Error> {
        return map { _ in }
    }
}

extension SignalProducer {
    func mapToEmpty() -> SignalProducer<(), Error> {
        return map { _ in }
    }
}

extension PropertyProtocol {
    func mapToEmpty() -> Property<()> {
        return map { _ in }
    }
}
