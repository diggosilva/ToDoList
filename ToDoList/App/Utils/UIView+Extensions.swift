//
//  UIView+Extensions.swift
//  ToDoList
//
//  Created by Diggo Silva on 26/02/25.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach({ addSubview($0) })
    }
}
