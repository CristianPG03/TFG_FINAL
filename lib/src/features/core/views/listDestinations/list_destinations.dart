import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tfg/src/constants/colors.dart';
import 'package:tfg/src/features/core/models/destinations_model.dart';
import 'package:tfg/src/features/core/views/listDestinations/infoDestination/info_destination.dart';
import 'package:tfg/src/widgets/appBar/app_bar_generic.dart';

//! AÑADIR A FIREBASE LA LISTA PARA PODER "TRABAJAR" CON ELLA (MARCAR COMO VISITADA ETC)

class ListDestinations extends StatefulWidget {
  const ListDestinations({super.key, required this.indexProvince});
  final int indexProvince;

  @override
  State<ListDestinations> createState() => _ListDestinationsState();
}

List<DestinationModel> selectList(int indice) {
  if (indice == 0) {
    return DestinationModel.listCorunha;
  } else if (indice == 1) {
    return DestinationModel.listLugo;
  } else if (indice == 2) {
    return DestinationModel.listOurense;
  } else {
    return DestinationModel.listPontevedra;
  }
}

class _ListDestinationsState extends State<ListDestinations> {
  @override
  Widget build(BuildContext context) {
    var actualList = selectList(widget.indexProvince);
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBarGeneric(
        appBarTitle: actualList.first.place
      ),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final destination = actualList[index];
    
                  return SizedBox(
                    height: 175,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => InfoDestination(destination: actualList[index]),));
                      },
                      child: Card(
                        elevation: 15.0,
                        color: mainGreenColor,
                        margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                destination.image.first,
                                fit: BoxFit.cover,
                                height: 100,
                                width: 80,
                              ),
                              const SizedBox(width: 10,),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      destination.name,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    const Divider(
                                      thickness: 1.5,
                                      color: Colors.black38
                                    ),
                                    Text(
                                      destination.description,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 18
                                      ),
                                      maxLines: 3,
                                    ),
                                  ],
                                ),
                              ),
                              //! ESTO NO MODIFICA EL VALOR DEL MODELO
                              //! SUBIR EL MODELO A FIREBASE?
                              //! O BUSCAR OTRA MANERA DE HACERLO?
                              Switch(
                                value: actualList[index].isVisited,
                                onChanged: (value) {
                                  setState(() {
                                    actualList[index].isVisited = value;
                                  });
                                },
                              ),                       
                            ],
                          ),
                        ),
                        /*child: ListTile(
                          title: Text(
                            destination.name,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          subtitle: Text(
                            destination.description,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 18
                            ),
                            maxLines: 3,
                          ),
                          leading: Image.asset(
                            destination.image,
                            fit: BoxFit.cover,
                            height: 100,
                            width: 80,
                          ),
                          //! CAMBIAR ESTO PARA UN CHECK Y PODER FILTRAR
                          trailing: Icon(
                            actualList[index].isVisited
                            ? Icons.check_box_outlined
                            : Icons.check_box_outline_blank
                          ),
                          contentPadding: const EdgeInsets.all(10.0),
                          onTap: () {
                            
                          },
                        ),*/
                      ),
                    ),
                  );
                },
                childCount: actualList.length
              )
            )
          ],
        )
      ),
    );
  }
}