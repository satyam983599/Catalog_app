import 'package:demo_pro/models/cart.dart';
import 'package:demo_pro/models/catalog.dart';
import 'package:demo_pro/pages/home_detail_page.dart';
import 'package:demo_pro/pages/home_page.dart';
import 'package:demo_pro/widgets/home_widgets/add_to_cart.dart';
import 'package:demo_pro/widgets/home_widgets/catalog_image.dart';
import 'package:demo_pro/widgets/themes.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CatalogList extends StatelessWidget {
  const CatalogList({super.key});

  @override
  Widget build(BuildContext context) {
    return !context.isMobile?GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      shrinkWrap: true,
      itemCount: CatalogModel.items.length,
      itemBuilder: (context, index) {
        final catalog = CatalogModel.items[index];
        return InkWell(
            onTap: () =>
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        HomeDetailPage(
                          catalog: catalog,
                        ),
                  ),
                ),
            child: CatalogItem(catalog: catalog)
        );
      },
    )
    :ListView.builder(shrinkWrap: true,
      itemCount: CatalogModel.items.length,
      itemBuilder: (context, index) {
        final catalog = CatalogModel.items[index];
        return InkWell(
            onTap: () =>
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        HomeDetailPage(
                          catalog: catalog,
                        ),
                  ),
                ),
            child: CatalogItem(catalog: catalog));
      },
    ).expand();
  }
}

class CatalogItem extends StatelessWidget {
  final Item catalog;

  const CatalogItem({super.key, required this.catalog});

  @override
  Widget build(BuildContext context) {
    return VxBox(
        child: Row(
      children: [
        Hero(
          tag: Key(catalog.id.toString()),
          child: CatalogImage(
            image: catalog.image,
          ),
        ),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            catalog.name.text.lg.color(context.accentColor).bold.make(),
            catalog.desc.text.textStyle(context.captionStyle).make(),
            10.heightBox,
            ButtonBar(
              alignment: MainAxisAlignment.spaceBetween,
              buttonPadding: EdgeInsets.zero,
              children: [
                "\$${catalog.price}".text.bold.xl.make(),
                AddToCart(catalog: catalog),
              ],
            )
          ],
        ).pOnly(right: 8.0))
      ],
    )).color(context.cardColor).rounded.square(150).make().py16();
  }
}
