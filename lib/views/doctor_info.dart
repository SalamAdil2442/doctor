import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rate_in_stars/rate_in_stars.dart';
import 'package:tandrustito/core/alert/confirm_alert.dart';
import 'package:tandrustito/core/shared/imports.dart';
import 'package:tandrustito/core/shared/theme_lang_notifier.dart';
import 'package:tandrustito/features/doctors/presentation/controllers/favs_controller.dart';
import 'package:tandrustito/features/doctors/presentation/view/create_edit_general.dart';
import 'package:tandrustito/features/specialiests/precentation/controller/specialiests_controller.dart';
import 'package:tandrustito/gen/assets.gen.dart';
import 'package:tandrustito/localization/translate_keys.dart';
import 'package:tandrustito/model/general_model.dart';
import 'package:tandrustito/views/home.dart';
import 'package:tandrustito/views/map_luncher.dart';
import 'package:tandrustito/views/net_image.dart';
import 'package:url_launcher/url_launcher.dart';

class DoctorsInfo extends StatefulWidget {
  const DoctorsInfo(
      {super.key,
      required this.model,
      required this.elementType,
      required this.index});
  final String index;
  final ElementType elementType;
  final GeneralModel model;
  @override
  _DoctorsInfoState createState() => _DoctorsInfoState();
}

