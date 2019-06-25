import 'package:scoped_model/scoped_model.dart';

// Models
import '../models/product.dart';
import '../models/user.dart';

mixin ConnectedProductsModel on Model {
  List<Product> _products = [];
  int _selectedProductIndex;
  User _authenticatedUser;

  void addProduct(
      String image, String title, String description, double price) {
    final Product newProduct = Product(
        title: title,
        image: image,
        description: description,
        price: price,
        isFavorite: false,
        userEmail: _authenticatedUser.email,
        userId: _authenticatedUser.id);

    _products.add(newProduct);
    notifyListeners();
  }
}

mixin ProductsModel on ConnectedProductsModel {
  // Since this variable store a list on the memory
  // the `get` will reference the same location on the memory
  // To create a copy of this variable, it will need to add List.from()
  // Adding this 'List.from()', we ensure the list will not be updated from the original one
  List<Product> get allProducts => List.from(_products);
  bool _showFavorites = false;

  List<Product> get getDisplayedProducts {
    if (_showFavorites) {
      //! Filter mode on Dart using 'where'
      //! 'where' does not return a correct list, but iterable, so it is needed to call .toList()
      return _products.where((Product product) => product.isFavorite).toList();
    }

    return List.from(_products);
  }

  int get getSelectedProductIndex => _selectedProductIndex;

  bool get displayFavoritesOnly => _showFavorites;

  void deleteProduct() {
    _products.removeAt(_selectedProductIndex);
    notifyListeners();
  }

  void updateProduct(
      String image, String title, String description, double price) {
    final Product updatedProduct = Product(
        title: title,
        image: image,
        description: description,
        price: price,
        isFavorite: getSelectedProduct.isFavorite,
        userEmail: getSelectedProduct.userEmail,
        userId: getSelectedProduct.userId);

    _products[_selectedProductIndex] = updatedProduct;
    notifyListeners();
  }

  void setSelectedProductIndex(int index) => _selectedProductIndex = index;

  Product get getSelectedProduct {
    if (_selectedProductIndex == null) {
      return null;
    }

    return _products[_selectedProductIndex];
  }

  void toggleFavoriteProductStatus() {
    final bool isCurrentFavorite = !getSelectedProduct.isFavorite;
    final Product updatedProduct = Product(
        image: getSelectedProduct.image,
        title: getSelectedProduct.title,
        price: getSelectedProduct.price,
        description: getSelectedProduct.description,
        isFavorite: isCurrentFavorite,
        userEmail: getSelectedProduct.userEmail,
        userId: getSelectedProduct.userId);

    _products[_selectedProductIndex] = updatedProduct;

    //! -> Notifies to repaint (re-render) the current model that is using the method
    //! -> And updates at the runtime the Widget for the user
    //! -> Notifies to repaint (re-render) the current model that is using the method
    notifyListeners();
  }

  void toggleDisplayMode() {
    _showFavorites = !_showFavorites;
    notifyListeners();
  }
}

//* The mixin keyword allow to gather a Object to be injected to another
//* The  'scoped_main' will receive a copy of whatever scopeModel that will be added to her
//* Will note iheritance (extend), just will be put together.
//* Now the Scope_Model have the functionality to use more then one scope on main.dart file

mixin UserModel on ConnectedProductsModel {
  void doLogin({String email, String password}) {
    _authenticatedUser =
        User(id: 'adsa1312d', email: email, password: password);
  }
}
