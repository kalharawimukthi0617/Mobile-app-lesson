import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class Photos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Simple"),

      ),
      body: PhotoView(
          imageProvider: NetworkImage(" "),
          minScale: PhotoViewComputedScale.contained*0.8,
          maxScale: PhotoViewComputedScale.covered*2,
          //enableRotation: false,
          backgroundDecoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
          ),
          loadFailedChild: Center(child: CircularProgressIndicator(
            
          ),),
      ),
    );
  }
}
