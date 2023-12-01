import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ui_13/data/blog_details_mode.dart';
import '../core/color.dart';

class BlogDetails extends StatefulWidget {
  final BlogDetailsModel detailsModel;
  const BlogDetails({Key? key, required this.detailsModel}) : super(key: key);

  @override
  _BlogDetailsState createState() => _BlogDetailsState();
}

class _BlogDetailsState extends State<BlogDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.width*0.6,
              decoration: BoxDecoration(
                color: lightGreen,
                boxShadow: [
                  BoxShadow(
                    color: green.withOpacity(0.2),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(widget.detailsModel.imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 14,),

            Text(widget.detailsModel.name, style: TextStyle(
              color: black.withOpacity(0.8),
              fontWeight: FontWeight.bold,
              fontSize: 22.0,
            ),),

            SizedBox(height: 24,),

            ListView.builder(

              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,

              itemCount:
              widget.detailsModel.deslist.length,
              itemBuilder: (_, index) {

                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Visibility(
                          visible: widget.detailsModel.imglist[index].length>2?true:false,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.width*0.5,
                              decoration: BoxDecoration(
                                color: lightGreen,

                                image: DecorationImage(
                                  image: NetworkImage(widget.detailsModel.imglist[index]),
                                  fit: BoxFit.cover,
                                ),
                              ),                            )),
                        Visibility(
                          visible: widget.detailsModel.imglist[index].length>2?true:false,
                            child: SizedBox(height: 14,)),

                        Visibility(
                          visible: widget.detailsModel.titlelist[index].length>=2?true:false,
                            child: Text(widget.detailsModel.titlelist[index], style: TextStyle(
                              color: black.withOpacity(0.8),
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0,
                            ),),),
                        Visibility(
                            visible: widget.detailsModel.titlelist[index].length>2?true:false,
                            child: SizedBox(height: 14,)),

                        Text(widget.detailsModel.deslist[index], style: TextStyle(
                          color: black.withOpacity(0.8),
                          fontWeight: FontWeight.normal,
                        ),),
                      ],
                    ),
                  ),
                );
              },
            ),


          ],
        ),
      ),
    );
  }
}
