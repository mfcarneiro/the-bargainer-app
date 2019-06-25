import 'package:scoped_model/scoped_model.dart';

// Scoped models
import './scoped_connect_products.dart';

class MainModel extends Model
    with ConnectedProductsModel, UserModel, ProductsModel {}
