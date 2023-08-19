// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/healthicons.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:iconify_flutter/icons/medical_icon.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:tandrustito/core/alert/enter_name.dart';
import 'package:tandrustito/core/cities.dart';
import 'package:tandrustito/core/shared/close_keyboard.dart';
import 'package:tandrustito/core/shared/imports.dart';
import 'package:tandrustito/features/chats/data_source/remote_chat.dart';
import 'package:tandrustito/features/chats/view/chat_screen.dart';
import 'package:tandrustito/features/chats/view/clietns_screen.dart';
import 'package:tandrustito/features/doctors/presentation/controllers/doctors_controller.dart';
import 'package:tandrustito/features/doctors/presentation/controllers/doctors_controllercopy.dart';
import 'package:tandrustito/features/doctors/presentation/view/create_edit_general.dart';
import 'package:tandrustito/features/reklams/controller/reklam_notifier.dart';
import 'package:tandrustito/gen/assets.gen.dart';
import 'package:tandrustito/localization/translate_keys.dart';
import 'package:tandrustito/model/general_model.dart';
import 'package:tandrustito/views/city_picker.dart';
import 'package:tandrustito/views/doctor_widget.dart';
import 'package:tandrustito/views/forms_widget/text_filed.dart';
import 'package:tandrustito/views/profile.dart';
import 'package:tandrustito/views/slider.dart';
import 'package:tandrustito/views/status_widgets/failure_screen.dart';
import 'package:tandrustito/views/status_widgets/loading_widget.dart';
import 'package:tandrustito/views/time.dart';

import '../model/days_model.dart';
import '../model/names_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.index});
  final int index;

  @override
  _HomePageState createState() => _HomePageState();
}

const Color scaffoldColor = Color(0xFFF5F5F5);
const Color primaryColor = Color.fromARGB(255, 8, 167, 114);
const Color openColor = Color(0xFFC9DFF7);

class _HomePageState extends State<HomePage> {
  int index = 0;
  int indexbottom = 0;
  int? selectedSpeciality;
  List<String> indexspeciality = ['no', 'no'];

  @override
  Future<void> onrefresh() async {
    Future.wait(
      [
        DoctorsNotifer.instance.refresh(),
        PharmaciesNotifer.instance.refresh(),
        LabsNotifer.instance.refresh(),
        SettingsNotifer.instance.refresh(),
      ],
    );
  }

  // colum data
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      DoctorsNotifer.instance.getData();
      PharmaciesNotifer.instance.getData();
      LabsNotifer.instance.getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isReklamListEmpty(int index, BuildContext context) => context
        .read<ReklamNotifiers>()
        .list
        .where((element) =>
            element.elementType ==
            (index == 0
                ? ElementType.doctor
                : index == 1
                    ? ElementType.pharmacy
                    : index == 2
                        ? ElementType.laboratory
                        : ElementType.settings))
        .isEmpty;
    filterSpeciality(specialities) {
      if (selectedSpeciality == specialities) {
        selectedSpeciality = null;
      } else {
        selectedSpeciality = specialities;
      }
      [
        DoctorsNotifer.instance,
        PharmaciesNotifer.instance,
        LabsNotifer.instance,
        SettingsNotifer.instance,
      ][index]
          .setSelectedCity(ValueClass(
        cities: [...cities],
        specialiests: specialities,
      ));
      setState(() {});
    }

