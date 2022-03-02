//
//  ChangeSortTypeViewController.swift
//  Coins
//
//  Created by eyup cimen on 27.02.2022.
//

import UIKit

class ChangeSortTypeViewController: UIViewController {

    var delegate: SelectSortTypeProtocol?
    let sortList: [SortType] = [.volume24, .price, .marketCap,.change]
    var topConstraint : CGFloat = 0.0
    var widthhConstraint : CGFloat = 0.0
    @IBOutlet weak var tableViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView! {
        didSet{
            tableView.registerClass(cellClass: SortTableViewCell.self)
            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = 25.0
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.tableViewTopConstraint.constant = self.topConstraint
            self.tableViewWidthConstraint.constant = self.widthhConstraint
            self.tableView.reloadData()
        }
    }
    
    @IBAction func closeAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension ChangeSortTypeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SortTableViewCell", for: indexPath) as! SortTableViewCell
        cell.titleLabel.text = sortList[indexPath.row].rawValue
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

}

extension ChangeSortTypeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = sortList[indexPath.row]
        guard let delegate = delegate else {
            return
        }
        delegate.selectSortType(sortType: item)
        self.dismiss(animated: true, completion: nil)
    }
}
