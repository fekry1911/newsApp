import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CardDesign extends StatelessWidget {
   CardDesign({super.key,required this.urlToImage, required this.title, required this.description});
   late String? urlToImage;
   final String? title;
   final String? description;


   @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              child: Image.network(
                fit: BoxFit.fitWidth,
                urlToImage!
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    maxLines: 2,
                    title!,
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height*.01,
                  ),
                  AutoSizeText(
                    description!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 20),
                  )

                ],
              ),
            ),
          ),
          Spacer(),
          Expanded(
              flex: 1,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(Icons.arrow_forward_ios)
                ),
              ))
        ],
      ),
    );
  }
}
