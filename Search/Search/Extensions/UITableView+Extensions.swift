//
//  UITableView+Extensions.swift
//  Search
//
//  Created by Waqas Khan on 22/02/2023.
//

import Foundation
import UIKit

public extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        // swiftlint:disable:next force_cast
        return dequeueReusableCell(withIdentifier: type.className, for: indexPath) as! T
    }

    func dequeueReusableHeader<T: UITableViewHeaderFooterView>(with type: T.Type) -> T {
        // swiftlint:disable:next force_cast
        return dequeueReusableHeaderFooterView(withIdentifier: type.className) as! T
    }

    func register<T: UITableViewCell>(cellType: T.Type, bundle: Bundle? = nil) {
        let className = cellType.className
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forCellReuseIdentifier: className)
    }

    func register<T: UITableViewCell>(cellTypes: [T.Type], bundle: Bundle? = nil) {
        cellTypes.forEach { register(cellType: $0, bundle: bundle) }
    }

    func register<T: UITableViewHeaderFooterView>(headerType: T.Type, bundle: Bundle? = nil) {
        let className = headerType.className
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forHeaderFooterViewReuseIdentifier: className)
    }
}
