import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Models
import '../models/product.dart';
import '../models/user.dart';

mixin ConnectedProductsModel on Model {
  List<Product> _products = [];
  String _selectedProductId;
  User _authenticatedUser;
  bool _isLoading = false;

  set loadingProcess(loadingProcess) => _isLoading = loadingProcess;
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

  String get getSelectedProductId => _selectedProductId;

  bool get displayFavoritesOnly => _showFavorites;

  int get getSelectedProductIndex {
    return _products.indexWhere((Product product) {
      return product.id == _selectedProductId;
    });
  }

  void setSelectedProductId(String id) => _selectedProductId = id;

  Future<bool> addProduct(
      String image, String title, String description, double price) async {
    loadingProcess = true;
    notifyListeners();

    final Map<String, dynamic> productData = {
      'image':
          'https://static3.depositphotos.com/1005741/195/i/950/depositphotos_1950369-stock-photo-colorful-licorice-candy.jpg',
      'title': title,
      'price': price,
      'description': description,
      'userEmail': _authenticatedUser.email,
      'userId': _authenticatedUser.id,
      'isFavorite': false
    };

    try {
      final http.Response response = await http.post(
          'https://u-the-bargainer-app.firebaseio.com/products.json',
          body: json.encode(productData));

      if (response.statusCode != 200 && response.statusCode != 201) {
        loadingProcess = false;
        notifyListeners();

        return false;
      }

      final Map<String, dynamic> responseData = json.decode(response.body);
      final Product newProduct = Product(
          id: responseData['name'],
          title: title,
          image: image,
          description: description,
          price: price,
          isFavorite: false,
          userEmail: _authenticatedUser.email,
          userId: _authenticatedUser.id);

      _products.add(newProduct);

      loadingProcess = false;

      notifyListeners();
    } catch (error) {
      loadingProcess = false;
      print(error);
    }

    return true;
  }

  Product get getSelectedProduct {
    if (_selectedProductId == null) {
      return null;
    }

    //! .firstWhere works like a filter or a dynamic getter on vue
    //!  Will return a single item, not a list
    return _products.firstWhere((Product product) {
      return product.id == _selectedProductId;
    });
  }

  Future<bool> deleteProduct() {
    _isLoading = true;

    return http
        .delete(
            'https://u-the-bargainer-app.firebaseio.com/products/${getSelectedProduct.id}.json')
        .then((http.Response response) {
      _isLoading = false;

      _products.removeAt(getSelectedProductIndex);
      setSelectedProductId(null);

      notifyListeners();

      return true;
    });
  }

  Future<bool> updateProduct(
      String image, String title, String description, double price) {
    _isLoading = true;
    notifyListeners();

    final Map<String, dynamic> updateProduct = {
      'image':
          'https://static3.depositphotos.com/1005741/195/i/950/depositphotos_1950369-stock-photo-colorful-licorice-candy.jpg',
      'title': title,
      'price': price,
      'description': description,
      'isFavorite': getSelectedProduct.isFavorite,
      'userEmail': getSelectedProduct.userEmail,
      'userId': getSelectedProduct.userId
    };

    return http
        .put(
            'https://u-the-bargainer-app.firebaseio.com/products/${getSelectedProduct.id}.json',
            body: json.encode(updateProduct))
        .then((http.Response response) {
      _isLoading = false;
      final Product updatedProduct = Product(
          id: getSelectedProduct.id,
          title: title,
          image: image,
          description: description,
          price: price,
          isFavorite: getSelectedProduct.isFavorite,
          userEmail: getSelectedProduct.userEmail,
          userId: getSelectedProduct.userId);

      _products[getSelectedProductIndex] = updatedProduct;

      notifyListeners();

      return true;
    });
  }

  void toggleFavoriteProductStatus() {
    final bool isCurrentFavorite = !getSelectedProduct.isFavorite;
    final Product updatedProduct = Product(
        id: getSelectedProduct.id,
        image: getSelectedProduct.image,
        title: getSelectedProduct.title,
        price: getSelectedProduct.price,
        description: getSelectedProduct.description,
        isFavorite: isCurrentFavorite,
        userEmail: getSelectedProduct.userEmail,
        userId: getSelectedProduct.userId);

    _products[getSelectedProductIndex] = updatedProduct;

    //! -> Notifies to repaint (re-render) the current model that is using the method
    //! -> And updates at the runtime the Widget for the user
    //! -> Notifies to repaint (re-render) the current model that is using the method
    notifyListeners();
  }

  void toggleDisplayMode() {
    _showFavorites = !_showFavorites;
    notifyListeners();
  }

  Future<Null> fetchProducts() {
    loadingProcess = true;

    return http
        .get('https://u-the-bargainer-app.firebaseio.com/products.json')
        .then((http.Response response) {
      final List<Product> fetchedProductList = [];

      if (response.body == 'null') {
        loadingProcess = false;
        notifyListeners();

        return;
      }

      json.decode(response.body)
        ..forEach((String productId, dynamic productData) {
          fetchedProductList.add((Product(
              id: productId,
              image: productData['image'],
              title: productData['title'],
              isFavorite: productData['isFavorite'],
              description: productData['description'],
              price: productData['price'],
              userEmail: productData['userEmail'],
              userId: productData['userId'])));
        });

      _products = fetchedProductList;

      loadingProcess = false;

      notifyListeners();

      setSelectedProductId(null);
    });
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

mixin UtilityModel on ConnectedProductsModel {
  bool get getLoadingProcess => _isLoading;
}
