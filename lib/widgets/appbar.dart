import 'package:flutter/material.dart';

customAppBar(BuildContext context, String title) {
  return PreferredSize(
    child: Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            spreadRadius: 0.0,
            blurRadius: 5.0,
            color: Colors.black.withOpacity(0.1),
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                Text(
                  '$title',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    preferredSize: Size.fromHeight(MediaQuery.of(context).size.height / 12),
  );
}
