import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/constants/dimens.dart';
import 'package:ecommerce/generated/l10n.dart';
import 'package:ecommerce/theme/theme_extensions/app_button_theme.dart';
import 'package:ecommerce/theme/theme_extensions/app_color_scheme.dart';
import 'package:ecommerce/theme/theme_extensions/app_data_table_theme.dart';
import 'package:ecommerce/views/widgets/card_elements.dart';
import 'package:ecommerce/views/widgets/portal_master_layout/portal_master_layout.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/add_product_modal.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _dataTableHorizontalScrollController = ScrollController();
  List<ProductModal> _product = [];

  @override
  void dispose() {
    _dataTableHorizontalScrollController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    _loadProducts();
    super.initState();
  }

  _loadProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _product = (prefs.getStringList('products') ?? []).map((item) {
        Map<String, dynamic> productMap = jsonDecode(item);
        return ProductModal.fromMap(productMap);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final appColorScheme = Theme.of(context).extension<AppColorScheme>()!;
    final appDataTableTheme = Theme.of(context).extension<AppDataTableTheme>()!;
    final size = MediaQuery
        .of(context)
        .size;
    final lang = Lang.of(context);
    final summaryCardCrossAxisCount = (size.width >= kScreenWidthLg ? 4 : 2);

    return PortalMasterLayout(
      body: ListView(
        padding: const EdgeInsets.all(kDefaultPadding),
        children: [
        Text(
        'Dashboard',
        style: themeData.textTheme.headlineMedium,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final summaryCardWidth = ((constraints.maxWidth -
                (kDefaultPadding * (summaryCardCrossAxisCount - 1))) /
                summaryCardCrossAxisCount);
            return Wrap(
              direction: Axis.horizontal,
              spacing: kDefaultPadding,
              runSpacing: kDefaultPadding,
              children: [
                SummaryCard(
                  title: lang.newOrders(2),
                  value: '150',
                  icon: Icons.shopping_cart_rounded,
                  backgroundColor: appColorScheme.info,
                  textColor: themeData.colorScheme.onPrimary,
                  iconColor: Colors.black12,
                  width: summaryCardWidth,
                ),
                SummaryCard(
                  title: lang.todaySales,
                  value: '+12%',
                  icon: Icons.ssid_chart_rounded,
                  backgroundColor: appColorScheme.success,
                  textColor: themeData.colorScheme.onPrimary,
                  iconColor: Colors.black12,
                  width: summaryCardWidth,
                ),
                SummaryCard(
                  title: lang.newUsers(2),
                  value: '44',
                  icon: Icons.group_add_rounded,
                  backgroundColor: appColorScheme.warning,
                  textColor: appColorScheme.buttonTextBlack,
                  iconColor: Colors.black12,
                  width: summaryCardWidth,
                ),
                SummaryCard(
                  title: lang.pendingIssues(2),
                  value: '0',
                  icon: Icons.report_gmailerrorred_rounded,
                  backgroundColor: appColorScheme.error,
                  textColor: themeData.colorScheme.onPrimary,
                  iconColor: Colors.black12,
                  width: summaryCardWidth,
                ),
              ],
            );
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: kDefaultPadding),
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: const CardHeader(
            title: 'Sales Product',
            showDivider: false,
          ),
        ),
      ),
      GridView.builder(
        shrinkWrap: true,
        itemCount: _product.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: summaryCardCrossAxisCount,
            mainAxisSpacing: 10,
            mainAxisExtent: size.height * 0.3,
            crossAxisSpacing: 10),
        itemBuilder: (context, index) {
          if (_product.isEmpty) {
            return Center(child: Text('Data is not found'),);
          }

          return ResponsiveContainer(
              imageUrl: _product[index].imageData,
              title: _product[index].name,
              price: _product[index].price,
              description: _product[index].description);
        })
        ],
      ),
    );
  }
}

class SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color backgroundColor;
  final Color textColor;
  final Color iconColor;
  final double width;

  const SummaryCard({
    Key? key,
    required this.title,
    required this.value,
    required this.icon,
    required this.backgroundColor,
    required this.textColor,
    required this.iconColor,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme
        .of(context)
        .textTheme;

    return SizedBox(
      height: 120.0,
      width: width,
      child: Card(
        clipBehavior: Clip.antiAlias,
        color: backgroundColor,
        child: Stack(
          children: [
            Positioned(
              top: kDefaultPadding * 0.5,
              right: kDefaultPadding * 0.5,
              child: Icon(
                icon,
                size: 80.0,
                color: iconColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                    const EdgeInsets.only(bottom: kDefaultPadding * 0.5),
                    child: Text(
                      value,
                      style: textTheme.headlineMedium!.copyWith(
                        color: textColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    title,
                    style: textTheme.labelLarge!.copyWith(
                      color: textColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ResponsiveContainer extends StatelessWidget {
  Uint8List imageUrl;
  final String title;
  final String price;

  final String description;

  ResponsiveContainer({
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width * 0.8,
      height: MediaQuery
          .of(context)
          .size
          .height * 0.8,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.memory(
                  imageUrl,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.06,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              title,
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(description, style: Theme
                .of(context)
                .textTheme
                .titleSmall),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${price}',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(Iconsax.shopping_cart)
              ],
            )
          ],
        ),
      ),
    );
  }
}
