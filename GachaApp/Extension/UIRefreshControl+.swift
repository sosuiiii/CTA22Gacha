//
//  UIRefreshControl+.swift
//  GachaApp
//
//  Created by 化田晃平 on R 3/03/05.
//

import RxSwift
import UIKit

extension Reactive where Base: UIRefreshControl {
    var endRefreshing: Binder<Void> {
        Binder(self.base) { base, _ in
            if base.isRefreshing {
                base.endRefreshing()
            }
        }
    }
}

