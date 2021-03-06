import 'package:flutter/material.dart';

import './product_edit.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped-models/main.dart';

class ProductListPage extends StatelessWidget {
  Widget _buildEditButton(BuildContext context, int index) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return IconButton(
        icon: Icon(Icons.edit),
        onPressed: () {
          model.selectProduct(index);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return ProductEditPage();
              },
            ),
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: Key(model.products[index].title),
            onDismissed: (DismissDirection direction) {
              if (direction == DismissDirection.endToStart) {
                model.selectProduct(index);
                model.deleteProduct();
              } else if (direction == DismissDirection.startToEnd) {
                print('Swiped start to end');
              } else {
                print('Other swiping');
              }
            },
            background: Container(color: Colors.red),
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(model.products[index].image),
                  ),
                  title: Text(model.products[index].title),
                  subtitle: Text('\$${model.products[index].price.toString()}'),
                  trailing: _buildEditButton(context, index),
                ),
                Divider()
              ],
            ),
          );
        },
        itemCount: model.products.length,
      );
    });
  }
}
