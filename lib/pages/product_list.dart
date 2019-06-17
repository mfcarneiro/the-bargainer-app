import 'package:flutter/material.dart';

// Widget
import './product_edit.dart';

class ProductListPage extends StatelessWidget {
  final Function updateProduct;
  final Function deleteProduct;
  final List<Map<String, dynamic>> productList;

  ProductListPage(this.productList, this.updateProduct, this.deleteProduct);

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

  DismissDirection _dismissEndToStart(DismissDirection direction, int index) {
    if (direction == DismissDirection.endToStart) {
      deleteProduct(index);
    }

    return direction;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          // -> Dismissible allows to swipe the current item to do an action (e.g: Delete the selected item on the list)
          return Dismissible(
              direction: DismissDirection.endToStart,
              key: Key(productList[index]['title']),
              onDismissed: (DismissDirection direction) {
                _dismissEndToStart(direction, index);
              },
              background: Container(
                color: Colors.red,
                padding: EdgeInsets.only(right: 10.0),
                child: Row(
                  textDirection: TextDirection.rtl,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 10.0),
                      child: Text(
                        'Delete',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                ),
              ),
              child: Column(children: <Widget>[
                ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(productList[index]['image']),
                    ),
                    title: Text(productList[index]['title']),
                    subtitle:
                        Text('\$ ${productList[index]['price'].toString()}'),
                    trailing: IconButton(
                      icon: Icon(Icons.mode_edit),
                      onPressed: () => _buildProductEditor(context, index),
                    )),
                Divider()
              ]));
        },
        itemCount: productList.length,
      ),
    );
  }
}
