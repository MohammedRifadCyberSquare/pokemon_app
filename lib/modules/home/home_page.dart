import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:app/modules/home/bloc/news_bloc.dart';
import 'package:app/modules/home/home_page_store.dart';
import 'package:app/modules/home/widgets/pokedex_grid.dart';
import 'package:app/modules/items/items_page.dart';
import 'package:app/modules/pokemon_grid/pokemon_grid_page.dart';
import 'package:app/shared/stores/item_store/item_store.dart';
import 'package:app/shared/stores/pokemon_store/pokemon_store.dart';
import 'package:app/shared/ui/widgets/app_bar.dart';
import 'package:app/shared/ui/widgets/drawer_menu/drawer_menu.dart';
import 'package:app/shared/ui/widgets/drawer_menu/widgets/drawer_menu_item.dart';
import 'package:app/shared/ui/widgets/pokeball.dart';
import 'package:app/shared/utils/app_constants.dart';
import 'package:app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _backgroundAnimationController;
  late Animation<double> _blackBackgroundOpacityAnimation;
  String? userName;
  final _newsBloc = new NewsBloc();
    bool isLoggedIn = false;
  late AnimationController _fabAnimationRotationController;
  late AnimationController _fabAnimationOpenController;
  late Animation<double> _fabRotateAnimation;
  late Animation<double> _fabSizeAnimation;

  late PokemonStore _pokemonStore;
  late ItemStore _itemStore;
  late HomePageStore _homeStore;
  late PanelController _panelController;

  late List<ReactionDisposer> reactionDisposer = [];

  @override
  void initState() {
    super.initState();
    initSharedPreferences();
    _pokemonStore = GetIt.instance<PokemonStore>();
    _itemStore = GetIt.instance<ItemStore>();
    _homeStore = GetIt.instance<HomePageStore>();
    _panelController = PanelController();

    _backgroundAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
    _blackBackgroundOpacityAnimation =
        Tween(begin: 0.0, end: 1.0).animate(_backgroundAnimationController);

    _fabAnimationRotationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );

    _fabAnimationOpenController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );

    _fabRotateAnimation = Tween(begin: 180.0, end: 0.0).animate(CurvedAnimation(
        curve: Curves.easeOut, parent: _fabAnimationRotationController));

    _fabSizeAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.4), weight: 80.0),
      TweenSequenceItem(tween: Tween(begin: 1.4, end: 1.0), weight: 20.0),
    ]).animate(_fabAnimationRotationController);

    reactionDisposer.add(
      reaction((_) => _homeStore.isFilterOpen, (_) {
        if (_homeStore.isFilterOpen) {
          _panelController.open();
          _homeStore.showBackgroundBlack();
          _homeStore.hideFloatActionButton();
        } else {
          _panelController.close();
          _homeStore.hideBackgroundBlack();
          _homeStore.showFloatActionButton();
        }
      }),
    );

    reactionDisposer.add(
      reaction((_) => _homeStore.isBackgroundBlack, (_) {
        if (_homeStore.isBackgroundBlack) {
          _backgroundAnimationController.forward();
        } else {
          _backgroundAnimationController.reverse();
        }
      }),
    );

    reactionDisposer.add(
      reaction((_) => _homeStore.isFabVisible, (_) {
        if (_homeStore.isFabVisible) {
          _fabAnimationRotationController.forward();
        } else {
          _fabAnimationRotationController.reverse();
        }
      }),
    );

    _fabAnimationRotationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return ThemeSwitchingArea(
      child: Builder(builder: (context) {
        return Scaffold(
          key: const Key('home_page'),

          endDrawer:   Drawer(
            child: DrawerMenuWidget(isLoggedIn: isLoggedIn, userName: userName,),
          ),
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                titleSpacing: -10,
                backgroundColor: Colors.red,
                expandedHeight: 200,
                floating: true,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  background: Image.asset(
                    'assets/images/poke.png',
                    fit: BoxFit.cover,
                  ),
                  title: Text(
                    'Pokedex',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  centerTitle:
                      false, // Set this to false to left-align the title
                ),
              ),

              SliverPadding(
                padding: EdgeInsets.fromLTRB(2, 4, 2, 3),
                sliver: SliverGrid.count(
                  crossAxisCount: 2,
                  childAspectRatio: 2.3,
                  children: [
                    PokeDexGrid(
                      gridText: 'Pokedex',
                      gridColor: Color(0xFF48D0B0),
                    ),
                    PokeDexGrid(
                      gridText: 'Items',
                      gridColor: Color(0xFFFB6C6C),
                    ),
                    PokeDexGrid(
                      gridText: 'Moves',
                      gridColor: Color(0xFF7AC7FF),
                    ),
                    PokeDexGrid(
                      gridText: 'Abilities',
                      gridColor: Color(0xFFFFCE4B),
                    ),
                    PokeDexGrid(
                      gridText: 'Locations',
                      gridColor: Color(0xD0795548),
                    ),
                    PokeDexGrid(
                      gridText: 'Type effects',
                      gridColor: Color(0xFF9F5BBA),
                    ),
                  ],
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.fromLTRB(3, 8, 4, 3),
                sliver: SliverToBoxAdapter(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Pokemon News',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22),
                        ),
                        Text(
                          'View All',
                          style: TextStyle(
                              color: Colors.blue[300],
                              fontWeight: FontWeight.bold),
                        )
                      ]),
                ),
              ),
              BlocProvider(
                create: (context) => _newsBloc..add(LoadNewsEvent()),
                child: BlocBuilder<NewsBloc, NewsState>(
                  builder: (context, state) {
                    if (state is NewsLoadedSuccessfully) {
                      print('${state.newsList[1]}999999999999999999999999');
                      return SliverList.separated(
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            margin: EdgeInsets.fromLTRB(8, 1, 8, 1),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              // Set your desired background color
                              borderRadius: BorderRadius.circular(
                                  12.0), // Set your desired border radius
                            ),
                            child: ListTile(
                              contentPadding: EdgeInsets.all(10),
                              title: Text(
                                state.newsList[index]['title'],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              subtitle: Container(
                                alignment: Alignment.bottomLeft,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(100  ))
                                ),
                                child: Text(state.newsList[index]['date']),
                              ),
                              leading: Image(
                                  height: 100, // Set your desired height
                                  width: 80, // Set your desired width
                                  fit: BoxFit
                                      .cover, // Adjust the BoxFit property as needed

                                  image: NetworkImage(
                                      state.newsList[index]['pic'])),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => Divider(),
                        itemCount: state.newsList
                            .length, // Replace with your actual item count
                      );
                    } else {
                      return SliverFillRemaining(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                  },
                ),
              ),

              //    SliverGrid(
              //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //   crossAxisCount: 2,
              //   crossAxisSpacing: 8.0,
              //   mainAxisSpacing: 8.0,
              // ),
              // delegate: SliverChildBuilderDelegate(
              //   (BuildContext context, int index) {
              //     return Card(
              //       child: Center(
              //         child: Text('Item $index'),
              //       ),
              //     );
              //   },
              //   childCount: 2,
              //    ))
              //  SliverToBoxAdapter(
              //   child: Container(child: GridView.count(crossAxisCount: 2)),
              //  )
              //             SliverToBoxAdapter(
              //               child: GridView.count(
              //                 crossAxisCount: 2,
              //                 shrinkWrap: true,
              //                 childAspectRatio: 2.3,
              //                 children: [
              //                   // Container(
              //                   //     decoration: BoxDecoration(
              //                   //       // color: onTap != null
              //                   //       //     ? color
              //                   //       //     : AppTheme.getColors(context).drawerDisabled,
              //                   //       borderRadius: BorderRadius.circular(15),
              //                   //     ),
              //                   //     child: ClipRRect(
              //                   //       borderRadius: BorderRadius.circular(15),
              //                   //       child: Stack(
              //                   //         children: [
              //                   //           Positioned(
              //                   //             top: -12,
              //                   //             right: -14,
              //                   //             child: PokeballWidget(
              //                   //               size: 83,
              //                   //               color: Colors.red.withOpacity(0.2),
              //                   //             ),
              //                   //           ),
              //                   //           Positioned(
              //                   //             top: -60,
              //                   //             left: -50,
              //                   //             child: PokeballWidget(
              //                   //               size: 83,
              //                   //               color: Colors.white.withOpacity(0.2),
              //                   //             ),
              //                   //           ),
              //                   //           Column(
              //                   //             mainAxisAlignment: MainAxisAlignment.center,
              //                   //             children: [
              //                   //               Padding(
              //                   //                 padding: const EdgeInsets.only(left: 10),
              //                   //                 child: Text(
              //                   //                   'Pokedex',
              //                   //                   style:
              //                   //                       textTheme.bodyText1?.copyWith(color: Colors.white),
              //                   //                 ),
              //                   //               ),
              //                   //             ],
              //                   //           )
              //                   //         ],
              //                   //       ),
              //                   //     ),
              //                   //   ),
              //                   PokeDexGrid(
              //                     gridText: 'Pokedex',
              //                     gridColor: Color(0xFF48D0B0),
              //                   ),
              //                   PokeDexGrid(
              //                     gridText: 'Items',
              //                     gridColor:Color(0xFFFB6C6C),
              //                   ),
              // PokeDexGrid(
              //                     gridText: 'Moves',
              //                     gridColor:  Color(0xFF7AC7FF),
              //                   ),
              //                   PokeDexGrid(
              //                     gridText: 'Abilities',
              //                     gridColor:Color(0xFFFFCE4B),
              //                   ),

              //                   PokeDexGrid(
              //                     gridText: 'Locations',
              //                     gridColor:Color(0xD0795548)
              //                     ,
              //                   ),
              //                   PokeDexGrid(
              //                     gridText: 'Type effects',
              //                     gridColor:Color(0xFF9F5BBA),
              //                   ),
              //                 ],
              //               ),
              // child: GridView.builder(
              //   gridDelegate:
              //       SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              //   itemBuilder: (context, index) => Container(),
              //   shrinkWrap: true,
              // ),
              // child: ListView.builder(
              //   shrinkWrap: true, // Important to set shrinkWrap to true
              //   physics: NeverScrollableScrollPhysics(), // Disable scrolling within ListView
              //   itemCount: 4, // Replace with the actual item count
              //   itemBuilder: (context, index) {
              //     return ListTile(
              //       title: Text('Item $index'), // Replace with your item widget
              //     );
              //   },
              // ),
              // )
            ],
          ),
          // body: Stack(children: [
          //   SafeArea(
          //     bottom: false,
          //     child: CustomScrollView(
          //       slivers: [
          //         SliverPadding(
          //           padding: const EdgeInsets.symmetric(
          //             horizontal: 10,
          //           ),
          //           sliver: Observer(
          //             builder: (_) => AppBarWidget(
          //               title: _homeStore.page.description,
          //               lottiePath: AppConstants.squirtleLottie,
          //             ),
          //           ),
          //         ),

          //          ListView(
          //           children: [
          //             Text('hello')
          //           ],
          //          )
          //         // Observer(
          //         //   builder: (_) {
          //         //     switch (_homeStore.page) {
          //         //       case HomePageType.POKEMON_GRID:
          //         //         return PokemonGridPage();
          //         //       case HomePageType.ITENS:
          //         //         return ItemsPage();
          //         //       default:
          //         //         return PokemonGridPage();
          //         //     }
          //         //   },
          //         // ),
          //       ],
          //     ),
          //   ),
          // ]),
        );
      }),
    );
  }

  Future<void> initSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    this.userName = prefs.getString('userName');
    print(this.userName);
    if(userName != ''){
      isLoggedIn = true;
    }
    
  }
 
}
