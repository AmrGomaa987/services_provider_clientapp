import 'package:flutter/material.dart';

class CounterContainer extends StatefulWidget {
  CounterContainer(this.serviceName, this.wid, this.wid1);

  String serviceName;

  double wid;
  double wid1;

  @override
  _CounterContainerState createState() => _CounterContainerState();
}

class _CounterContainerState extends State<CounterContainer> {
  int quantity = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40), // Make it circular
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Text(
              '${widget.serviceName}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          SizedBox(width: widget.wid),
          GestureDetector(
            onTap: () {
              setState(() {
                quantity = quantity > 0 ? quantity - 1 : 0;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 30.0),
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black12,
                ),
                child: Icon(
                  Icons.remove,
                  color: Color(0xFF7210ff),
                ),
              ),
            ),
          ),
          SizedBox(width: widget.wid1),
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Text(
              '$quantity',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(width: 2),
          GestureDetector(
            onTap: () {
              setState(() {
                quantity = quantity + 1;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black12,
                ),
                child: Icon(
                  Icons.add,
                  color: Color(0xFF7210ff),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
