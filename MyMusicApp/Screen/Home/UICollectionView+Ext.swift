//
//  UICollectionView+Ext.swift
//  MyMusicApp
//
//  Created by Borisov Nikita on 22.06.2023.
//

import Foundation

import UIKit

extension UITableView {
    func animateTableView() {
        self.reloadData()
        
        let cells = self.visibleCells
        let tableViewHight = self.bounds.height
        
        var delay: Double = 0
        
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHight)
            
            UIView.animate(
                withDuration: 0.6,
                delay: delay * 0.05,
                usingSpringWithDamping: 0.8,
                initialSpringVelocity: 0,
                options: .curveEaseInOut
            ) {
                    cell.transform = CGAffineTransform.identity
            }
            
            delay += 1
        }
    }
}
