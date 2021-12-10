import 'package:flutter/material.dart';
import 'package:medtient/shared/cubits/home/home_cubit.dart';

class ViewImage extends StatelessWidget {
  final imageUrl;
  final text;

  const ViewImage(this.imageUrl , {this.text});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InteractiveViewer(
          clipBehavior: Clip.none,
          scaleEnabled: true,
          maxScale: 4,
          minScale: 1,
          child: Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(image: NetworkImage(imageUrl),),
                  ],
                ),
              ),
            ),
          ),
        ),
        if(text != '')
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            height: 50.0,
            alignment: Alignment.center,
            color: Colors.black.withOpacity(0.5),
            child: Expanded(child: Text(text,style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.white,fontSize: 16.0),)),
          ),
        ),
      ],
    );
  }
}
