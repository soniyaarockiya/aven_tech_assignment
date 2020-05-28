import 'package:flutter/material.dart';
import 'package:aventech_assignment/data/product_pojo.dart';
import 'package:aventech_assignment/services/get_json_data.dart';
import 'package:aventech_assignment/sub_widgtes/list_view_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:aventech_assignment/services/authentication.dart';

class HomePage extends StatefulWidget {
  //when sign out is pressed
  final VoidCallback onSignedOutHome;
  HomePage({this.onSignedOutHome});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GetJson _getJson = new GetJson();
  List<Product> _productList = [];
  ScrollController _scrollController = ScrollController();
  BaseAuth _auth = new Auth();
  int items = 0;

  @override
  void initState() {
    super.initState();
    getJsonData();

    //Infinite scroll functionality
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          //url uses page number as a value
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              child: Text('Sign Out'),
              onPressed: logout,
            ),
          ),
          SizedBox(width: 10.0),
          Stack(
            //ALIGNMENT IS IMPORTANT FOR NOTIFICATION ICON
            alignment: Alignment.centerLeft,
            children: <Widget>[
              Icon(
                Icons.add_shopping_cart,
                size: 40.0,
              ),
              CircleAvatar(
                radius: 10.0,
                child: Text(items.toString()),
              )
            ],
          )
        ],
      ),
      body: ListView.builder(
          controller: _scrollController,
          itemCount: _productList.length + 1,
          itemBuilder: (context, index) {
            if (index == _productList.length) {
              return CupertinoActivityIndicator(
                radius: 40.0,
              );
            }
            return ListViewCard(
              product: _productList[index],
              addToCart: () {
                setState(() {
                  items++;
                });
              },
            );
          }),
    );
  }

  void getJsonData() {
    _productList = _getJson.getJsonData();

    for (int i = 0; i < _productList.length; i++) {
      print(_productList[i].englishName);
    }
  }

  void logout() async {
    try {
      // Navigator.pop(context);
      await _auth.signOut();
      widget.onSignedOutHome();
    } catch (e) {
      print(e);
    }
  }
}
