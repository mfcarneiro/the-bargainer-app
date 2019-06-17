import 'package:flutter/material.dart';

// Widget
import './product_edit.dart';

class ProductListPage extends StatelessWidget {
  final Function updateProduct;
  final List<Map<String, dynamic>> productList;

  ProductListPage(this.productList, this.updateProduct);

  _buildProductEditor(BuildContext context, int index) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return ProductEditPage(
        product: productList[index],
        updateProduct: updateProduct,
        productIndex: index,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
              leading: Image.asset('assets/food.jpg'),
              title: Text(productList[index]['title']),
              trailing: IconButton(
                icon: Icon(Icons.mode_edit),
                onPressed: () => _buildProductEditor(context, index),
              ));
        },
        itemCount: productList.length,
      ),
    );
  }
}
