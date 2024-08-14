import 'package:flutter/material.dart';

class ItemService extends StatelessWidget {
  ItemService(
    this.imageUrl,
    this.serviceName, {
    required this.onTap,
  });

  final String imageUrl;
  final String serviceName;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        width: 80,
        height: 105,
        color: Colors.white,
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                onTap();
              },
              child: CircleAvatar(
                radius: 22,
                backgroundColor:
                    Colors.transparent, // Set background color to transparent
                backgroundImage: NetworkImage(imageUrl),
              ),
            ),
            SizedBox(height: 5),
            Expanded(
              child: Center(
                child: Text(
                  serviceName,
                  style: TextStyle(fontSize: 10),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
