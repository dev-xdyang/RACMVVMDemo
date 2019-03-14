//
//  ListViewModable.swift
//  RACMVVMDemo
//
//  Created by yang on 2019/3/14.
//  Copyright © 2019 xdyang. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result

public enum ListActionType {
    case reload
    case insert([IndexPath])
    case delete([IndexPath])
    case update([IndexPath])
}

public protocol ListViewModable {
    associatedtype ItemViewModel

    var listViewModel: MutableProperty<[ItemViewModel]> { get }
    var listActionSignal: Signal<(ListActionType), NoError> { get }
    var listActionObserver: Signal<(ListActionType), NoError>.Observer { get }
}

public extension ListViewModable {
    public var listReloadSignal: Signal<(), NoError> {
        return listActionSignal.filter {
            if case .reload = $0 {
                return true
            } else {
                return false
            }
            }.map { _ in}
    }

    public var listInsertSignal: Signal<[IndexPath], NoError> {
        return listActionSignal.filter {
            if case .insert = $0 {
                return true
            } else {
                return false
            }
            }.map { (action) in
                if case .insert(let indexPaths) = action {
                    return indexPaths
                } else {
                    return []
                }
        }
    }

    public var listDeleteSignal: Signal<[IndexPath], NoError> {
        return listActionSignal.filter {
            if case .delete = $0 {
                return true
            } else {
                return false
            }
            }.map { (action) in
                if case .delete(let indexPaths) = action {
                    return indexPaths
                } else {
                    return []
                }
        }
    }

    public var listUpdateSignal: Signal<[IndexPath], NoError> {
        return listActionSignal.filter {
            if case .update = $0 {
                return true
            } else {
                return false
            }
            }.map { (action) in
                if case .update(let indexPaths) = action {
                    return indexPaths
                } else {
                    return []
                }
        }
    }
}

public extension ListViewModable {
    public func listInsert(item: ItemViewModel, at indexPath: IndexPath) {
        var list = listViewModel.value
        list.insert(item, at: indexPath.row)
        listViewModel.value = list
        listActionObserver.send(value: .insert([indexPath]))
    }

    public func listDelete(at indexPath: IndexPath) {
        var list = listViewModel.value
        list.remove(at: indexPath.row)
        listViewModel.value = list
        listActionObserver.send(value: .delete([indexPath]))
    }

    public func listUpdate(item: ItemViewModel, at indexPath: IndexPath) {
        var list = listViewModel.value
        list.replaceSubrange(indexPath.row..<(indexPath.row + 1), with: [item])
        listViewModel.value = list
        listActionObserver.send(value: .update([indexPath]))
    }

    public func listAppend(_ items: [ItemViewModel]) {
        var list = listViewModel.value
        list += items
        listViewModel.value = list
        listActionObserver.send(value: .reload)
    }

    public func listReplace(_ items: [ItemViewModel]) {
        listViewModel.value = items
        listActionObserver.send(value: .reload)
    }
}
