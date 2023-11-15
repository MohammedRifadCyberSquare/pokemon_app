import 'package:app/modules/authentication/SignuUp/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:app/modules/home/home_page_store.dart';
import 'package:app/shared/ui/widgets/animated_pokeball.dart';
import 'package:app/shared/ui/widgets/drawer_menu/widgets/drawer_menu_item.dart';
import 'package:app/shared/utils/app_constants.dart';
import 'package:app/theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerMenuWidget extends StatefulWidget {
  final bool isLoggedIn;
  final String? userName;
  DrawerMenuWidget({
    this.userName = '',
    required this.isLoggedIn,

  });

  @override
  State<DrawerMenuWidget> createState() => _DrawerMenuWidgetState();
}

class _DrawerMenuWidgetState extends State<DrawerMenuWidget>
    with TickerProviderStateMixin {
  final HomePageStore _homeStore = GetIt.instance<HomePageStore>();
  String? userName;
  late AnimationController _controller;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2))
          ..repeat();

    super.initState();
    initSharedPreferences();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      color: Theme.of(context).backgroundColor,
      // decoration: BoxDecoration(image: Ass),
      child: Stack(
        children: [
          Positioned(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                      text: 'Welcome! ', style: TextStyle(color: Colors.black)),
                  TextSpan(
                      text: this.userName != null ? userName : 'user',
                      style: TextStyle(color: Colors.black))
                ],
              ),
            ),
            top: 100,
            left: 40,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Image.asset(
                    AppConstants.pokedexIcon,
                    width: 100,
                    height: 100,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedPokeballWidget(
                          color: AppTheme.getColors(context).pokeballLogoBlack,
                          size: 24),
                      const SizedBox(
                        width: 5,
                      ),
                      Text("Pokedex", style: textTheme.headline1),
                    ],
                  ),
                ],
              ),
              GridView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, mainAxisExtent: 70),
                children: [
                  DrawerMenuItemWidget(
                    color: AppTheme.getColors(context).drawerPokedex,
                    text: "Pokedex",
                    onTap: () {
                      Navigator.pop(context);

                      _homeStore.setPage(HomePageType.POKEMON_GRID);
                    },
                  ),
                  DrawerMenuItemWidget(
                    color: AppTheme.getColors(context).drawerItems,
                    text: "Items",
                    onTap: () {
                      Navigator.pop(context);

                      _homeStore.setPage(HomePageType.ITENS);
                    },
                  ),
                  DrawerMenuItemWidget(
                      color: AppTheme.getColors(context).drawerMoves,
                      text: "Moves"),
                  DrawerMenuItemWidget(
                      color: AppTheme.getColors(context).drawerAbilities,
                      text: "Abilities"),
                  DrawerMenuItemWidget(
                      color: AppTheme.getColors(context).drawerTypeCharts,
                      text: "Type Charts"),
                  DrawerMenuItemWidget(
                      color: AppTheme.getColors(context).drawerLocations,
                      text: "Locations"),
                ],
              ),
              userName == ''
                  ? Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: this.userName == null
                          ? InkWell(
                              onTap: () => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignUpPage(),
                                  ),
                                )
                              },
                              child: RichText(
                                text: TextSpan(
                                    style: DefaultTextStyle.of(context).style,
                                    children: [
                                      TextSpan(
                                        text: 'Dont have an account? ',
                                      ),
                                      TextSpan(
                                          text: ' Signup Now! ',
                                          style: TextStyle(color: Colors.blue)),
                                    ]),
                              ),
                            )
                          : Text(''),
                    )
                  : Text('')
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Lottie.asset(
              AppConstants.diglettLottie,
              height: 200.0,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> initSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    this.userName = prefs.getString('userName');
    print(this.userName);
    print('00000000000');
  }
}
