import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../localization/translate_keys.dart';
import 'package:url_launcher/url_launcher.dart';

class support_screen extends StatelessWidget {
  get primarycolor => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 8, 167, 114),
          title: Text(Trans.contactus.trans(context: context),
              style: TextStyle(color: Colors.white))),
      body: Align(
        // alignment: Alignment.bottomCenter,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.asset('assets/images/contactus.gif'),
              ),
              Text(Trans.youcancontactusvia.trans(context: context)),
              Center(
                child: TextButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.phone,
                        color: Color.fromARGB(112, 20, 158, 66),
                      ),
                      SizedBox(width: 8),
                      Text(
                        '0783 405 6982',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                  onPressed: () => launch('tel:+9647834056982'),
                ),
              ),
              Center(
                child: TextButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.phone,
                        color: Color.fromARGB(112, 20, 158, 66),
                      ),
                      SizedBox(width: 8),
                      Text(
                        '0751 825 0382',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                  onPressed: () => launch('tel:+9647518250382'),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
        // transformAlignment: Alignment.bottomCenter,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.end,

          children: [
            // SizedBox(height: 10),

            // SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: SvgPicture.asset(
                    'assets/icons/category/insta.svg',
                    color: Colors.black,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.facebook),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.tiktok),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
