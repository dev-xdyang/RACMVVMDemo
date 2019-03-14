//
//  UITableView+Signal.swift
//  RACMVVMDemo
//
//  Created by yang on 2019/3/14.
//  Copyright © 2019 xdyang. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa
import Result

extension Reactive where Base: UITableView {
    var insert: BindingTarget<[IndexPath]> {
        return makeBindingTarget { (tableView, indexPaths) in
            tableView.insertRows(at: indexPaths, with: .automatic)
        }
    }

    var delete: BindingTarget<[IndexPath]> {
        return makeBindingTarget { (tableView, indexPaths) in
            tableView.deleteRows(at: indexPaths, with: .automatic)
        }
    }

    var update: BindingTarget<[IndexPath]> {
        return makeBindingTarget { (tableView, indexPaths) in
            tableView.reloadRows(at: indexPaths, with: .automatic)
        }
    }
}
