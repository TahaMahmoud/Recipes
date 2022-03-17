//
//  RecipeDetailsViewController.swift
//  Recipes
//
//  Created by Taha on 15/03/2022.
//

import UIKit
import RxSwift
import Kingfisher

class RecipeDetailsViewController: UIViewController {

    private let disposeBag = DisposeBag()
    var viewModel: RecipeDetailsViewModel!
    
    @IBOutlet weak var recipeImage: CornerRadiusImage!
    
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeHeadline: UILabel!
    
    @IBOutlet weak var fats: UILabel!
    @IBOutlet weak var carbos: UILabel!
    @IBOutlet weak var fibers: UILabel!
    @IBOutlet weak var calories: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var proteins: UILabel!
    @IBOutlet weak var favorites: UILabel!

    @IBOutlet weak var descriptionText: UITextView!
    
    @IBOutlet weak var ingredients: UITextView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.prefersLargeTitles = false
        
        bindRecipeDetails()
        viewModel.viewDidLoad()
        
    }
    
    func bindRecipeDetails() {
        viewModel.recipeDetails.subscribe {[weak self] (recipeData) in
            self?.renderRecipe(recipeDataViewModel: recipeData.element)
        }.disposed(by: disposeBag)
    }
    
    func renderRecipe(recipeDataViewModel: RecipeDataViewModel?) {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(image:  UIImage(systemName:  recipeDataViewModel?.isFavourited ?? false ? "heart.fill" : "heart" ), style: .done, target: self, action: #selector(favouritePressed))
        
        guard let imageURL = URL(string: recipeDataViewModel?.recipeImage ?? "") else {return}

        title = recipeDataViewModel?.recipeName

        recipeImage.kf.setImage(with: imageURL)

        recipeName.text = recipeDataViewModel?.recipeName
        recipeHeadline.text = recipeDataViewModel?.recipeHeadline
        
        fats.text = recipeDataViewModel?.fats
        carbos.text = recipeDataViewModel?.carbos
        fibers.text = recipeDataViewModel?.fibers
        calories.text = recipeDataViewModel?.calories
        time.text = recipeDataViewModel?.time
        proteins.text = recipeDataViewModel?.proteins
        favorites.text = recipeDataViewModel?.favorites

        descriptionText.text = recipeDataViewModel?.descriptionText
        ingredients.text = recipeDataViewModel?.ingredients

    }
    
    @objc func favouritePressed(sender: AnyObject) {
        viewModel.favourite()
    }
    
}
