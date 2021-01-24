import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intensivevr_pub/features/authentication/bloc/authentication_bloc.dart';
import 'package:intensivevr_pub/features/home/view/drawer/home_menu_option.dart';
import 'package:intensivevr_pub/features/home/view/drawer/user_info.dart';
import 'package:intensivevr_pub/features/products/view/products_page.dart';
import 'package:intensivevr_pub/widgets/complex/complex.dart';

class HomeMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print(Theme.of(context).brightness.toString());
    return Drawer(
      child: Container(
        color: Theme.of(context).cardColor,
        child: ListView(
          children: [
            UserInfo(),
            ThemeSwitcher(),
            HomeMenuOption(
                title: "Option 2",
                onPress: () {
                  Navigator.pop(context);
                }),
            HomeMenuOption(
                title: "Oferta Baru (produkty)",
                onPress: () {
                  Navigator.push(context, ProductsPage.route());
                }),
            HomeMenuOption(
              title: "Logout",
              onPress: () {
                BlocProvider.of<AuthenticationBloc>(context)
                    .add(AuthenticationLogoutRequested());
              },
            )
          ],
        ),
      ),
    );
  }
}
