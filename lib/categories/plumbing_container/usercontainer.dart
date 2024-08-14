import 'package:flutter/material.dart';
import 'package:get/get.dart';


class UserReview extends StatelessWidget {
  final String userName;
  final ImageProvider? image;
  final double rating;
  final String reviewText;
  // final String? createdTime;
  // final String? updatedTime;
  final void Function()? onTap;
  final void Function()? onTap1;

  UserReview({
    Key? key,
    required this.userName,
    this.image,
    required this.rating,
    required this.reviewText,
    //  this.createdTime,
    //  this.updatedTime,
    required this.onTap,
    required this.onTap1

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(


      onTap: () {
        
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('خيارات المراجعة'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    ListTile(
                      title: Text('تعديل التعليق'),

                      onTap:onTap,
                    ),
                    ListTile(
                      title: Text('مسح التعليق'),
                      onTap:onTap1,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30 ,width: 25,),
          Row(
            children: [
              SizedBox(height: 35, width: 25),
              Container(
                height: 50,
                width: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey[300],
                ),
                child: image != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image(image: image!, fit: BoxFit.cover),
                      )
                    : Icon(Icons.account_circle, size: 50),
              ),
              SizedBox(width: 8),
              Text(
                userName,
                style: TextStyle(fontSize: 15,),
              ),
              SizedBox(width: 8),
              Row(
                
                children: List.generate(
                  5,
                  (index) => Icon(
                    index < rating
                        ? Icons.star_rate_rounded
                        : Icons.star_rate_outlined,
                    color: index < rating
                        ? Colors.amber
                        : Color.fromARGB(255, 122, 114, 114),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 25.0, top: 16.0),
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                Text(
                  reviewText,
                  style: TextStyle(fontSize: 16),
                ),
                // SizedBox(height: 8),
                // Text(
                //   "Created: $createdTime",
                //   style: TextStyle(fontSize: 10, color: Colors.grey),
                // ),
                // Text(
                //   "Updated: $updatedTime",
                //   style: TextStyle(fontSize: 10, color: Colors.grey),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}