    specialityBox(String name, String icon, int index, void Function() onTap) {
      return GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              height: 75,
              width: 75,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 15,
                    color: Color.fromARGB(8, 0, 0, 0),
                  )
                ],
                color:
                    selectedSpeciality == index ? primaryColor : Colors.white,
              ),
              child: Center(
                child: SvgPicture.asset(
                  icon,
                  height: selectedSpeciality == index ? 50 : 42.5,
                  color: selectedSpeciality == index
                      ? Colors.white
                      : Color.fromARGB(112, 20, 158, 66),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: 80,
              child: Text(
                name,
                maxLines: 2,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
          ],
        ),
      );
    }

    sectionBox(String name, String icon, int index, void Function() onTap) {
      return GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              height: 75,
              width: 75,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(Radius.circular(15)),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 15,
                    color: Color.fromARGB(8, 0, 0, 0),
                  )
                ],
                color:
                    selectedSpeciality == index ? primaryColor : Colors.white,
              ),
              child: Center(
                child: SvgPicture.asset(
                  icon,
                  height: selectedSpeciality == index ? 50 : 42.5,
                  color: selectedSpeciality == index
                      ? Colors.white
                      : Color.fromARGB(112, 20, 158, 66),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: 80,
              child: Text(
                name,
                maxLines: 2,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
        backgroundColor: scaffoldColor,
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Divider(height: 5),
            const SizedBox(height: 1),
            SalomonBottomBar(
              currentIndex: indexbottom,
              selectedColorOpacity: .1,
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 2),
              onTap: (v) {
                if (v == 1) {
                  setState(() {
                    indexbottom = 1;
                    index = 2;
                    indexspeciality[0] = 'no';
                    indexspeciality[1] = 'no';
                    selectedSpeciality = null;
                    // filterSpec0iality(0);
                  });
                } else {
                  setState(() {
                    index = 0;
                    indexbottom = 0;
                    indexspeciality[0] = 'no';
                    indexspeciality[1] = 'no';
                    selectedSpeciality = null;
                  });
                }

                setState(() {});
              },
              items: [
                SalomonBottomBarItem(
                  unselectedColor: primaryColor,
                  icon: Padding(
                    padding: EdgeInsets.all(3.0),
                    child: Icon(
                      Icons.home,
                      size: 25,
                      color: index != 0 ? primaryColor : primaryColor,
                    ),
                  ),
                  title: Text(Trans.home.trans(context: context),
                      style: TextStyle(height: 1)),
                  selectedColor: primaryColor,
                ),
                SalomonBottomBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Icon(
                      Icons.settings,
                      size: 25,
                      color: index != 3 ? primaryColor : primaryColor,
                    ),
                  ),
                  unselectedColor: primaryColor,
                  title: Text(Trans.settings.trans(context: context),
                      style: const TextStyle(height: 1)),
                  selectedColor: primaryColor,
                ),
              ],
            ),
            SizedBox(height: 1),
          ],
        ),
        body: indexbottom != 1
            ? RefreshIndicator(
                onRefresh: onrefresh,
                displacement: 250,
                color: Colors.red,
                strokeWidth: 3,
                triggerMode: RefreshIndicatorTriggerMode.onEdge,
                child: CustomScrollView(
                    scrollBehavior: MyBehavior(),
                    slivers: <Widget>[
                      index == 0 && indexbottom == 0
                          ? SliverToBoxAdapter()
                          : SliverAppBar(
                              leading: const SizedBox(),
                              expandedHeight:
                                  index == 0 && indexbottom == 0 ? 0 : 150.0,
                              floating: true,
                              pinned: true,
                              foregroundColor: Colors.transparent,
                              surfaceTintColor: Colors.transparent,
                              flexibleSpace: FlexibleSpaceBar(
                                background: Stack(
                                  children: [
                                    Container(
                                      color: index == 0 && indexbottom == 0
                                          ? Color.fromARGB(255, 245, 244, 244)
                                          : primaryColor,
                                    ),
                                    SafeArea(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12),
                                              child: const BackButton(
                                                color: Colors.white,
                                              )),
                                          Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12),
                                              child: IconButton(
                                                icon: const Icon(
                                                  Icons.notifications_outlined,
                                                  color: Colors.white,
                                                ),
                                                onPressed: () {},
                                              )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ), //awa chia kaka ??
                                centerTitle: false,
                                titlePadding: indexbottom == 0
                                    ? const EdgeInsets.only(
                                        bottom: 5, left: 20, right: 20, top: 20)
                                    : const EdgeInsets.only(
                                        bottom: 20,
                                        left: 20,
                                        right: 20,
                                        top: 10),
                                title: Text(
                                  <String>[
                                    indexbottom == 0
                                        ? indexspeciality[0] != 'no'
                                            ? indexspeciality[1]
                                            : Trans.home.trans(context: context)
                                        : indexspeciality[0] != 'no'
                                            ? indexspeciality[1]
                                            : Trans.doctors
                                                .trans(context: context),
                                    Trans.pharmacies.trans(context: context),
                                    Trans.laboratories.trans(context: context)
                                  ][index],
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                      SliverAppBar(
                        pinned: true,
                        elevation: 0,
                        expandedHeight: 0,
                        toolbarHeight: index == 0 && indexbottom == 0 ? 0 : 10,
                        leading: const SizedBox(),
                        backgroundColor: Colors.transparent,
                        flexibleSpace: Stack(
                          children: [
                            Container(
                              height: 25,
                              color: primaryColor,
                            ),
                            index == 0 && indexbottom == 0
                                ? Container()
                                : Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    decoration: const BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 35,
                                            color: Colors.black26,
                                            offset: Offset(0, 20))
                                      ],
                                    ),
                                    //search
                                    child: indexbottom == 0
                                        ? Container()
                                        : Row(
                                            children: [
                                              Expanded(
                                                child: GeneralTextFiled(
                                                  fillColor: Color.fromARGB(
                                                      255, 245, 244, 244),
                                                  viewBorder: false,
                                                  controller: [
                                                    DoctorsNotifer.instance,
                                                    PharmaciesNotifer.instance,
                                                    LabsNotifer.instance,
                                                    SettingsNotifer.instance,
                                                  ][index]
                                                      .textEditingController,
                                                  contentPadding:
                                                      const EdgeInsets
                                                              .symmetric(
                                                          vertical: 10,
                                                          horizontal: 20),
                                                  raduis: 12,
                                                  readOnly: false,
                                                  onChange: (p0) {
                                                    logger("p0 $p0");
                                                    setState(() {});
                                                    setState(() {});
                                                    setState(() {});
                                                  },
                                                  onTap: () {},
                                                  hintText: Trans.search
                                                      .trans(context: context),
                                                  prefixIcon: Container(
                                                    margin:
                                                        const EdgeInsets.all(3),
                                                    child: const Icon(
                                                        Icons.search),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                  ),
                          ],
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 250),
                          transitionBuilder:
                              (Widget child, Animation<double> animation) {
                            final offsetAnimation = Tween<Offset>(
                              begin: const Offset(0.0,
                                  -1.0), // Move the widget from below the screen
                              end: const Offset(0.0,
                                  0.0), // Move the widget to its original position
                            ).animate(animation);

                            final fadeAnimation = Tween<double>(
                              begin: 0.0, // Fully transparent
                              end: 1.0, // Fully opaque
                            ).animate(animation);

                            return FadeTransition(
                              opacity: fadeAnimation,
                              child: SlideTransition(
                                position: offsetAnimation,
                                child: child,
                              ),
                            );
                          },
                          child: indexbottom == 0
                              ? index != 0
                                  ? Container()
                                  : indexspeciality[0] == 'no'
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5,
                                                      vertical: 12),
                                              child: Text(
                                                Trans.specialities
                                                    .trans(context: context),
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            // Text("data"),
                                            SizedBox(height: 12),
                                            SizedBox(
                                              height: 150,
                                              child: ListView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16),
                                                shrinkWrap: true,
                                                children: [
                                                  sectionBox(
                                                    Trans.doctorsoffer.trans(
                                                        context: context),
                                                    '$iconsPath/category/doctor.svg',
                                                    100,
                                                    () {
                                                      // filterSpeciality(38);
                                                      setState(() {
                                                        index = 0;
                                                        indexbottom = 2;
                                                        indexspeciality[0] =
                                                            'no';
                                                        indexspeciality[1] =
                                                            'no';
                                                      });
                                                    },
                                                  ),
                                                  const SizedBox(width: 20),
                                                  InkWell(
                                                    onTap: () {},
                                                    child: sectionBox(
                                                      Trans.laboratories.trans(
                                                          context: context),
                                                      '$iconsPath/category/labs.svg',
                                                      101,
                                                      () {
                                                        // filterSpeciality(39);
                                                        setState(() {
                                                          index = 2;
                                                          indexbottom = 3;
                                                          indexspeciality[0] =
                                                              'no';
                                                          indexspeciality[1] =
                                                              'no';
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                  const SizedBox(width: 20),
                                                  sectionBox(
                                                    Trans.pharmacies.trans(
                                                        context: context),
                                                    '$iconsPath/category/pharmacy.svg',
                                                    102,
                                                    () {
                                                      // filterSpeciality(40);
                                                      setState(() {
                                                        index = 1;
                                                        indexbottom = 4;
                                                        indexspeciality[0] =
                                                            'no';
                                                        indexspeciality[1] =
                                                            'no';
                                                      });
                                                    },
                                                  ),
                                                  const SizedBox(width: 20),
                                                  const SizedBox(width: 20),
                                                  const SizedBox(width: 20),
                                                  const SizedBox(width: 20),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      : Container()
                              : Container(),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 250),
                          transitionBuilder:
                              (Widget child, Animation<double> animation) {
                            final offsetAnimation = Tween<Offset>(
                              begin: const Offset(0.0,
                                  -1.0), // Move the widget from below the screen
                              end: const Offset(0.0,
                                  0.0), // Move the widget to its original position
                            ).animate(animation);

                            final fadeAnimation = Tween<double>(
                              begin: 0.0, // Fully transparent
                              end: 1.0, // Fully opaque
                            ).animate(animation);

                            return FadeTransition(
                              opacity: fadeAnimation,
                              child: SlideTransition(
                                position: offsetAnimation,
                                child: child,
                              ),
                            );
                          },
                          child: index != 0 && indexbottom != 2
                              ? Container()
                              : indexspeciality[0] == 'no'
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 12),
                                          child: Text(
                                            Trans.specialities
                                                .trans(context: context),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        // Text("data"),
                                        SizedBox(height: 12),
                                        SizedBox(
                                          height: 150,
                                          child: ListView(
                                            scrollDirection: Axis.horizontal,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16),
                                            shrinkWrap: true,
                                            children: [
                                              specialityBox(
                                                Trans.dental
                                                    .trans(context: context),
                                                '$iconsPath/dental.svg',
                                                38,
                                                () {
                                                  filterSpeciality(38);
                                                  setState(() {
                                                    indexspeciality[0] =
                                                        '${38}';
                                                    indexspeciality[1] =
                                                        Trans.dental.trans(
                                                            context: context);
                                                    index = 0;
                                                    indexbottom = 2;
                                                  });
                                                },
                                              ),
                                              const SizedBox(width: 20),
                                              InkWell(
                                                onTap: () {},
                                                child: specialityBox(
                                                  Trans.heart
                                                      .trans(context: context),
                                                  '$iconsPath/heart.svg',
                                                  39,
                                                  () {
                                                    filterSpeciality(39);
                                                    setState(() {
                                                      indexspeciality[0] =
                                                          '${39}';
                                                      indexspeciality[1] =
                                                          Trans.heart.trans(
                                                              context: context);
                                                      index = 0;
                                                      indexbottom = 2;
                                                    });
                                                  },
                                                ),
                                              ),
                                              const SizedBox(width: 20),
                                              specialityBox(
                                                Trans.eyes
                                                    .trans(context: context),
                                                '$iconsPath/eye.svg',
                                                40,
                                                () {
                                                  filterSpeciality(40);
                                                  setState(() {
                                                    indexspeciality[0] =
                                                        '${40}';
                                                    indexspeciality[1] =
                                                        Trans.eyes.trans(
                                                            context: context);
                                                    index = 0;
                                                    indexbottom = 2;
                                                  });
                                                },
                                              ),
                                              const SizedBox(width: 20),
                                              specialityBox(
                                                Trans.brain
                                                    .trans(context: context),
                                                '$iconsPath/brain.svg',
                                                41,
                                                () {
                                                  filterSpeciality(41);
                                                  setState(() {
                                                    indexspeciality[0] =
                                                        '${41}';
                                                    indexspeciality[1] =
                                                        Trans.brain.trans(
                                                            context: context);
                                                    index = 0;
                                                    indexbottom = 2;
                                                  });
                                                },
                                              ),
                                              const SizedBox(width: 20),
                                              specialityBox(
                                                Trans.ears
                                                    .trans(context: context),
                                                '$iconsPath/ear.svg',
                                                42,
                                                () {
                                                  filterSpeciality(42);
                                                  setState(() {
                                                    indexspeciality[0] =
                                                        '${42}';
                                                    indexspeciality[1] =
                                                        Trans.ears.trans(
                                                            context: context);
                                                    index = 0;
                                                    indexbottom = 2;
                                                  });
                                                },
                                              ),
                                              const SizedBox(width: 20),
                                              specialityBox(
                                                Trans.baby
                                                    .trans(context: context),
                                                '$iconsPath/baby.svg',
                                                43,
                                                () {
                                                  filterSpeciality(43);
                                                  setState(() {
                                                    indexspeciality[0] =
                                                        '${43}';
                                                    indexspeciality[1] =
                                                        Trans.baby.trans(
                                                            context: context);
                                                    index = 0;
                                                    indexbottom = 2;
                                                  });
                                                },
                                              ),
                                              const SizedBox(width: 20),
                                              specialityBox(
                                                Trans.sonarandradiology
                                                    .trans(context: context),
                                                '$iconsPath/sonar.svg',
                                                44,
                                                () {
                                                  filterSpeciality(44);
                                                  setState(() {
                                                    indexspeciality[0] =
                                                        '${44}';
                                                    indexspeciality[1] = Trans
                                                        .sonarandradiology
                                                        .trans(
                                                            context: context);
                                                    index = 0;
                                                    indexbottom = 2;
                                                  });
                                                },
                                              ),
                                              const SizedBox(width: 20),
                                              specialityBox(
                                                Trans.bone
                                                    .trans(context: context),
                                                '$iconsPath/bone.svg',
                                                45,
                                                () {
                                                  filterSpeciality(45);
                                                  setState(() {
                                                    indexspeciality[0] =
                                                        '${45}';
                                                    indexspeciality[1] =
                                                        Trans.bone.trans(
                                                            context: context);
                                                    index = 0;
                                                    indexbottom = 2;
                                                  });
                                                },
                                              ),
                                              const SizedBox(width: 20),
                                              specialityBox(
                                                Trans.cancer
                                                    .trans(context: context),
                                                '$iconsPath/cancer.svg',
                                                46,
                                                () {
                                                  filterSpeciality(46);
                                                  setState(() {
                                                    indexspeciality[0] =
                                                        '${46}';
                                                    indexspeciality[1] =
                                                        Trans.cancer.trans(
                                                            context: context);
                                                    index = 0;
                                                    indexbottom = 2;
                                                  });
                                                },
                                              ),
                                              const SizedBox(width: 20),
                                              specialityBox(
                                                Trans.chiropractic
                                                    .trans(context: context),
                                                '$iconsPath/chiropractic.svg',
                                                47,
                                                () {
                                                  filterSpeciality(47);
                                                  setState(() {
                                                    indexspeciality[0] =
                                                        '${47}';
                                                    indexspeciality[1] = Trans
                                                        .chiropractic
                                                        .trans(
                                                            context: context);
                                                    index = 0;
                                                    indexbottom = 2;
                                                  });
                                                },
                                              ),
                                              const SizedBox(width: 20),
                                              specialityBox(
                                                Trans.homedoc
                                                    .trans(context: context),
                                                '$iconsPath/doctor.svg',
                                                48,
                                                () {
                                                  filterSpeciality(48);
                                                  setState(() {
                                                    indexspeciality[0] =
                                                        '${48}';
                                                    indexspeciality[1] =
                                                        Trans.homedoc.trans(
                                                            context: context);
                                                    index = 0;
                                                    indexbottom = 2;
                                                  });
                                                },
                                              ),
                                              const SizedBox(width: 20),
                                              specialityBox(
                                                Trans.femaledoc
                                                    .trans(context: context),
                                                '$iconsPath/female.svg',
                                                49,
                                                () {
                                                  filterSpeciality(49);
                                                  setState(() {
                                                    indexspeciality[0] =
                                                        '${49}';
                                                    indexspeciality[1] =
                                                        Trans.femaledoc.trans(
                                                            context: context);
                                                    index = 0;
                                                    indexbottom = 2;
                                                  });
                                                },
                                              ),
                                              const SizedBox(width: 20),
                                              specialityBox(
                                                Trans.kidney
                                                    .trans(context: context),
                                                '$iconsPath/kidney.svg',
                                                50,
                                                () {
                                                  filterSpeciality(50);
                                                  setState(() {
                                                    indexspeciality[0] =
                                                        '${50}';
                                                    indexspeciality[1] =
                                                        Trans.kidney.trans(
                                                            context: context);
                                                    index = 0;
                                                    indexbottom = 2;
                                                  });
                                                },
                                              ),
                                              const SizedBox(width: 20),
                                              specialityBox(
                                                Trans.mental
                                                    .trans(context: context),
                                                '$iconsPath/mental.svg',
                                                51,
                                                () {
                                                  filterSpeciality(51);
                                                  setState(() {
                                                    indexspeciality[0] =
                                                        '${51}';
                                                    indexspeciality[1] =
                                                        Trans.mental.trans(
                                                            context: context);
                                                    index = 0;
                                                    indexbottom = 2;
                                                  });
                                                },
                                              ),
                                              const SizedBox(width: 20),
                                              specialityBox(
                                                Trans.nutrition
                                                    .trans(context: context),
                                                '$iconsPath/nutrition.svg',
                                                52,
                                                () {
                                                  filterSpeciality(52);
                                                  setState(() {
                                                    indexspeciality[0] =
                                                        '${52}';
                                                    indexspeciality[1] =
                                                        Trans.nutrition.trans(
                                                            context: context);
                                                    index = 0;
                                                    indexbottom = 2;
                                                  });
                                                },
                                              ),
                                              const SizedBox(width: 20),
                                              specialityBox(
                                                Trans.skin
                                                    .trans(context: context),
                                                '$iconsPath/skin.svg',
                                                53,
                                                () {
                                                  filterSpeciality(53);
                                                  setState(() {
                                                    indexspeciality[0] =
                                                        '${53}';
                                                    indexspeciality[1] =
                                                        Trans.skin.trans(
                                                            context: context);

                                                    index = 0;
                                                    indexbottom = 2;
                                                  });
                                                },
                                              ),
                                              const SizedBox(width: 20),
                                              specialityBox(
                                                Trans.stomach
                                                    .trans(context: context),
                                                '$iconsPath/stomach.svg',
                                                54,
                                                () {
                                                  filterSpeciality(54);
                                                  setState(() {
                                                    indexspeciality[0] =
                                                        '${54}';
                                                    indexspeciality[1] =
                                                        Trans.stomach.trans(
                                                            context: context);
                                                    index = 0;
                                                    indexbottom = 2;
                                                  });
                                                },
                                              ),
                                              const SizedBox(width: 20),
                                              specialityBox(
                                                Trans.surgery
                                                    .trans(context: context),
                                                '$iconsPath/surgery.svg',
                                                55,
                                                () {
                                                  filterSpeciality(55);
                                                  setState(() {
                                                    indexspeciality[0] =
                                                        '${55}';
                                                    indexspeciality[1] =
                                                        Trans.surgery.trans(
                                                            context: context);
                                                    index = 0;
                                                    indexbottom = 2;
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  : Container(),
                        ),
                      ),
                      indexspeciality[0] == 'no'
                          ? isReklamListEmpty(index, context)
                              ? SliverToBoxAdapter()
                              : SliverToBoxAdapter(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(16, 0, 16, 12),
                                        child: Text(
                                          'VIP', //Trans.offers.trans(context: context),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0)),
                                        ),
                                      ),
                                      SizedBox(height: 15),
                                    ],
                                  ),
                                )
                          : SliverToBoxAdapter(),
                      indexspeciality[0] == 'no'
                          ? isReklamListEmpty(index, context)
                              ? SliverToBoxAdapter()
                              : Consumer<ReklamNotifiers>(
                                  builder: (context, myType, child) {
                                    return DoctorsPageView(
                                        lists: myType.list
                                            .where((element) =>
                                                element.elementType ==
                                                (index == 0
                                                    ? ElementType.doctor
                                                    : index == 1
                                                        ? ElementType.pharmacy
                                                        : ElementType
                                                            .laboratory))
                                            .toList());
                                  },
                                )
                          : SliverToBoxAdapter(),
                      SliverToBoxAdapter(child: SizedBox(height: 10)),
                      index == 0 && indexbottom == 2
                          ? [
                              DoctrosView(
                                  key: ValueKey(
                                      DateTime.now().toIso8601String())),
                              PharamaciesView(
                                  key: ValueKey(
                                      DateTime.now().toIso8601String())),
                              LabsView(
                                  key: ValueKey(
                                      DateTime.now().toIso8601String())),
                            ][index]
                          : SliverToBoxAdapter(),
                    ]),
              )
            : profile_screen());
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

class DoctrosView extends StatefulWidget {
  const DoctrosView({super.key});

  @override
  State<DoctrosView> createState() => _DoctrosViewState();
}

class _DoctrosViewState extends State<DoctrosView> {
  Future<void> onRefresh() async {
    return await DoctorsNotifer.instance.refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DoctorsNotifer>(
      builder: (context, myType, child) {
        if (myType.status.isLoadingOrInitial) {
          return const SliverToBoxAdapter(child: LoadingWidget());
        }
        if (myType.failure != null) {
          return SliverToBoxAdapter(
              child: FailureScreen(
                  failure: myType.failure!, onRefresh: onRefresh));
        }

        List<GeneralModel> list = filters(myType);

        return SliverList(
            delegate: SliverChildBuilderDelegate(childCount: list.length,
                (context, index) {
          return DoctorWidget(
              elementType: ElementType.doctor,
              index: index,
              model: list[index]);
        }));
      },
    );
  }
}

class LabsView extends StatefulWidget {
  const LabsView({super.key});

  @override
  State<LabsView> createState() => _LabsViewState();
}

class _LabsViewState extends State<LabsView> {
  Future<void> onRefresh() async {
    return await LabsNotifer.instance.refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LabsNotifer>(
      builder: (context, myType, child) {
        if (myType.status.isLoadingOrInitial) {
          return const SliverToBoxAdapter(child: LoadingWidget());
        }
        if (myType.failure != null) {
          return SliverToBoxAdapter(
              child: FailureScreen(
                  failure: myType.failure!, onRefresh: onRefresh));
        }

        List<GeneralModel> list = filters(myType);

        return SliverList(
            delegate: SliverChildBuilderDelegate(childCount: list.length,
                (context, index) {
          return DoctorWidget(
              elementType: ElementType.laboratory,
              index: index,
              model: list[index]);
        }));
      },
    );
  }
}

class PharamaciesView extends StatefulWidget {
  const PharamaciesView({super.key});

  @override
  State<PharamaciesView> createState() => _PharamaciesViewState();
}

class _PharamaciesViewState extends State<PharamaciesView> {
  Future<void> onRefresh() async {
    return await PharmaciesNotifer.instance.refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PharmaciesNotifer>(
      builder: (context, myType, child) {
        if (myType.status.isLoadingOrInitial) {
          return const SliverToBoxAdapter(child: LoadingWidget());
        }
        if (myType.failure != null) {
          return SliverToBoxAdapter(
              child: FailureScreen(
                  failure: myType.failure!, onRefresh: onRefresh));
        }

        List<GeneralModel> list = filters(myType);

        return SliverList(
            delegate: SliverChildBuilderDelegate(childCount: list.length,
                (context, index) {
          return DoctorWidget(
              elementType: ElementType.pharmacy,
              index: index,
              model: list[index]);
        }));
      },
    );
  }
}

// class SettingsView extends StatefulWidget {
//   const SettingsView({super.key});

//   @override
//   State<SettingsView> createState() => _SettingsView();
// }

// class _SettingsView extends State<SettingsView> {
//   Future<void> onRefresh() async {
//     return await SettingsNotifer.instance.refresh();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<SettingsNotifer>(
//       builder: (context, myType, child) {
//         if (myType.status.isLoadingOrInitial) {
//           return const SliverToBoxAdapter(child: LoadingWidget());
//         }
//         if (myType.failure != null) {
//           return SliverToBoxAdapter(
//               child: FailureScreen(
//                   failure: myType.failure!, onRefresh: onRefresh));
//         }

//         List<GeneralModel> list = filters(myType);

//         return SliverList(
//             delegate: SliverChildBuilderDelegate(childCount: list.length,
//                 (context, index) {
//           return DoctorWidget(
//               elementType: ElementType.pharmacy,
//               index: index,
//               model: list[index]);
//         }));
//       },
//     );
//   }
// }

List<GeneralModel> filters(GeneralNotifier generalNotifier) {
  var data = [...generalNotifier.data];
  var upperCasecities =
      generalNotifier.selectedCity.map((e) => e.toLowerCase()).toList();
  var selectedCategory = generalNotifier.selectedCategory;
  data = data
      .where((element) => upperCasecities.contains(element.city?.toLowerCase()))
      .toList();
  data = data
      .where((element) => element.toJson().toLowerCase().contains(
          generalNotifier.textEditingController.text.trim().toLowerCase()))
      .toList();
  if (selectedCategory != 0) {
    data = data
        .where((element) => element.specialiestId == selectedCategory)
        .toList();
  }
  return [...data];
}
