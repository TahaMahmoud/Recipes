# Recipes
Recipes is a simple iOS application, it retrieves recipes from free API and display it for the user, and allow the user to view recipes details and add it to favourite.
User also can login or process to use the application. 

Using [api.npoint.io](https://api.npoint.io/43427003d33f1f6b51cc)

## Don't Forget To Install Pods

```swift
pod install
```

## Used In The APP

- SWIFT
- Alamofire-based Network Layer
- MVVM Architecture Pattern
- Coordinator Pattern For Handling Navigation
- RxSwift, RxCocoa For Data Binding
- Kingfisher For Images Downloading and Caching
- XIB Files
- Realm For Caching Favourite Recipes using [Generic Realm Manager] 
- UserDefaults for Storing simple data using [Generic UserDefaults Manager]
- Adobe XD For Designing The UI

## TODO:-

- [ ] Code Refactoring
- [ ] Use Repository Pattern
- [ ] Dark Mode Support
- [ ] Unit Tests
- [ ] UI Tests
- [ ] Enhance UI/UX

## Screenshots

- Launch Screen
<img src="/Screenshots/Launch.png" width="200" height="400">

- Login Screen [Invalid Data]
<img src="/Screenshots/Login.Invalid.png" width="200" height="400">

- Login Screen [Valid Data]
<img src="/Screenshots/Login.Valid.png" width="200" height="400">

- Loading Screen
<img src="/Screenshots/Loading.png" width="200" height="400">

- Recipes Screen
<img src="/Screenshots/Recipes.png" width="200" height="400">

- Recipes Screen [Add To Favourites]
<img src="/Screenshots/Recipes.AddToFavourites.png" width="200" height="400">

- Recipes Screen [Remove From Favourites]
<img src="/Screenshots/Recipes.RemoveFromFavourites.png" width="200" height="400">

- Recipes Details
<img src="/Screenshots/RecipeDetails.1.png" width="200" height="400">

- Recipes Details
<img src="/Screenshots/RecipeDetails.2.png" width="200" height="400">

- Recipes Details [Add To Favourite]
<img src="/Screenshots/RecipeDetails.AddToFavourites.png" width="200" height="400">

## App Structure:
* Common
   * Application
      * Core
      * Coordinator
   * Configuration
   * Resources
   * Extensions
      * UI
      * ExternalComponents
   
* Externals
   * Networking
   * DataPersistence
      * UserDefaults
      * Realm

* Scenes
   * Login
      * View
      * ViewModel
      * Coordinator
      * Interactor
   * RecipesList
      * Model
      * View
      * ViewModel
      * Coordinator
      * Interactor
   * RecipeDetails
      * Model
      * View
      * ViewModel
      * Coordinator
      * Interactor
      

## Authors:
Created by 
- Taha Mahmoud [LinkedIn](https://www.linkedin.com/in/engtahamahmoud/)

Please don't hesitate to ask any clarifying questions about the project if you have any.
