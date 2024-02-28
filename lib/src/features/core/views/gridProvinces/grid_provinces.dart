// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:tfg/src/constants/colors.dart';
// import 'package:tfg/src/features/core/models/destinations_model.dart';
// import 'package:tfg/src/features/core/views/listDestinations/list_destinations.dart';
// import 'package:tfg/src/features/core/views/mapPage/map_page.dart';

// class GridProvinces extends StatelessWidget {
//   const GridProvinces({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final gridProvinces = DestinationModel.listProvinces;
//     var size = MediaQuery.of(context).size;

//     return Padding(
//       padding: const EdgeInsets.all(12.0),
//       child: SizedBox(
//         width: size.width,
//         height: size.height,
//         child: SafeArea(
//           bottom: false,
//           child: GridView.builder(
//             itemCount: gridProvinces.length,
//             physics: const NeverScrollableScrollPhysics(),
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               crossAxisSpacing: 12.0,
//               mainAxisSpacing: 12.0,
//               //! ENCONTRAR OTRA MANERA DE CENTRARLO Y DE QUE OCUPE LO MAX POSIBLE
//               mainAxisExtent: size.height / 2.65,
//             ),
//             itemBuilder: (context, index) {
//               int indice = gridProvinces[index].indexProvince;
//               //! CAMBIAR GESTUREDETECTOR POR INKWELL EN EL TFG?
//               return GestureDetector(
//                 onTap: () {
//                   Get.to(ListDestinations(indexProvince: indice));
//                 },
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: mainGreenColor,
//                     //! CAMBIAR COLOR BORDER SEGUN MODO? 
//                     border: Border.all(color: darkColor),
//                     borderRadius: BorderRadius.circular(12.0)
//                   ),
//                   child: Column(
//                     children: [
//                       ClipRRect(
//                         borderRadius: const BorderRadius.only(
//                           topLeft: Radius.circular(12.0),
//                           topRight: Radius.circular(12.0),
//                         ),
//                         child: Image.asset(
//                           gridProvinces[index].image.first,
//                           height: 180,
//                           width: double.infinity,
//                           fit: BoxFit.cover,
//                         )
//                       ),
//                       const SizedBox(height: 10.0,),
//                       Text(
//                         gridProvinces[index].name,
//                         style: Theme.of(context).textTheme.displayMedium,
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       const SizedBox(height: 10.0,),
//                       Text(
//                         gridProvinces[index].description,
//                         style: Theme.of(context).textTheme.headlineSmall,
//                         textAlign: TextAlign.center,
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           )
//         )
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfg/src/features/core/views/listDestinations/list_destinations.dart';

class GridProvinces extends StatefulWidget {
  const GridProvinces({Key? key}) : super(key: key);

  @override
  State<GridProvinces> createState() => _GridProvincesState();
}

class _GridProvincesState extends State<GridProvinces> {
  final List<String> provinceNames = ['A Coruña', 'Pontevedra', 'Lugo', 'Ourense'];
  final List<Color> cardColors = [Colors.blue, Colors.brown, Colors.green, Colors.red];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SizedBox(
        height: double.infinity,
        child: ListView.separated(
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(height: 16); // Ajusta la separación aquí
          },
          itemCount: provinceNames.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                index == 0
                  ? Get.to(ListDestinations(nameProvince: "coruña", color: cardColors[index]))
                  : index == 1
                    ? Get.to(ListDestinations(nameProvince: "pontevedra", color: cardColors[index]))
                    : index == 2
                      ? Get.to(ListDestinations(nameProvince: "lugo", color: cardColors[index]))
                      : Get.to(ListDestinations(nameProvince: "ourense", color: cardColors[index]));
              },
              child: Card(
                elevation: 10,
                color: cardColors[index % cardColors.length],
                child: Container(
                  height: 110,
                  margin: EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      provinceNames[index],
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}





// class _GridProvincesState extends State<GridProvinces> {
//   final destinationController = Get.put(DestinationController());
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;

//     return Padding(
//       padding: const EdgeInsets.all(12.0),
//       child: SizedBox(
//         width: size.width,
//         height: size.height,
//         child: SafeArea(
//           bottom: false,
//           child: FutureBuilder(
//             //! CAMBIAR FUNCION SEGUN LO DECIDIDO EN ANTERIOR COMENTARIO ROJO
//             future: destinationController.getOurenseDestinations("ourense"),
//             builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Center(child: CircularProgressIndicator());
//               }
//               if (snapshot.hasError) {
//                 return Center(child: Text('Error: ${snapshot.error}'));
//               }
//               final destinationsOurense = snapshot.data!.docs;

//               return GridView.builder(
//                 itemCount: destinationsOurense.length,
//                 physics: const AlwaysScrollableScrollPhysics(),
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   crossAxisSpacing: 12.0,
//                   mainAxisSpacing: 12.0,
//                   mainAxisExtent: size.height / 2.65,
//                 ),
//                 itemBuilder: (context, index) {
//                   // Map<String, dynamic>? provinceData = provinces[index].data() as Map<String, dynamic>?;
//                   Map<String, dynamic>? destOurense = destinationsOurense[index].data() as Map<String, dynamic>?;
                  
//                   // return Text("${destOurense?["place"]}");
//                   return Container(
//                     child: Column(
//                       children: [
//                         Text("${destOurense?["place"]}"),
//                         ListView.builder(
//                           scrollDirection: Axis.horizontal,
//                           itemCount: destOurense?["images"].length,
//                           itemBuilder: (context, index) {
//                             return Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Image.network(destOurense?["images"][index]),
//                             );
//                           },
//                         )
//                       ],
//                     ),
//                   );

//                   // return GestureDetector(
//                   //   onTap: () {
//                   //     // You can navigate to the details page here
//                   //     Get.to(ListDestinations(indexProvince: index));
//                   //   },
//                   //   child: Container(
//                   //     decoration: BoxDecoration(
//                   //       color: mainGreenColor,
//                   //       border: Border.all(color: darkColor),
//                   //       borderRadius: BorderRadius.circular(12.0),
//                   //     ),
//                   //     child: Column(
//                   //       children: [
//                   //         ClipRRect(
//                   //           borderRadius: const BorderRadius.only(
//                   //             topLeft: Radius.circular(12.0),
//                   //             topRight: Radius.circular(12.0),
//                   //           ),
//                   //           child: Image.network(
//                   //             provinceData?['image'],
//                   //             height: 180,
//                   //             width: double.infinity,
//                   //             fit: BoxFit.cover,
//                   //           ),
//                   //         ),
//                   //         const SizedBox(height: 10.0),
//                   //         Text(
//                   //           provinceData?['name'],
//                   //           style: Theme.of(context).textTheme.displayMedium,
//                   //           maxLines: 2,
//                   //           overflow: TextOverflow.ellipsis,
//                   //         ),
//                   //         const SizedBox(height: 10.0),
//                   //         Text(
//                   //           provinceData?['description'],
//                   //           style: Theme.of(context).textTheme.headlineSmall,
//                   //           textAlign: TextAlign.center,
//                   //           maxLines: 2,
//                   //           overflow: TextOverflow.ellipsis,
//                   //         ),
//                   //       ],
//                   //     ),
//                   //   ),
//                   // );
//                 },
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
