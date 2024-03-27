import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tfg/src/constants/colors.dart';
import 'package:tfg/src/constants/sizes.dart';

class NewsCardWidget extends StatefulWidget {
    NewsCardWidget({
    super.key, required this.news,
  });

  final QueryDocumentSnapshot<Object?> news;

  @override
  State<NewsCardWidget> createState() => _NewsCardWidgetState();
}

class _NewsCardWidgetState extends State<NewsCardWidget> {
  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    final isDarkMode = brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(defaultSize),
        image: DecorationImage(
          fit: BoxFit.fill,
          image: NetworkImage(widget.news["image"]),
        ),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(defaultSize),
          border: Border.all(
            color: isDarkMode ? lightColor : darkColor,
            width: 2
          ),
          gradient: const LinearGradient(
            colors: [Colors.transparent, Colors.black],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
          )
        ),
        padding: const EdgeInsets.all(space),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.news["title"],
              style: TextStyle(
                color: whiteColor,
                fontSize: defaultSize - 10,
                fontWeight: FontWeight.bold
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: miniSpace,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.news["writer"],
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                Text(
                  widget.news["date"],
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}