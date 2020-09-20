import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class Gallery extends StatelessWidget {
  final imageList=[
  'https://static.toiimg.com/photo/72975551.cms',
    'https://c8.alamy.com/comp/X9FYYD/imagge-for-flying-seagulls-over-a-yucatan-peninsula-beach-X9FYYD.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gallery'),
      ),
      body: PhotoViewGallery.builder(
          itemCount: imageList.length,
          builder: (context,index){
            return PhotoViewGalleryPageOptions(
              imageProvider: NetworkImage(
                imageList[index],
              ),
              minScale: PhotoViewComputedScale.covered*0.3,
              maxScale: PhotoViewComputedScale.covered*2,
            );
          },
        scrollPhysics: BouncingScrollPhysics(),
        backgroundDecoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
        ),
        loadFailedChild: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
