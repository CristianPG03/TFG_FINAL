import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfg/src/constants/colors.dart';
import 'package:tfg/src/constants/firebase_const.dart';
import 'package:tfg/src/constants/sizes.dart';
import 'package:tfg/src/constants/text_strings.dart';
import 'package:tfg/src/features/auth/controllers/user_controller.dart';
import 'package:tfg/src/features/auth/models/user_model.dart';
import 'package:tfg/src/features/auth/views/logIn/log_in.dart';
import 'package:tfg/src/features/auth/views/signUp/sign_up.dart';
import 'package:tfg/src/features/core/models/news_model.dart';
import 'package:tfg/src/features/core/views/choresCurLoc/chores.dart';
import 'package:tfg/src/features/core/views/friends/add_friend.dart';
import 'package:tfg/src/features/core/views/gallery/gallery.dart';
import 'package:tfg/src/features/core/views/gridProvinces/grid_provinces.dart';
import 'package:tfg/src/features/core/views/mapPage/map_page.dart';
import 'package:tfg/src/features/core/views/newsRecommendations/news_recommendations.dart';
import 'package:tfg/src/features/core/views/profile/profile.dart';
import 'package:tfg/src/features/core/views/start/sideMenu/drawer_list.dart';
import 'package:tfg/src/features/core/views/start/sideMenu/info_card.dart';
import 'package:tfg/src/utils/theme/theme.dart';
import 'package:tfg/src/widgets/appBar/app_bar_generic.dart';
import 'package:tfg/src/widgets/loadingAnimation/loading_animation_widget.dart';

class Start extends StatefulWidget {
  const Start({super.key});

  @override
  State<Start> createState() => _StartState();
}

//! COMENTAR TODO EL CODIGO CORRECTAMENTE

class _StartState extends State<Start> {
  final userController = Get.put(UserController());
  final listNews = NewsModel.listNews;

  /*var navController = Get.put(NavBarController());

  var navBarItems = [
    const BottomNavigationBarItem(icon: Icon(Icons.abc), label: "Prueba"),
    const BottomNavigationBarItem(icon: Icon(Icons.abc), label: "Prueba"),
    const BottomNavigationBarItem(icon: Icon(Icons.abc), label: "Prueba"),
    const BottomNavigationBarItem(icon: Icon(Icons.abc), label: "Prueba"),
    const BottomNavigationBarItem(icon: Icon(Icons.abc), label: "Prueba"),
  ];*/

  var navBody = [
    const GridProvinces(),
    const Gallery(),
    const NewsRecommendations(),
    const Chores(),
    const AddFriend(),
  ];

  /*final Login _login = Login();
  final Profile _profile = Profile();
  final SignUp _signUp = SignUp();
  //final Profile _profile = Profile();
  final Destinations _destinations = Destinations();*/

  //! AÑADIR UN COLOR VERDE MAS CLARO PARA CUANDO SE PONGA EL MODO OSCURO

  Widget _pageChooser(int page) {
    switch(page) {
      //! PONER EL NOMBRE DE LA PAGINA CORRESPONDIENTE EN CADA CASE 
      case 0:
        return navBody[0];
      case 1:
        return navBody[1];
      case 2:
        return navBody[2];
      case 3:
        return navBody[3];
      case 4:
        return navBody[4];
      default:
        return Text(
          'ERROR AL MOSTRAR LA PÁGINA',
          style: Theme.of(context).textTheme.displayLarge,
          textAlign: TextAlign.center,
        );
    }
  }

  Widget _showPage = const NewsRecommendations();
  final int _page = 2;
  final GlobalKey<CurvedNavigationBarState> _newsNavigationKey = GlobalKey();

  //!CAMBIAR TODAS LAS APPBAR POR EL WIDGET GENERICO
  @override
  Widget build(BuildContext context) {
    //! CAMBIAR DISTRIBUCION PANTALLA?
    return SafeArea(
      bottom: false,
      child: ClipRect(
        child: Scaffold(
          extendBody: true,
          appBar: AppBarGeneric(
            appBarTitle: appName,
            actions: [
              IconButton(
                onPressed: () {
                  //! NO CAMBIA SI EL TFNO ESTA EN MODO OSCURO
                  //! SI ESTA EN MODO CLARO, FUNCIONA CORRECTAMENTE
                  Get.isDarkMode
                    ? Get.changeTheme(AppTheme.lightTheme)
                    : Get.changeTheme(AppTheme.darkTheme);
                },
                icon: const Icon(Icons.dark_mode)
              )
            ],
          ),
          //!MIRAR PARA HACERLO COMO CUANDO SE SACA INFO DE UN JSON
          //! VIDEO: FLUTTER UI DESIGN TUTORIAL - FLUTTER DASHBOARD UI 2023
          //! MINUTO 30:00
          body: Container(
            color: Colors.transparent,
            child: Center(
              child: _showPage,
            ),
          ),
          drawer: Drawer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 30, 10, 20),
                  // child: InfoCard(),
                  child: FutureBuilder(
                    future: userController.getUserDetails(currentUser!.uid),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          return InfoCard(
                            name: snapshot.data!.docs[0]['name'],
                          );
                        } else if (snapshot.hasError) {
                          //! MOSTRAR OTRO MENSAJE DE ERROR, UN SNACKBAR
                          return Center(
                            child: Text(snapshot.error.toString()),
                          );
                        } else {
                          return const Center(
                            child: Text("Algo ha salido mal. Inténtalo de nuevo"),
                          );
                        }
                      } else {
                        return const Center(
                          child: LoadingAnimation(),
                        );
                      }
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: miniSpace/2,
                    horizontal: largeSpace
                  ),
                  child: Divider(thickness: 2,),
                ),
                const DrawerList(),
              ],
            ),
          ),
          bottomNavigationBar: CurvedNavigationBar(
            backgroundColor: Colors.transparent,
            color: mainGreenColor,
            key: _newsNavigationKey,
            index: _page,
            items: <Widget>[
              Icon(
                Icons.map,
                size: 30,
                color: whiteColor,
              ),
              Icon(
                Icons.photo,
                size: 30,
                color: whiteColor,
              ),
              Icon(
                Icons.newspaper,
                size: 30,
                color: whiteColor,
              ),
              Icon(
                Icons.task,
                size: 30,
                color: whiteColor,
              ),
              Icon(
                Icons.group,
                size: 30,
                color: whiteColor,
              ),
            ],
            animationDuration: const Duration(milliseconds: 400),
            height: 50,
            onTap: (int tappedIndex) {
              setState(() {
                _showPage = _pageChooser(tappedIndex);
              });
            },
          ),
        ),
      ),
    );
  }
}

/**
 * 
 * PopupMenuButton<MenuAction>(
    itemBuilder: (context) {
      return [
        const PopupMenuItem<MenuAction>(
          child: Text('Cerrar sesión'),
          value: MenuAction.logout,
        ),
      ];
    },
    onSelected: (value) async {
      switch (value) {
        case MenuAction.logout:
          //Devuelve true o false dependiendo de que botón pulsemos
          final doLogout = await showLogOutDialog(context);
          //Solo entra en este bucle si se devuelve un true en la función
          if (doLogout) {
            await AuthService.firebase().logOut();
            Navigator.of(context)
                .pushNamedAndRemoveUntil(loginRoute, (route) => false);
          }
          break;
      }
    },
  )
 */

/*class NavBarController extends GetxController {
  var currentNavBarIndex = 2.obs;
}*/