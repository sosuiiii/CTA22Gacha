//
//  UITableView+.swift
//  GachaApp
//
//  Created by 化田晃平 on 2022/03/05.
//
import UIKit

extension UITableView {
    func registerNib<T: UITableViewCell>(_ type: T.Type) {
        let nib = UINib(nibName: type.className, bundle: nil)
        register(nib, forCellReuseIdentifier: type.className)
    }

    func registerClass<T: UITableViewCell>(_ type: T.Type) {
        register(T.self, forCellReuseIdentifier: type.className)
    }

    func dequeue<T: UITableViewCell>(_ type: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: type.className, for: indexPath) as? T else {
            fatalError("Failed to dequeue cell")
        }
        return cell
    }
}
