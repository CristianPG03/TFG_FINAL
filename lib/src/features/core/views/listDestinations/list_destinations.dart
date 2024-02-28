// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:tfg/src/constants/colors.dart';
// import 'package:tfg/src/features/core/models/destinations_model.dart';
// import 'package:tfg/src/features/core/views/listDestinations/infoDestination/info_destination.dart';
// import 'package:tfg/src/widgets/appBar/app_bar_generic.dart';

// class ListDestinations extends StatefulWidget {
//   const ListDestinations({super.key, required this.indexProvince});
//   final int indexProvince;

//   @override
//   State<ListDestinations> createState() => _ListDestinationsState();
// }

// List<DestinationModel> selectList(int indice) {
//   if (indice == 0) {
//     return DestinationModel.listCorunha;
//   } else if (indice == 1) {
//     return DestinationModel.listLugo;
//   } else if (indice == 2) {
//     return DestinationModel.listOurense;
//   } else {
//     return DestinationModel.listPontevedra;
//   }
// }

// class _ListDestinationsState extends State<ListDestinations> {
//   @override
//   Widget build(BuildContext context) {
//     var actualList = selectList(widget.indexProvince);
//     var size = MediaQuery.of(context).size;

//     return Scaffold(
//       appBar: AppBarGeneric(
//         appBarTitle: actualList.first.place
//       ),
//       body: SizedBox(
//         width: size.width,
//         height: size.height,
//         child: CustomScrollView(
//           slivers: [
//             SliverList(
//               delegate: SliverChildBuilderDelegate(
//                 (context, index) {
//                   final destination = actualList[index];
    
//                   return SizedBox(
//                     height: 175,
//                     child: GestureDetector(
//                       onTap: () {
//                         Navigator.of(context).push(MaterialPageRoute(builder: (context) => InfoDestination(destination: actualList[index]),));
//                       },
//                       child: Card(
//                         elevation: 15.0,
//                         color: mainGreenColor,
//                         margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(15)
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(10.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Image.asset(
//                                 destination.image.first,
//                                 fit: BoxFit.cover,
//                                 height: 100,
//                                 width: 80,
//                               ),
//                               const SizedBox(width: 10,),
//                               Expanded(
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       destination.name,
//                                       overflow: TextOverflow.ellipsis,
//                                       style: const TextStyle(
//                                         fontSize: 24,
//                                         fontWeight: FontWeight.bold
//                                       ),
//                                     ),
//                                     const Divider(
//                                       thickness: 1.5,
//                                       color: Colors.black38
//                                     ),
//                                     Text(
//                                       destination.description,
//                                       overflow: TextOverflow.ellipsis,
//                                       style: const TextStyle(
//                                         fontSize: 18
//                                       ),
//                                       maxLines: 3,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               //! ESTO NO MODIFICA EL VALOR DEL MODELO
//                               //! SUBIR EL MODELO A FIREBASE?
//                               //! O BUSCAR OTRA MANERA DE HACERLO?
//                               Switch(
//                                 value: actualList[index].isVisited,
//                                 onChanged: (value) {
//                                   setState(() {
//                                     actualList[index].isVisited = value;
//                                   });
//                                 },
//                               ),                       
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//                 childCount: actualList.length
//               )
//             )
//           ],
//         )
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfg/src/features/core/controllers/destination_controller.dart';
import 'package:tfg/src/features/core/views/listDestinations/infoDestination/info_destination.dart';
import 'package:tfg/src/widgets/appBar/app_bar_generic.dart';
import 'package:tfg/src/widgets/loadingAnimation/loading_animation_widget.dart';

class ListDestinations extends StatefulWidget {
  const ListDestinations({super.key, required this.nameProvince, required this.color});
  final String nameProvince;
  final Color color;

  @override
  State<ListDestinations> createState() => _ListDestinationsState();
}

class _ListDestinationsState extends State<ListDestinations> {
  final destinationController = Get.put(DestinationController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBarGeneric(
        appBarTitle: "Destinos en ${widget.nameProvince.capitalizeFirst}",
        leading: IconButton(
          onPressed: () {
            Get.back();
          }, 
          icon: const Icon(Icons.arrow_back)
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        width: size.width,
        height: size.height,
        child: Expanded(
          child: FutureBuilder(
            future: destinationController.getDestinations(widget.nameProvince),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var data = snapshot.data!.docs[index];
                      
                      return GestureDetector(
                        onTap: () => Get.to(InfoDestination(destination: data)),
                        child: Card(
                          color: widget.color, // Color proporcionado en el constructor
                          margin: const EdgeInsets.all(10), // Margen en los cuatro lados
                          elevation: 10,
                          child: Container(
                            height: 100, // Altura aumentada
                            padding: const EdgeInsets.all(12.0), // Padding en los cuatro lados
                            child: Center(
                              child: Text(
                                data["place"],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }
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
          )
        ),
      ),
    );
  }
}