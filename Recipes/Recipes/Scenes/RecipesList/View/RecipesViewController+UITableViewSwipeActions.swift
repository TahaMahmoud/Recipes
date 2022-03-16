//
//  RecipesViewController+UITableViewSwipeActions.swift
//  Recipes
//
//  Created by Taha on 16/03/2022.
//

import UIKit

extension RecipesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
            -> UISwipeActionsConfiguration? {
        
                let favouriteAction = UIContextualAction(style: .normal, title: nil) { [weak self] (_, _, completionHandler) in
                    self?.viewModel.didFavouriteItemAtIndexPath(indexPath)
                    completionHandler(true)
                }
                
                favouriteAction.backgroundColor = UIColor(named: "AccentColor")
                
                let currentCell = tableView.cellForRow(at: indexPath) as? RecipeTableViewCell

                favouriteAction.image = UIImage(systemName: (currentCell?.isFavourite ?? false) ? "heart.fill" : "heart")
                
                let configuration = UISwipeActionsConfiguration(actions: [favouriteAction])
                return configuration
    }

}
