import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class GalleryPhotoViewWrapper extends StatefulWidget {
  GalleryPhotoViewWrapper({
    this.imageProviders,
    this.loadingChild,
    this.backgroundDecoration,
    this.minScale,
    this.maxScale,
    this.index,
  }) : pageController = PageController(initialPage: index);

  final List<ImageProvider> imageProviders;
  final Widget loadingChild;
  final Decoration backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;
  final int index;
  final PageController pageController;

  @override
  State<StatefulWidget> createState() {
    return _GalleryPhotoViewWrapperState();
  }
}

class _GalleryPhotoViewWrapperState extends State<GalleryPhotoViewWrapper> {
  int currentIndex;
  @override
  void initState() {
    currentIndex = widget.index;
    super.initState();
  }

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar:  AppBar(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),// 头部图标颜色
          title: Text("${currentIndex + 1}/${widget.imageProviders.length}",style: TextStyle(color: Colors.white),),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        body: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child:Container(
              constraints: BoxConstraints.expand(
                height: MediaQuery.of(context).size.height,
              ),
              child: Stack(
                alignment: Alignment.bottomRight,
                children: <Widget>[
                  PhotoViewGallery(
                    pageOptions: /* <PhotoViewGalleryPageOptions>[]*/
                      widget.imageProviders.map((e){
                         return PhotoViewGalleryPageOptions(
                          imageProvider: e,
                         //heroTag: "list-info${currentIndex}",
                          );
                      }).toList()
                    ,
                    loadingChild: widget.loadingChild,
                    backgroundDecoration: widget.backgroundDecoration,
                    pageController: widget.pageController,
                    onPageChanged: onPageChanged,
                  )
                ],
              )),
        )
    );
  }
}