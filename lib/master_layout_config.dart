import 'package:flutter/material.dart';
import 'package:ecommerce/app_router.dart';
import 'package:ecommerce/generated/l10n.dart';
import 'package:ecommerce/views/widgets/portal_master_layout/sidebar.dart';
import 'package:iconsax/iconsax.dart';

final sidebarMenuConfigs = [
  SidebarMenuConfig(
    uri: RouteUri.dashboard,
    icon: Icons.dashboard_rounded,
    title: (context) => Lang.of(context).dashboard,
  ),
  SidebarMenuConfig(
    uri: '',
    icon: Icons.control_point,
    title: (context) => 'Admin',
    children: [
      SidebarChildMenuConfig(
        uri: RouteUri.generalUi,
        icon: Icons.arrow_forward_ios,
        title: (context) => 'Create new items',
      ),
    ],
  ),
  SidebarMenuConfig(
    uri: '',
    icon: Icons.library_books_rounded,
    title: (context) => 'Invoice',
    children: [
      SidebarChildMenuConfig(
        uri: RouteUri.bussinessDetailes,
        icon: Iconsax.building,
        title: (context) => 'Company Details',
      ),
      SidebarChildMenuConfig(
        uri: RouteUri.newcustomerDetails,
        icon: Iconsax.user_add,
        title: (context) => 'Customer Invoice',
      ),
      SidebarChildMenuConfig(
        uri: RouteUri.newitems,
        icon: Iconsax.shopping_cart,
        title: (context) => 'Items',
      ),
    ],
  ),
  SidebarMenuConfig(
    uri: RouteUri.iframe,
    icon: Icons.info_outline,
    title: (context) => 'Report',
  ),
];

