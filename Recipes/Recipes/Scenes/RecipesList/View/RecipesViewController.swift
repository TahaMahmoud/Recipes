//
//  RecipesViewController.swift
//  Recipes
//
//  Created by Taha on 14/03/2022.
//

import UIKit
import RxSwift

class RecipesViewController: UIViewController {

    private let disposeBag = DisposeBag()
    var viewModel: RecipesViewModel!

    @IBOutlet weak var recipesTableView: UITableView!
    
    @IBOutlet weak var indicator: BPCircleActivityIndicator!
    
    let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        bindIndicator()
        bindErrorMessage()
        
        viewModel.viewDidLoad()
        bindTableView()

        refreshControl.tintColor = .white
        if #available(iOS 10.0, *) {
            recipesTableView.refreshControl = refreshControl
        } else {
            recipesTableView.addSubview(refreshControl)
        }

        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
    }
    
    @objc private func refresh(_ sender: Any) {
        viewModel.viewDidLoad()
        refreshControl.endRefreshing()
    }

    
    func bindIndicator() {
        viewModel.indicator.subscribe { [weak self] status in
            status ? self?.showIndicator() : self?.hideIndicator()
        }.disposed(by: disposeBag)
    }
    
    func bindErrorMessage() {
        viewModel.error.subscribe { message in
            Helper.showErrorNotification(message: message)
        }.disposed(by: disposeBag)
    }

    
    func setupTableView() {
        recipesTableView.registerCellNib(cellClass: RecipeTableViewCell.self)
    }

    fileprivate func bindTableView() {
        viewModel.recipes
            .bind(to: recipesTableView.rx.items(
                    cellIdentifier: "RecipeTableViewCell",
                    cellType: RecipeTableViewCell.self)) { row, element, cell in
                let indexPath = IndexPath(row: row, section: 0)
                cell.configure(self.viewModel.recipeViewModelAtIndexPath(indexPath))
            }
            .disposed(by: disposeBag)
        
        
        recipesTableView.rx.itemSelected.subscribe {[weak self]  (indexPath) in
            guard let indexPath = indexPath.element else { return }
            self?.viewModel.didSelectItemAtIndexPath(indexPath)
        }.disposed(by: disposeBag)
     
    }

    func showIndicator() {
        indicator.isHidden = false
        indicator.animate()
    }
        
    func hideIndicator() {
        indicator.isHidden = true
        indicator.stop()
    }

}
