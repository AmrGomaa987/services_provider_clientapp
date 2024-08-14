import 'package:clientphase/models/service_model.dart';
import 'package:clientphase/provider/bookmark_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlumbingContainer extends StatefulWidget {
  final Service service;
  final Function onTap;
  PlumbingContainer({Key? key, required this.service, required this.onTap})
      : super(key: key);

  @override
  _PlumbingContainerState createState() => _PlumbingContainerState();
}

class _PlumbingContainerState extends State<PlumbingContainer> {
  bool _isLoading = false;

  void addToWishlist() {
    print("${widget.service.id}");
  }

  void addBookmark(WishlistProvider bookmarkProvider) async {
    setState(() {
      _isLoading = true;
    });
    await bookmarkProvider.add(widget.service.id);
    setState(() {
      _isLoading = false;
    });
  }

  void removeBookmark(WishlistProvider bookmarkProvider) async {
    setState(() {
      _isLoading = true;
    });
    await bookmarkProvider.remove(widget.service.id);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        margin: EdgeInsets.symmetric(
            vertical: 2.0), // Add margin between containers
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 130,
                width: 130,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    widget.service.coverImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 17),
                  Text(
                    widget.service.provider["name"],
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  SizedBox(height: 5),
                  Text(
                    widget.service.title,
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                  SizedBox(height: 5),
                  Text(
                    widget.service.location,
                    style: TextStyle(color: Color(0xFF7210ff), fontSize: 16),
                  ),
                  SizedBox(height: 5),
                //   Row(children: [
                //     Icon(
                //   _getRatingIcon((widget.service.ratingsAverage ?? 0.0).toDouble()),
                //   color: Colors.orange,
                // ),

                //     SizedBox(width: 5),
                //     Text(
                //       '${widget.service.ratingsQuantity.toDouble() == 0 ? 0 : widget.service.ratingsQuantity}',
                //       style: TextStyle(fontSize: 10),
                //     ),
                //     SizedBox(width: 5),
                //     Text('|'),
                //     SizedBox(width: 5),
                //     Text(
                //       '${widget.service.ratingsQuantity.toDouble() == 0 ? '0' : widget.service.ratingsAverage?.toStringAsFixed(1)} مراجعة',
                //       style: TextStyle(fontSize: 10),
                //     ),
                //   ])
                ],
              ),
            ),
            Consumer<WishlistProvider>(
              builder: (context, bookmarkProvider, child) {
                if (_isLoading) {
                  return CircularProgressIndicator();
                } else {
                  if (bookmarkProvider.isInWishList(widget.service.id)) {
                    return IconButton(
                      icon:
                          const Icon(Icons.bookmark, color: Color(0xFF7210ff)),
                      onPressed: () => removeBookmark(bookmarkProvider),
                    );
                  } else {
                    return IconButton(
                      icon: const Icon(Icons.bookmark_add_outlined,
                          color: Color(0xFF7210ff)),
                      onPressed: () => addBookmark(bookmarkProvider),
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  IconData _getRatingIcon(double rating) {
    if (rating >= 4.5) {
      return Icons.star;
    } else if (rating >= 3.0) {
      return Icons.star_half;
    } else {
      return Icons.star_border;
    }
  }
}
