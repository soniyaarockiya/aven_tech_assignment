import 'package:flutter/material.dart';
import 'package:aventech_assignment/data/product_pojo.dart';

class ListViewCard extends StatefulWidget {
  final Product product;
  final Function addToCart;

  ListViewCard({this.product, this.addToCart});

  @override
  _ListViewCardState createState() => _ListViewCardState();
}

class _ListViewCardState extends State<ListViewCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Image.network(
                      'https://lh3.googleusercontent.com/proxy/cUxZkWgCzC5w0M61hVJg-gEMhi7BXkmR_PD13E5DVCHdyeFm9oH_aOyAiRDdP4c1jHR6bZLRxrOHJCNmaBbTSobtD1AQcwks4vbVoNutBE854t9rVoQ'),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(widget.product.categories),
                      Text(widget.product.categoryId),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: RaisedButton(
                              onPressed: widget.addToCart,
                              child: Text('Add to Cart'),
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Expanded(
                            child: RaisedButton(
                              onPressed: () {},
                              child: Text('Place Order'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
