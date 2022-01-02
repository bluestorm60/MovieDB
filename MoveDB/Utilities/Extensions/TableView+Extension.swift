//
//  File.swift
//  NewsTest
//
//  Created by Ahmed Shafik on 03/10/2021.
//

import Foundation
import UIKit

extension UITableView
{
    func registerNib<T: UITableViewCell>(_ cellClass: T.Type, bundle: Bundle? = nil){
        let identifier = String(describing: T.self)
        self.register(UINib(nibName: identifier, bundle: bundle), forCellReuseIdentifier: identifier)
    }
    
    func registerNib<T: UITableViewHeaderFooterView>(_ cellClass: T.Type, bundle: Bundle? = nil){
        let identifier = String(describing: T.self)
        self.register(UINib(nibName: identifier, bundle: bundle), forHeaderFooterViewReuseIdentifier: identifier)
    }
    
    func registerClass<T: UITableViewCell>(_ cellClass: T.Type){
        let identifier = String(describing: T.self)
        self.register(T.self, forCellReuseIdentifier: identifier)
    }
    
    func registerClass<T: UITableViewHeaderFooterView>(_ cellClass: T.Type){
        let identifier = String(describing: T.self)
        self.register(T.self, forHeaderFooterViewReuseIdentifier: identifier)
    }
    
    func dequeue<T: UITableViewCell>(_ cellClass: T.Type, indexPath: IndexPath) -> T {
        let identifier = String(describing: T.self)
        guard let cell = self.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T else {
            fatalError("Error: cell with id: \(identifier) for indexPath: \(indexPath) is not \(T.self)")
        }
        return cell
    }
    
    func dequeue<T: UIView>(_ cellClass: T.Type) -> T {
        let identifier = String(describing: T.self)
        guard let view = self.dequeueReusableHeaderFooterView(withIdentifier: identifier) as? T else {
            fatalError("Error: view with id: \(identifier) is not \(T.self)")
        }
        return view
    }

    func snapshotRows(at indexPaths: Set<IndexPath>) -> UIImage?
    {
        guard !indexPaths.isEmpty else { return nil }
        var rect = self.rectForRow(at: indexPaths.first!)
        for indexPath in indexPaths
        {
            let cellRect = self.rectForRow(at: indexPath)
            rect = rect.union(cellRect)
        }
        
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        for indexPath in indexPaths
        {
            let cell = self.cellForRow(at: indexPath)
            cell?.layer.bounds.origin.y = self.rectForRow(at: indexPath).origin.y - rect.minY
            cell?.layer.render(in: context)
            cell?.layer.bounds.origin.y = 0
        }
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
