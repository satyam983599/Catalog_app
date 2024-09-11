import 'package:demo_pro/core/store.dart';
import 'package:demo_pro/models/cart.dart';
import 'package:demo_pro/models/catalog.dart';
import 'package:demo_pro/utils/routes.dart';
import 'package:demo_pro/widgets/home_widgets/catalog_header.dart';
import 'package:demo_pro/widgets/home_widgets/catalog_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final int days = 30;

  final url = "https://api.jsonbin.io/v3/b/66e1caabe41b4d34e42da2fa";
  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    await Future.delayed(Duration(seconds: 1));
    // final catalog_json =
    //     await rootBundle.loadString("assets/files/catalog.json");

    final response =
    await http.get(Uri.parse(url));

    final catalogJson=response.body;

    final decodeData = await jsonDecode(catalogJson);

    var productData = decodeData['record']["products"];
    // print(productData);
    CatalogModel.items =
        List.from(productData).map<Item>((item) => Item.fromMap(item)).toList();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final _cart=(VxState.store as MyStore).cart;
    return Scaffold(
        backgroundColor: context.canvasColor,
        floatingActionButton: VxBuilder(
          mutations: {AddMutation,RemoveMutation},
          builder:(context , dynamic, VxStatus)=> FloatingActionButton(
            onPressed: () => Navigator.pushNamed(context, MyRoutes.cartRoute),
            backgroundColor: context.theme.focusColor,
            child: Icon(
              CupertinoIcons.cart,
              color: Colors.white,
            ),
          ).badge(color: Vx.red500,size: 20,count: _cart.items.length,textStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          )),
        ),
        body: SafeArea(
          child: Container(
            padding: Vx.m32,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CatalogHeader(),
                if (CatalogModel.items != null && CatalogModel.items.isNotEmpty)
                  CatalogList().py16().expand()
                else
                  Center(
                    child: CircularProgressIndicator().centered().expand(),
                  )
              ],
            ),
          ),
        ));
  }
}
