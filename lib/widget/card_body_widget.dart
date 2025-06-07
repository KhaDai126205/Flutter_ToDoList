import 'package:flutter/material.dart';

class CardBody extends StatelessWidget {
  CardBody({super.key, required this.item});

  var item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color(0xffDFDFDF),
        borderRadius: BorderRadius.circular(12),
      ),
      width: double.infinity,
      height: 70,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              item.name,
              style: TextStyle(
                fontSize: 20,
                color: Color(0xff484848),
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(Icons.delete_outlined, size: 30, color: Colors.black),
          ],
        ),
      ),
    );
  }
}
