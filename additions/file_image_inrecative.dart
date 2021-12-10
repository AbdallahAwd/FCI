import 'dart:io';

import 'package:flutter/material.dart';

class AddImageViewer extends StatelessWidget {
final File fileImage;
final String networkImage;

  const AddImageViewer({this.fileImage, this.networkImage});
  @override
  Widget build(BuildContext context) {
    if(fileImage != null) {
      return InteractiveViewer(
      child: Image.file(fileImage),
    );
    }
    else if (networkImage != null)
      {
        return InteractiveViewer(
            child: Container(
            child:Image.network(networkImage),
            ),
        );
      }
  }
}
