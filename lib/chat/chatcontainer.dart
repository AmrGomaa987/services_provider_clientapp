import 'package:clientphase/models/service_model.dart';
import 'package:flutter/material.dart';
import 'package:clientphase/chat/user_chat.dart';

class chatContainer extends StatefulWidget {
  final UserChat service;
  final Function onTap;

  chatContainer({Key? key, required this.service, required this.onTap}) : super(key: key);

  @override
  _ChatContainerState createState() => _ChatContainerState();
}

class _ChatContainerState extends State<chatContainer> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
      },
      child: Container(
       padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        margin: EdgeInsets.symmetric(vertical: 4.0), // Reduced margin
        width: MediaQuery.of(context).size.width * 0.85, // Reduced width
         decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
         
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
         Padding(
  padding: const EdgeInsets.only(top: 5, right: 5,bottom: 5),
  child:widget.service.image != null
      ? CircleAvatar(
          radius: 30,
          backgroundColor: Colors.transparent,
          child: ClipOval(
            child: Image.network(
              widget.service.image!,
              fit: BoxFit.cover,
              errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                return Container(
                  color: Colors.grey,
                  child: Icon(Icons.person, color: Colors.white),
                );
              },
              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                        : null,
                  ),
                );
              },
            ),
          ),
        )
      : CircleAvatar(
          backgroundColor: Colors.grey,
          radius: 30,
          child: Icon(Icons.person, color: Colors.white),
        ),
),
 SizedBox(width: 10),
         Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text(
                    widget.service.name ?? 'Unknown', // Default placeholder name
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