class _DoctorsInfoState extends State<DoctorsInfo> {
  @override
  Widget build(BuildContext context) {
    _availDayBox(String day, bool avail) {
      return Opacity(
        opacity: avail ? 1 : 0.35,
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(8),
          height: 80,
          width: 60,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 2, color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [const BoxShadow()]),
          child: Text(
            day,
          ),
        ),
      );
    }

    return Consumer<ThemeLangNotifier>(
        builder: (context, themeLangNotifier, child) {
      return Scaffold(
        backgroundColor: scaffoldColor,
        floatingActionButton:
            Consumer<FavsNotifier>(builder: (context, myType, child) {
          bool isFaved = myType.isFaved(widget.model.id, widget.elementType);

          return GestureDetector(
            onTap: () {
              if (!isFaved) {
                myType.add(widget.elementType, widget.model);
              } else {
                myType.delete(widget.model.id, widget.elementType);
              }
            },
            child: Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(blurRadius: 5, color: Colors.black26)
                    ]),
                child: Icon(
                  isFaved ? Icons.favorite : Icons.favorite_border,
                  color: primaryColor,
                  size: 30,
                )),
          );
        }),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Color.fromARGB(255, 8, 167, 114),
              child: SafeArea(
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      child: const BackButton(color: Colors.white),
                    ),
                    const Spacer(),
                    if (canEdit)
                      PopupMenuButton<PopUpActions>(
                        tooltip: Trans.moreOptions.trans(context: context),
                        onSelected: (value) async {
                          logger(value);
                          if (value == PopUpActions.delete) {
                            final res = await getConfirm(
                                desc: Trans.areYouSureToDeleteThisData.trans(
                                    args: [widget.elementType.name.trans()]));
                            if (res == true) {
                              getGeneralNotifier(widget.elementType)
                                  ?.delete(widget.model.id, 1);
                            }
                          } else if (value == PopUpActions.edit) {
                            context.to(CreateEditDoctor(
                              model: widget.model,
                              elementType: widget.elementType,
                            ));
                          } else if (value == PopUpActions.addToReklame) {
                            getGeneralNotifier(widget.elementType)?.edit(
                                widget.model.copyWith(isAdd: true),
                                0,
                                widget.elementType);
                          } else if (value == PopUpActions.removeToReklame) {
                            getGeneralNotifier(widget.elementType)?.edit(
                                widget.model.copyWith(isAdd: false),
                                0,
                                widget.elementType);
                          }
                        },
                        itemBuilder: (context) => [
                          PopupMenuItem(
                              value: PopUpActions.delete,
                              child:
                                  Text(Trans.delete.trans(context: context))),
                          PopupMenuItem(
                              value: PopUpActions.edit,
                              child: Text(Trans.edit.trans(context: context))),
                          if (widget.model.isAdd == false)
                            PopupMenuItem(
                                value: PopUpActions.addToReklame,
                                child: Text(Trans.addToReklams
                                    .trans(context: context))),
                          if (widget.model.isAdd == true)
                            PopupMenuItem(
                                value: PopUpActions.removeToReklame,
                                child: Text(Trans.removeToReklame
                                    .trans(context: context))),
                        ],
                      ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ScrollConfiguration(
                behavior: MyBehavior(),
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                      forceElevated: true,
                      elevation: 14,
                      automaticallyImplyLeading: false,
                      stretch: true,
                      expandedHeight: 75,
                      backgroundColor: Color.fromARGB(255, 8, 167, 114),
                      flexibleSpace: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        child: Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Hero(
                                tag: widget.index,
                                child: ImageChecker(
                                    radius: 16,
                                    linkImage: widget.model.image,
                                    height: 120,
                                    fit: BoxFit.contain),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    getNames(widget.model.name),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    getNames(CategoriesNotifer.instance
                                        .map[widget.model.specialiestId]?.name),
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      RatingStars(
                                        editable: false,
                                        rating: widget.model.rate.toDouble(),
                                        color: Colors.amber,
                                        iconSize: 18.sp,
                                      ),
                                      Text(
                                        "${widget.model.rate}",
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const SizedBox(height: 24),
                            Text(
                              Trans.about.trans(context: context),
                              style: const TextStyle(fontSize: 20),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              getNames(widget.model.about),
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                            const SizedBox(height: 48),
                            IntrinsicHeight(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    '${Trans.practiceDays.trans(context: context)}:',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          formatWorkTime(
                                              widget.model.workingHours),
                                          style: const TextStyle(
                                              height: 1, color: Colors.grey),
                                        ),
                                        SizedBox(height: 5),
                                        SizedBox(
                                          height: 100,
                                          child: ListView(
                                            scrollDirection: Axis.horizontal,
                                            children: [
                                              _availDayBox(
                                                Trans.sat.toUpperCase(),
                                                widget.model.availableDays.sat,
                                              ),
                                              _availDayBox(
                                                Trans.sun.toUpperCase(),
                                                widget.model.availableDays.sun,
                                              ),
                                              _availDayBox(
                                                Trans.mon.toUpperCase(),
                                                widget.model.availableDays.mon,
                                              ),
                                              _availDayBox(
                                                Trans.tues.toUpperCase(),
                                                widget.model.availableDays.tues,
                                              ),
                                              _availDayBox(
                                                Trans.wed.toUpperCase(),
                                                widget.model.availableDays.wed,
                                              ),
                                              _availDayBox(
                                                Trans.thu.toUpperCase(),
                                                widget.model.availableDays.thu,
                                              ),
                                              _availDayBox(
                                                Trans.fri.toUpperCase(),
                                                widget.model.availableDays.fri,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                            getDayClass(
                                                widget.model.availableDays),
                                            style: TextStyle(
                                                height: 1, color: Colors.grey)),
                                        SizedBox(height: 5),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 48),
                            ...[
                              // Text(
                              //     '${Trans.contactInformations.trans(context: context)}: ',
                              //     style: const TextStyle(fontSize: 20)),
                              // const SizedBox(height: 20),
                              // IconTile(
                              //     backColor: const Color(0xffFEF2F0),
                              //     phoneNumber: widget.model.phone,
                              //     imgAssetPath: Assets.images.call.path),
                              // const SizedBox(height: 10),
                              // IconTile(
                              //     backColor: const Color(0xffFEF2F0),
                              //     phoneNumber: widget.model.mobile,
                              //     imgAssetPath: Assets.images.call.path),
                              // const SizedBox(height: 10),
                              // IconTile(
                              //     backColor: const Color(0xffFEF2F0),
                              //     phoneNumber: widget.model.email,
                              //     imgAssetPath: Assets.images.email.path),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: 150,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          side: BorderSide(
                                              color:
                                                  Colors.grey.withOpacity(0.5)),
                                        ),
                                        onPressed: () {
                                          // handle phone button press
                                          launch('tel:${widget.model.phone}');
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.phone,
                                              color: Color.fromARGB(
                                                  255, 8, 167, 114),
                                            ),
                                            SizedBox(width: 10),
                                            Text(widget.model.phone,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 10)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  SizedBox(
                                    width: 150,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        side: BorderSide(
                                            color:
                                                Colors.grey.withOpacity(0.5)),
                                      ),
                                      onPressed: () {
                                        // handle mobile button press
                                        launch('tel:${widget.model.mobile}');
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.phone,
                                            color: Color.fromARGB(
                                                255, 8, 167, 114),
                                          ),
                                          SizedBox(width: 10),
                                          Text(widget.model.mobile,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 10)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    side: BorderSide(
                                        color: Colors.grey.withOpacity(0.5)),
                                  ),
                                  onPressed: () {
                                    // handle email button press
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.email, color: Colors.blue),
                                      SizedBox(width: 10),
                                      Text(widget.model.email,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 10)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                            const SizedBox(height: 48),
                            GestureDetector(
                              onTap: () {
                                showOpenWithMapBottomSheet(
                                    context: context,
                                    title: getNames(widget.model.name),
                                    lat: widget.model.latitude,
                                    long: widget.model.longitude);
                              },
                              child: IntrinsicHeight(
                                child: Container(
                                  color: Colors.transparent,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              '${Trans.address.trans(context: context)}: ',
                                              style: const TextStyle(
                                                  height: 1, fontSize: 20),
                                            ),
                                            SizedBox(height: 5.h),
                                            Text(
                                              '${widget.model.city?.trans()} - ${getNames(widget.model.address)}',
                                              maxLines: 4,
                                              softWrap: true,
                                              style: const TextStyle(
                                                  height: 1,
                                                  color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 16),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(Trans.location.trans(context: context),
                                      style: const TextStyle(fontSize: 20))
                                ]),
                            SizedBox(height: 24),
                            MapWidget(
                              isEditable: false,
                              latitude: widget.model.latitude,
                              longitude: widget.model.longitude,
                              getLocation: (p0) {},
                              title: Trans.location.trans(),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).padding.bottom + 32),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class IconTile extends StatelessWidget {
  final String imgAssetPath;
  final String phoneNumber;
  final Color backColor;

  const IconTile(
      {super.key,
      required this.imgAssetPath,
      required this.phoneNumber,
      required this.backColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 40.sp,
          width: 40.sp,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(7)),
          child: Image.asset(
            imgAssetPath,
            color: Color.fromARGB(255, 8, 167, 114),
            width: 25.sp,
            height: 25.sp,
          ),
        ),
        SizedBox(width: 10.w),
        Text(
          phoneNumber,
          style: TextStyle(height: 1.1, fontSize: 16.sp),
        )
      ],
    );
  }
}

enum PopUpActions { edit, delete, addToReklame, removeToReklame }
