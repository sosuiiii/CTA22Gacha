//
//  NSObject+.swift
//  GachaApp
//
//  Created by 化田晃平 on 2022/03/05.
//
import Foundation

extension NSObject {
    static var className: String {
        String(describing: self)
    }
}
