//
//  SDWebImage+Signal.swift
//  RACMVVMDemo
//
//  Created by yang on 2019/3/14.
//  Copyright © 2019 xdyang. All rights reserved.
//


import UIKit
import SDWebImage
import ReactiveSwift
import Result

extension Signal where Value == URL? {
    func mapToImageLoad(_ defaultImage: UIImage? = nil) -> Signal<UIImage?, Error> {
        return flatMap(.latest, { (url) -> SignalProducer<UIImage?, Error> in
            guard let url = url else {
                return SignalProducer<UIImage?, Error>(value: nil)
            }
            return SignalProducer<UIImage?, Error>({ (observer, lifetime) in
                if let image = defaultImage {
                    observer.send(value: image)
                }
                let operation = SDWebImageManager.shared().loadImage(with: url, options: [], progress: nil, completed: { (image, _, _, _, _, _) in
                    observer.send(value: image)
                    observer.sendCompleted()
                })
                lifetime.observeEnded {
                    operation?.cancel()
                }
            })
        })
    }
}

extension Signal where Value == URL {
    func mapToImageLoad(_ defaultImage: UIImage? = nil) -> Signal<UIImage?, Error> {
        return flatMap(.latest, { (url) -> SignalProducer<UIImage?, Error> in
            return SignalProducer<UIImage?, Error>({ (observer, lifetime) in
                if let image = defaultImage {
                    observer.send(value: image)
                }
                let operation = SDWebImageManager.shared().loadImage(with: url, options: [], progress: nil, completed: { (image, _, _, _, _, _) in
                    observer.send(value: image)
                    observer.sendCompleted()
                })
                lifetime.observeEnded {
                    operation?.cancel()
                }
            })
        })
    }
}

extension SignalProducer where Value == URL? {
    func mapToImageLoad(_ defaultImage: UIImage? = nil) -> SignalProducer<UIImage?, Error> {
        return flatMap(.latest, { (url) -> SignalProducer<UIImage?, NoError> in
            guard let url = url else {
                return SignalProducer<UIImage?, NoError>(value: nil)
            }
            return SignalProducer<UIImage?, NoError>({ (observer, lifetime) in
                if let image = defaultImage {
                    observer.send(value: image)
                }
                let operation = SDWebImageManager.shared().loadImage(with: url, options: [], progress: nil, completed: { (image, _, _, _, _, _) in
                    observer.send(value: image)
                    observer.sendCompleted()
                })
                lifetime.observeEnded {
                    operation?.cancel()
                }
            })
        })
    }
}

extension SignalProducer where Value == URL {
    func mapToImageLoad(_ defaultImage: UIImage? = nil) -> SignalProducer<UIImage?, Error> {
        return flatMap(.latest, { (url) -> SignalProducer<UIImage?, NoError> in
            return SignalProducer<UIImage?, NoError>({ (observer, lifetime) in
                if let image = defaultImage {
                    observer.send(value: image)
                }
                let operation = SDWebImageManager.shared().loadImage(with: url, options: [], progress: nil, completed: { (image, _, _, _, _, _) in
                    observer.send(value: image)
                    observer.sendCompleted()
                })
                lifetime.observeEnded {
                    operation?.cancel()
                }
            })
        })
    }
}
