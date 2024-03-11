import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ecommerce/app_router.dart';
import 'package:ecommerce/constants/dimens.dart';
import 'package:ecommerce/generated/l10n.dart';
import 'package:ecommerce/master_layout_config.dart';
import 'package:ecommerce/theme/theme_extensions/app_sidebar_theme.dart';
import 'package:ecommerce/views/widgets/portal_master_layout/sidebar.dart';

import '../../invoice_screen/invoice_preview.dart';

class LocaleMenuConfig {
  final String languageCode;
  final String? scriptCode;
  final String name;

  const LocaleMenuConfig({
    required this.languageCode,
    this.scriptCode,
    required this.name,
  });
}

class PortalMasterLayout extends StatelessWidget {
  final Widget body;
  final bool autoSelectMenu;
  final String? selectedMenuUri;
  final void Function(bool isOpened)? onDrawerChanged;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;
  final List<Widget>? persistentFooterButtons;

  const PortalMasterLayout({
    Key? key,
    required this.body,
    this.autoSelectMenu = true,
    this.selectedMenuUri,
    this.onDrawerChanged,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.persistentFooterButtons,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final themeData = Theme.of(context);
    final drawer = (mediaQueryData.size.width <= kScreenWidthLg
        ? _sidebar(context)
        : null);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        automaticallyImplyLeading: (drawer != null),
        title: ResponsiveAppBarTitle(
          onAppBarTitlePressed: () => GoRouter.of(context).go(RouteUri.home),
        ),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>InvoicePreview()));
          }, icon: Icon(Icons.picture_as_pdf))
        ],
      ),
      drawer: drawer,
      drawerEnableOpenDragGesture: false,
      onDrawerChanged: onDrawerChanged,
      body: _responsiveBody(context),
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      floatingActionButtonAnimator: floatingActionButtonAnimator,
      persistentFooterButtons: persistentFooterButtons,
    );
  }

  Widget _responsiveBody(BuildContext context) {
    if (MediaQuery.of(context).size.width <= kScreenWidthLg) {
      return body;
    } else {
      return Row(
        children: [
          SizedBox(
            width: Theme.of(context).extension<AppSidebarTheme>()!.sidebarWidth,
            child: _sidebar(context),
          ),
          Expanded(child: body),
        ],
      );
    }
  }

  Widget _sidebar(BuildContext context) {
    final goRouter = GoRouter.of(context);

    return Sidebar(
      autoSelectMenu: autoSelectMenu,
      selectedMenuUri: selectedMenuUri,
      onAccountButtonPressed: () => goRouter.go(RouteUri.myProfile),
      onLogoutButtonPressed: () => goRouter.go(RouteUri.logout),
      sidebarConfigs: sidebarMenuConfigs,
    );
  }
}

class ResponsiveAppBarTitle extends StatelessWidget {
  final void Function() onAppBarTitlePressed;

  const ResponsiveAppBarTitle({
    Key? key,
    required this.onAppBarTitlePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = Lang.of(context);
    final mediaQueryData = MediaQuery.of(context);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onAppBarTitlePressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Visibility(
              visible: (mediaQueryData.size.width > kScreenWidthSm),
              child: Container(
                padding: const EdgeInsets.only(right: kDefaultPadding * 0.7),
                height: 40.0,
                child: Image.asset(
                  'assets/images/app_logo.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Text(lang.appTitle),
          ],
        ),
      ),
    );
  }
}
