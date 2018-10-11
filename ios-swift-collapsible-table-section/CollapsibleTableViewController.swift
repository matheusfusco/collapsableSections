//
//  CollapsibleTableViewController.swift
//  ios-swift-collapsible-table-section
//
//  Created by Matheus Fusco on 11/10/18.
//  Copyright © 2018 Matheus Fusco. All rights reserved.
//


import UIKit

//
// MARK: - View Controller
//
class CollapsibleTableViewController: UITableViewController {
    
    var sections = sectionsData
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        
        self.title = "Termos e Condições"
    }
    
}

extension CollapsibleTableViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1//sections[section].collapsed ? 0 : 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CollapsibleTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CollapsibleTableViewCell ??
            CollapsibleTableViewCell(style: .default, reuseIdentifier: "cell")
        
        let terms = sections[indexPath.section].terms
        
        cell.isSectionCollapsed = sections[indexPath.section].collapsed
        cell.webView.loadHTMLString(terms, baseURL: nil)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let cell = tableView.cellForRow(at: indexPath) as? CollapsibleTableViewCell else {
            return 0
        }
        if sections[indexPath.section].collapsed {
            return 0
        } else {
            return cell.contentSize
        }
//        return UITableViewAutomaticDimension
    }
    
    // Header
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? CollapsibleTableViewHeader ?? CollapsibleTableViewHeader(reuseIdentifier: "header")
        
        header.titleLabel.text = sections[section].title
        header.arrowImageView.image = UIImage(named: "arrowDown")
        header.rotateArrow(sections[section].collapsed)
        
        header.section = section
        header.delegate = self
        
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80.0
    }
}

extension CollapsibleTableViewController: CollapsibleTableViewHeaderDelegate {
    
    func toggleSection(_ header: CollapsibleTableViewHeader, section: Int) {
        let isCollapsed = sections[section].collapsed
        
        sections[section].collapsed = !isCollapsed
        header.rotateArrow(!isCollapsed)
    
//        tableView.reloadSections(NSIndexSet(index: section) as IndexSet, with: .automatic)
        tableView.reloadRows(at: [IndexPath(row: 0, section: section)], with: .automatic)
        
//        if let cell = tableView.cellForRow(at: IndexPath(row: 0, section: section)) as? CollapsibleTableViewCell {
////            cell.isSectionExpanded = !sections[section].collapsed
////            cell.webView.alpha = cell.isSectionExpanded ? 1 : 0
//            cell.webView.loadHTMLString(sections[section].terms, baseURL: nil)
//            print("toggleSection \(cell.isSectionExpanded) - \(cell.webView.alpha)")
//        }
//        tableView.reloadRows(at: [IndexPath(row: 0, section: section)], with: .automatic)
    }
    
}
