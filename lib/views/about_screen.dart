import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tandrustito/views/home.dart';

import '../localization/translate_keys.dart';

class about_screen extends StatefulWidget {
  const about_screen({super.key});

  @override
  State<about_screen> createState() => _about_screenState();
}

class _about_screenState extends State<about_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 8, 167, 114),
          title: Text(Trans.about.trans(context: context),
              style: TextStyle(color: Colors.white))),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: ListView(
            //add translate_key about applications kak rawa
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  Trans.aboutdetail.trans(context: context),
                  style: TextStyle(overflow: TextOverflow.visible),
                ),
              ),
            ]),
      ),
    );
  }
}
