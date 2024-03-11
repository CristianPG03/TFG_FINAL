// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:tfg/src/constants/firebase_const.dart';

// class AddFriend extends StatefulWidget {
//   const AddFriend({super.key});

//   @override
//   State<AddFriend> createState() => _AddFriendState();
// }

// class _AddFriendState extends State<AddFriend> {
//   final TextEditingController amigoIdController = TextEditingController();

//   Future<void> addFriend(String friendId) async {
//     try {
//       final curUserFriends = FirebaseFirestore.instance.collection(collectionUser).doc(currentUser!.uid).collection('friends');
//       final friendCurUser = FirebaseFirestore.instance.collection(collectionUser).doc(friendId).collection('friends');

//       await curUserFriends.add({'friend': friendId});

//       await friendCurUser.add({'friend': currentUser!.uid});

//       print('Amigo agregado exitosamente');
//     } catch (error) {
//       print('Error al agregar amigo: $error');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Agregar Amigo'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             TextField(
//               controller: amigoIdController,
//               decoration: InputDecoration(
//                 labelText: 'ID del amigo',
//               ),
//             ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: () {
//                 addFriend(amigoIdController.text);
//               },
//               child: Text('Agregar Amigo'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfg/src/constants/colors.dart';
import 'package:tfg/src/constants/firebase_const.dart';
import 'package:tfg/src/constants/images.dart';
import 'package:tfg/src/constants/sizes.dart';
import 'package:tfg/src/features/auth/controllers/user_controller.dart';
import 'package:tfg/src/widgets/appBar/app_bar_generic.dart';
import 'package:tfg/src/widgets/loadingAnimation/loading_animation_widget.dart';
import 'package:velocity_x/velocity_x.dart';

class AddFriend extends StatefulWidget {
  const AddFriend({Key? key}) : super(key: key);

  @override
  State<AddFriend> createState() => _AddFriendState();
}

//! AÑADIR QUE SI NO SE INTRODUCE ID/NO EXISTE/FORMATO INCORRECTO/ETC MUESTRE MENSAJE
//! SI SE AÑADEN MUCHOS AMIGOS, COMO FUNCIONA EL SCROLL?
//! AL AÑADIR UN NUEVO AMIGO, APARECE EN LA LISTA O NO SE RECARGA AUTOMATICAMENTE??

class _AddFriendState extends State<AddFriend> {
  final userController = Get.put(UserController());
  final TextEditingController amigoIdController = TextEditingController();
  List<Map<String, dynamic>> friendDetailsList = [];
  List<String> friendList = [];

  @override
  void initState() {
    super.initState();
    loadFriendDetails();
  }

  // Future<void> loadFriendList() async {
  //   try {
  //     final querySnapshot = await FirebaseFirestore.instance.collection(collectionUser).doc(currentUser!.uid).collection('friends').get();
  //     setState(() {
  //       friendList = querySnapshot.docs.map((doc) => doc['friend'] as String).toList();
  //     });
  //   } catch (error) {
  //     print('Error al cargar lista de amigos: $error');
  //   }
  // }

  Future<void> loadFriendDetails() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance.collection(collectionUser).doc(currentUser!.uid).collection('friends').get();
      final List<Map<String, dynamic>> tempFriendDetailsList = [];
      
