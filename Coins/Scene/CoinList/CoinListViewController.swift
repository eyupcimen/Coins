//
//  CoinListViewController.swift
//  Coins
//
//  Created by eyup cimen on 24.02.2022.
//

import UIKit

protocol CoinListDisplayLogic {
    func displayCoinList(viewModel: CoinListModel.SetUp.ViewModel?)
}

extension CoinListDisplayLogic { // If you use same protocol in the different view controller it's neccasary
    func displayCoinList(viewModel: CoinListModel.SetUp.ViewModel?) {}
}

class CoinListViewController: UIViewController {
    
    var headerView: HeaderView?
    var viewModel: CoinListModel.SetUp.ViewModel?
    var sortType : SortType = .volume24 {
        didSet{
            guard let headerView = headerView else {
                return
            }
            headerView.setSortTypeLabelText(title: self.sortType.rawValue)
        }
    }
    let imageStore = ImageStore()
    var interactor: (CoinListInteracting & CoinListDataStore)!
    var router: (CoinListRoutingLogic & CoinListDataPassing)?
    var displayCoins: [CoinListModel.SetUp.ViewModel.DisplayCoin] = []
    @IBOutlet weak var tableView: UITableView! {
        didSet{
            tableView.registerClass(cellClass: CoinListTableViewCell.self)
            tableView.registerHeaderClass(cellClass: HeaderView.self)
            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = 100.0
            tableView.sectionHeaderHeight = 50.0
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    private func setup() {
        let viewController = self
        let interactor = CoinListInteractor()
        let presenter = CoinListPresenter()
        let router = CoinListRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCoinList()
    }
    
    // MARK: Get Coin List
    func getCoinList() {
        let request = CoinListModel.SetUp.Request()
        interactor?.getCoinList(request: request)
    }
    
    func changeSortType(viewModel: CoinListModel.SetUp.ViewModel,sortType: SortType) {
        switch sortType {
        case .price:
            displayCoins = viewModel.displayCoins.sorted(by: { Double($0.price) ?? 0.0 > Double($1.price) ?? 0.0})
            break
        case .marketCap:
            displayCoins = viewModel.displayCoins.sorted(by: { Double($0.marketCap) ?? 0.0 > Double($1.marketCap) ?? 0.0})
            break
        case .volume24:
            displayCoins = viewModel.displayCoins.sorted(by: { Double($0.the24HVolume) ?? 0.0 > Double($1.the24HVolume) ?? 0.0})
            break
        case .change:
            displayCoins = viewModel.displayCoins.sorted(by: { Double($0.change) ?? 0.0 > Double($1.change) ?? 0.0})
            break
        }
        tableView.reloadData()
        self.sortType = sortType
    }
}

// MARK: Display Methods
extension CoinListViewController: CoinListDisplayLogic {
    
    func displayCoinList(viewModel: CoinListModel.SetUp.ViewModel?) {
        guard let viewModel = viewModel else {
            self.showAlert(title: "Warning", message: "Error occured !!!")
            return
        }
        self.viewModel = viewModel
        displayCoins = viewModel.displayCoins
        changeSortType(viewModel: viewModel, sortType: self.sortType)
    }
}

// MARK: Routing
extension CoinListViewController {
    func routeCoinDetail(selectedCoin: CoinListModel.SetUp.ViewModel.DisplayCoin) {
        self.router?.goToCoinDetailPage(seletedCoin: selectedCoin)
    }
}

extension CoinListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayCoins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoinListTableViewCell", for: indexPath) as! CoinListTableViewCell
        let item = displayCoins[indexPath.row]
        cell.imageStore = imageStore
        cell.viewModel = item
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {}
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderView") as! HeaderView
        headerView.delegate = self
        self.headerView = headerView
        return headerView
    }
}

extension CoinListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = displayCoins[indexPath.row]
        routeCoinDetail(selectedCoin: item)
    }
}

extension CoinListViewController: ChangeSortType {
    func changeSortTypeAction(sortType: SortType) {
        guard let headerView = headerView, let router = self.router else {
            return
        }
        router.changeSortType(headerView: headerView)
    }
}

extension CoinListViewController: SelectSortTypeProtocol {
    func selectSortType(sortType: SortType) {
        guard let viewModel = self.viewModel else {
            return
        }
        changeSortType(viewModel: viewModel , sortType: sortType)
    }
}
