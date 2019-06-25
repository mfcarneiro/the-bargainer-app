import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

// Widget
import './product_edit.dart';

// Scoped Model
import '../scoped_models/scoped_main.dart';

class ProductListPage extends StatelessWidget {
  _buildProductEditPage(BuildContext context, MainModel model) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return ProductEditPage();
    })).then((_) => model.setSelectedProductIndex(null));
  }

  Widget _buildEditButton(BuildContext context, int index) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return IconButton(
          icon: Icon(Icons.mode_edit),
          onPressed: () {
            model.setSelectedProductIndex(index);
            _buildProductEditPage(context, model);
          });
    });
  }

  DismissDirection _dismissEndToStart(
      {@required DismissDirection direction,
      @required Function deleteProduct}) {
    if (direction == DismissDirection.endToStart) {
      deleteProduct();
    }

    return direction;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return Container(
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            //! -> Dismissible allows to swipe the current item to do an action (e.g: Delete the selected item on the list)
            return Dismissible(
                direction: DismissDirection.endToStart,
                key: Key(model.allProducts[index].title),
                onDismissed: (DismissDirection direction) {
                  _dismissEndToStart(
                      direction: direction, deleteProduct: model.deleteProduct);
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
                        backgroundImage:
                            AssetImage(model.allProducts[index].image),
                      ),
                      title: Text(model.allProducts[index].title),
                      subtitle: Text(
                          '\$ ${model.allProducts[index].price.toString()}'),
                      trailing: _buildEditButton(context, index)),
                  Divider()
                ]));
          },
          itemCount: model.allProducts.length,
        ),
      );
    });
  }
}