      for (final doc in querySnapshot.docs) {
        final friendId = doc['friend'] as String;
        final friendDataSnapshot = await FirebaseFirestore.instance.collection(collectionUser).doc(friendId).get();
        final friendData = friendDataSnapshot.data() as Map<String, dynamic>;
        tempFriendDetailsList.add({
          'id': friendId,
          'name': friendData['name'],
          'email': friendData['email'],
          'biography': friendData['biography'],
          'password': friendData['password'],
        });
      }
      setState(() {
        friendDetailsList = tempFriendDetailsList;
      });
    } catch (error) {
      print('Error al cargar detalles de amig@s: $error');
    }
  }

  // Future<void> addFriend(String friendId) async {
  //   try {
  //     final curUserFriends = FirebaseFirestore.instance.collection(collectionUser).doc(currentUser!.uid).collection('friends');
  //     final friendCurUser = FirebaseFirestore.instance.collection(collectionUser).doc(friendId).collection('friends');

  //     await curUserFriends.add({'friend': friendId});
  //     await friendCurUser.add({'friend': currentUser!.uid});

  //     amigoIdController.clear();
  //     loadFriendList(); // Actualizar la lista de amigos después de agregar uno nuevo
  //     print('Amigo agregado exitosamente');
  //   } catch (error) {
  //     print('Error al agregar amigo: $error');
  //   }
  // }

  Future<void> addFriend(String friendId) async {
    try {
      final curUserFriends = FirebaseFirestore.instance.collection(collectionUser).doc(currentUser!.uid).collection('friends');
      final friendCurUser = FirebaseFirestore.instance.collection(collectionUser).doc(friendId).collection('friends');

      await curUserFriends.add({'friend': friendId});
      await friendCurUser.add({'friend': currentUser!.uid});

      amigoIdController.clear();
      loadFriendDetails(); // Actualizar la lista de amigos después de agregar uno nuevo
      print('Amig@ agregado exitosamente');
    } catch (error) {
      print('Error al agregar amig@: $error');
    }
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('Agregar Amigo'),
  //     ),
  //     body: Padding(
  //       padding: EdgeInsets.all(16.0),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.stretch,
  //         children: <Widget>[
  //           TextField(
  //             controller: amigoIdController,
  //             decoration: InputDecoration(
  //               labelText: 'ID del amigo',
  //             ),
  //           ),
  //           SizedBox(height: 16.0),
  //           ElevatedButton(
  //             onPressed: () {
  //               addFriend(amigoIdController.text);
  //             },
  //             child: Text('Agregar Amigo'),
  //           ),
  //           SizedBox(height: 16.0),
  //           Text('Lista de amigos:'),
  //           Expanded(
  //             child: ListView.builder(
  //               itemCount: friendList.length,
  //               itemBuilder: (context, index) {
  //                 return FutureBuilder(
  //                   future: userController.getUserDetails(friendList[index]),
  //                   builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
  //                     if (snapshot.connectionState == ConnectionState.done) {
  //                       if (snapshot.hasData) {
  //                         var data = snapshot.data!.docs[0];
  //                         userController.nameController.text = data['name'];
  //                         userController.emailController.text = data['email'];
  //                         userController.biographyController.text = data['biography'];
  //                         userController.passwordController.text = data['password'];

  //                         return Card(
  //                           child: ListTile(
  //                             title: Text(userController.nameController.text),
  //                           ),
  //                         );

  //                       } else if (snapshot.hasError) {
  //                         //! MOSTRAR OTRO MENSAJE DE ERROR, UN SNACKBAR
  //                         return Center(
  //                           child: Text(snapshot.error.toString()),
  //                         );
  //                       } else {
  //                         return const Center(
  //                           child: Text("Algo ha salido mal. Inténtalo de nuevo"),
  //                         );
  //                       }
  //                     } else {
  //                       return const Center(
  //                         child: LoadingAnimation(),
  //                       );
  //                     }
  //                   }
  //                 );
  //               },
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarGeneric(appBarTitle: 'Agregar Amig@'),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: amigoIdController,
              decoration: InputDecoration(
                labelText: 'ID del amig@',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                addFriend(amigoIdController.text);
              },
              child: Text('Agregar Amig@'),
            ),
            SizedBox(height: 16.0),
            Divider(
              color: mainGrayColor,
              indent: space,
              thickness: 2,
              endIndent: space,
            ),
            SizedBox(height: 16.0),
            Text(
              'Lista de amig@s:',
              style: Theme.of(context).textTheme.displayMedium,
              textAlign: TextAlign.center
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: friendDetailsList.length,
                itemBuilder: (context, index) {
                  final friendDetails = friendDetailsList[index];
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: friendDetails['profileImage'] != null
                            ? NetworkImage(friendDetails['profileImage'])
                            : AssetImage(imageUserProfile) as ImageProvider
                      ),
                      title: Text(friendDetails['name']),
                      subtitle: Text(friendDetails['email']),
                      trailing: PopupMenuButton<String>(
                        onSelected: (String result) {
                          if (result == 'ver_perfil') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ProfileView(friendDetails: friendDetails)),
                            );
                            //! QUE ELIMINE AL USUARIO DE FIREBASE Y DE LA LISTA
                          } else if (result == 'eliminar_usuario') {
                            print('Eliminar usuario');
                          }
                        },
                        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                          const PopupMenuItem<String>(
                            value: 'ver_perfil',
                            child: Text('Ver perfil'),
                          ),
                          const PopupMenuItem<String>(
                            value: 'eliminar_usuario',
                            child: Text('Eliminar usuario'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileView extends StatelessWidget {
  final Map<String, dynamic> friendDetails;

  const ProfileView({required this.friendDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarGeneric(appBarTitle: 'Perfil de ${friendDetails['name']}'),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.blue, width: 2),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: friendDetails['profileImage'] != null
                        ? NetworkImage(friendDetails['profileImage'])
                        : AssetImage(imageUserProfile) as ImageProvider,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                friendDetails['name'],
                style: Theme.of(context).textTheme.displayLarge,
              ),
              SizedBox(height: 10),
              Text(
                friendDetails['email'],
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              SizedBox(height: 20),
              const Divider(thickness: 1,),
              SizedBox(height: 20),
              friendDetails['biography'] == ""
              ? Text(
                "No hay información sobre el usuario",
                style: Theme.of(context).textTheme.headlineLarge,
                textAlign: TextAlign.left,
              )
              : Text(
                friendDetails['biography'],
                style: Theme.of(context).textTheme.headlineLarge,
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
