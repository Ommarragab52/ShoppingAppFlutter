import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/core/export.dart';
import 'package:flutter_ecommerce_app/core/widgets/custom_app_bar.dart';
import 'package:flutter_svg/svg.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Account',
        backButton: false,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: SvgPicture.asset(Assets.svgProfile),
            title: Text('Profile', style: AppStyles.headingH6),
            onTap: () {
              context.pushNamed(Routes.profileScreen);
            },
          ),
          ListTile(
            leading: SvgPicture.asset(Assets.svgOrder),
            title: Text('Order', style: AppStyles.headingH6),
            onTap: () {},
          ),
          ListTile(
            leading: SvgPicture.asset(Assets.svgAddress),
            title: Text('Address', style: AppStyles.headingH6),
            onTap: () {
              context.pushNamed(Routes.addressScreen);
            },
          ),
          ListTile(
            leading: SvgPicture.asset(Assets.svgPayment),
            title: Text('Payment', style: AppStyles.headingH6),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
