import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfg/src/constants/colors.dart';
import 'package:tfg/src/features/core/models/destinations_model.dart';
import 'package:tfg/src/features/core/views/listDestinations/list_destinations.dart';
import 'package:tfg/src/features/core/views/mapPage/map_page.dart';

class GridProvinces extends StatelessWidget {
  const GridProvinces({super.key});

  @override
  Widget build(BuildContext context) {
    final gridProvinces = DestinationModel.listProvinces;
    var size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SizedBox(
        width: size.width,
        height: size.height,
        child: SafeArea(
          bottom: false,
          child: GridView.builder(
            itemCount: gridProvinces.length,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12.0,
              mainAxisSpacing: 12.0,
              //! ENCONTRAR OTRA MANERA DE CENTRARLO Y DE QUE OCUPE LO MAX POSIBLE
              mainAxisExtent: size.height / 2.65,
            ),
            itemBuilder: (context, index) {
              int indice = gridProvinces[index].indexProvince;
              //! CAMBIAR GESTUREDETECTOR POR INKWELL EN EL TFG?
              return GestureDetector(
                onTap: () {
                  Get.to(ListDestinations(indexProvince: indice));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: mainGreenColor,
                    //! CAMBIAR COLOR BORDER SEGUN MODO? 
                    border: Border.all(color: darkColor),
                    borderRadius: BorderRadius.circular(12.0)
                  ),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12.0),
                          topRight: Radius.circular(12.0),
                        ),
                        child: Image.asset(
                          gridProvinces[index].image.first,
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )
                      ),
                      const SizedBox(height: 10.0,),
                      Text(
                        gridProvinces[index].name,
                        style: Theme.of(context).textTheme.displayMedium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 10.0,),
                      Text(
                        gridProvinces[index].description,
                        style: Theme.of(context).textTheme.headlineSmall,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        )
      ),
    );
  }
}