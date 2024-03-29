import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce/constants/dimens.dart';
import 'package:ecommerce/generated/l10n.dart';
import 'package:ecommerce/theme/theme_extensions/app_color_scheme.dart';

class PublicMasterLayout extends StatelessWidget {
  final Widget body;

  const PublicMasterLayout({
    Key? key,
    required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: kToolbarHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: VerticalDivider(
                    width: 1.0,
                    thickness: 1.0,
                    color: themeData.colorScheme.onSurface.withOpacity(0.3),
                    indent: 14.0,
                    endIndent: 14.0,
                  ),
                ),

                const SizedBox(width: kDefaultPadding * 0.5),
              ],
            ),
          ),
          Expanded(
            child: body,
          ),
        ],
      ),
    );
  }

}
