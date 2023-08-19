import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:tandrustito/core/shared/imports.dart';
import 'package:tandrustito/core/shared/theme_lang_notifier.dart';
import 'package:tandrustito/features/doctors/presentation/controllers/doctors_controller.dart';
import 'package:tandrustito/features/specialiests/precentation/controller/specialiests_controller.dart';
import 'package:tandrustito/localization/translate_keys.dart';
import 'package:tandrustito/views/admin/login_screen.dart';
import 'package:tandrustito/views/genera_button.dart';
import 'package:tandrustito/views/home.dart';
import 'package:tandrustito/views/new_detail_of_doctors_edit.dart';
import 'package:tandrustito/views/profile.dart';
import 'package:tandrustito/views/select_lang.dart';
import 'package:tandrustito/views/support_screen.dart';
import 'about_screen.dart';

class profile_screen extends StatefulWidget {
  const profile_screen({Key? key}) : super(key: key);
  @override
  State<profile_screen> createState() => _profile_screenState();
}

class _profile_screenState extends State<profile_screen> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      CategoriesNotifer.instance.getData();
      DoctorsNotifer.instance.getData();
      LabsNotifer.instance.getData();
      PharmaciesNotifer.instance.getData();
    });
  }

  int count = 0;
  @override
  Widget build(BuildContext context) {
    Responsive.init(context, designSize: const Size(414, 896));
    return Consumer<ThemeLangNotifier>(builder: (context, myType, child) {
      return AnimatedSwitcher(
          duration: const Duration(milliseconds: 100),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(
                alwaysIncludeSemantics: false,
                opacity: animation,
                child: child);
          },
          child: Column(children: [
            AppBar(
              title: Center(
                child: Text(Trans.settings.trans(context: context)),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: ListTile(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return about_screen();
                            },
                          ));
                        },
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1,
                            color: Color.fromARGB(255, 8, 167, 114),
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        title: Text(
                          Trans.about.trans(context: context),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward,
                          color: Color.fromARGB(255, 8, 167, 114),
                        ),
                        leading: Icon(
                          Icons.report,
                          color: Color.fromARGB(255, 8, 167, 114),
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: ListTile(

                        //put down your screen kaka
                        //add translate key
                        title: Text(Trans.contactus.trans(context: context)),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return support_screen();
                            },
                          ));
                        },
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1,
                            color: Color.fromARGB(255, 8, 167, 114),
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward,
                          color: Color.fromARGB(255, 8, 167, 114),
                        ),

                        // add translate_key
                        leading: Icon(
                          Icons.call,
                          color: Color.fromARGB(255, 8, 167, 114),
                        )),
                  ),
                  SizedBox(
                    height: 90.sp,
                  ),
                  //logo
                  Center(
                    child: Image.asset(
                      "assets/images/logohelth.jpg",
                      width: MediaQuery.of(context).size.width,
                    ),
                  )
                ],
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                NewWidget(),
                isLogin
                    ? Container()
                    : Padding(
                        padding: EdgeInsets.all(8.0),
                        child: count != 4
                            ? Container(
                                height: 35,
                              )
                            : GeneralButton(
                                onTap: () async {
                                  await loginForm();
                                },
                                text: Trans.login.trans(context: context),
                              ),
                      ),
              ],
            ),
          ]));
    });
  }
}
