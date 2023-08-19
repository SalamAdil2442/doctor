// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:tandrustito/core/cities.dart';
import 'package:tandrustito/core/shared/imports.dart';
import 'package:tandrustito/core/shared/show_toast.dart';
import 'package:tandrustito/core/shared/theme_lang_notifier.dart';
import 'package:tandrustito/core/shared/validations.dart';
import 'package:tandrustito/features/specialiests/model/specialiests_model.dart';
import 'package:tandrustito/features/specialiests/precentation/controller/specialiests_controller.dart';
import 'package:tandrustito/gen/assets.gen.dart';
import 'package:tandrustito/localization/translate_keys.dart';
import 'package:tandrustito/model/days_model.dart';
import 'package:tandrustito/model/general_model.dart';
import 'package:tandrustito/model/names_model.dart';
import 'package:tandrustito/views/forms_widget/drop_down_text_filed.dart';
import 'package:tandrustito/views/forms_widget/text_filed.dart';
import 'package:tandrustito/views/forms_widget/time_picker.dart';
import 'package:tandrustito/views/full_screen_map.dart';
import 'package:tandrustito/views/genera_button.dart';
import 'package:tandrustito/views/home.dart';
import 'package:tandrustito/views/image_picker.dart';
import 'package:tandrustito/views/net_image.dart';
import 'package:tandrustito/views/time.dart';

class SelectedDays {
  String name;
  bool selected;
  SelectedDays({required this.name, required this.selected});
}

class CreateEditDoctor extends StatefulWidget {
  const CreateEditDoctor({Key? key, this.model, required this.elementType})
      : super(key: key);
  final GeneralModel? model;
  final ElementType elementType;
  @override
  State<CreateEditDoctor> createState() => _CreateEditDoctorState();
}

class _CreateEditDoctorState extends State<CreateEditDoctor> {
  List<SelectedDays> daysData = [
    SelectedDays(name: Trans.all, selected: false),
    SelectedDays(name: Trans.sat, selected: false),
    SelectedDays(name: Trans.sun, selected: false),
    SelectedDays(name: Trans.mon, selected: false),
    SelectedDays(name: Trans.tues, selected: false),
    SelectedDays(name: Trans.wed, selected: false),
    SelectedDays(name: Trans.thu, selected: false),
    SelectedDays(name: Trans.fri, selected: false),
  ];
  bool allOpen = false;

  late TextEditingController nameKu;
  late TextEditingController nameAr;
  late TextEditingController nameEn;
  late TextEditingController aboutKu;
  late TextEditingController aboutAr;
  late TextEditingController aboutEn;
  late TextEditingController addressKu;
  late TextEditingController addressAr;
  late TextEditingController addressEn;
  TimeOfDay? openTime;
  TimeOfDay? cLosingTime;
  String? city;
  double? latitude;
  double? longitude;
  SpecialiestsModel? specialiests;
  bool getSelectedByDay(String dayName) {
    return daysData
            .firstWhereOrNull((element) => element.name == dayName)
            ?.selected ??
        false;
  }

  late TextEditingController email;
  late TextEditingController phone;
  late TextEditingController mobile;
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      ThemeLangNotifier.instance.setFile(null);
    });
    city = widget.model?.city == null
        ? null
        : cities.firstWhereOrNull((element) => element == widget.model?.city);

    latitude = widget.model?.latitude;
    longitude = widget.model?.longitude;
    nameKu = TextEditingController(text: widget.model?.name.kurdish);
    nameAr = TextEditingController(text: widget.model?.name.arabic);
    nameEn = TextEditingController(text: widget.model?.name.english);
    aboutKu = TextEditingController(text: widget.model?.about.kurdish);
    aboutAr = TextEditingController(text: widget.model?.about.arabic);
    aboutEn = TextEditingController(text: widget.model?.about.english);
    addressKu = TextEditingController(text: widget.model?.address.kurdish);
    addressAr = TextEditingController(text: widget.model?.address.arabic);
    addressEn = TextEditingController(text: widget.model?.address.english);

    isOpen24 = widget.model?.workingHours.isOpen24 ?? false;
    openTime = widget.model?.workingHours.openTime;
    cLosingTime = widget.model?.workingHours.closeTime;
    email = TextEditingController(text: widget.model?.email);
    phone = TextEditingController(text: widget.model?.phone);
    mobile = TextEditingController(text: widget.model?.mobile);

    specialiests = CategoriesNotifer.instance.categories.firstWhereOrNull(
        (element) => element.id == widget.model?.specialiestId);

    daysData = [
      SelectedDays(name: Trans.all, selected: false),
      SelectedDays(
          name: Trans.sat, selected: widget.model?.availableDays.sat == true),
      SelectedDays(
          name: Trans.sun, selected: widget.model?.availableDays.sun == true),
      SelectedDays(
          name: Trans.mon, selected: widget.model?.availableDays.mon == true),
      SelectedDays(
          name: Trans.tues, selected: widget.model?.availableDays.tues == true),
      SelectedDays(
          name: Trans.wed, selected: widget.model?.availableDays.wed == true),
      SelectedDays(
          name: Trans.thu, selected: widget.model?.availableDays.thu == true),
      SelectedDays(
          name: Trans.fri, selected: widget.model?.availableDays.fri == true),
    ];
    super.initState();
  }

  bool isOpen24 = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    logger(specialiests);
    logger(CategoriesNotifer.instance.categories);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text(widget.model == null
                ? Trans.create.trans()
                : Trans.edit.trans())),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.bottomLeft,
                        children: [
                          Consumer<ThemeLangNotifier>(
                              builder: (context, myType, child) {
                            return Container(
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: openColor),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(360),
                                child: myType.file == null
                                    ? widget.model?.image != null
                                        ? ImageChecker(
                                            height: 150,
                                            width: 150,
                                            linkImage: widget.model?.image)
                                        : Image.asset(
                                            Assets.images.doctors.path,
                                            height: 150,
                                            width: 150)
                                    : Image.file(myType.file!,
                                        height: 150, width: 150),
                              ),
                            );
                          }),
                          Positioned(
                            bottom: 5,
                            left: 5,
                            child: GestureDetector(
                              onTap: () {
                                selectImage(context);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(7),
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle, color: openColor),
                                child: const Icon(Icons.photo_camera_outlined,
                                    color: Colors.black, size: 28),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Text(Trans.name.trans(),
                        style: const TextStyle(fontSize: 17)),
                  ),
                  GeneralTextFiled(
                    validate: validateName,
                    contentPadding: const EdgeInsets.all(15),
                    showLabel: true,
                    controller: nameKu,
                    hintText: Trans.kurdish.trans(),
                  ),
                  const SizedBox(height: 15),
                  GeneralTextFiled(
                    validate: validateName,
                    contentPadding: const EdgeInsets.all(15),
                    showLabel: true,
                    controller: nameAr,
                    hintText: Trans.arabic.trans(),
                  ),
                  const SizedBox(height: 15),
                  GeneralTextFiled(
                    validate: validateName,
                    contentPadding: const EdgeInsets.all(15),
                    showLabel: true,
                    controller: nameEn,
                    hintText: Trans.english.trans(),
                  ),

                  ////////////////////

                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Text(Trans.about.trans(),
                        style: const TextStyle(fontSize: 17)),
                  ),
                  GeneralTextFiled(
                    validate: validateName,
                    viewBorder: false,
                    showLabel: true,
                    maxLines: null,
                    textInputType: TextInputType.multiline,
                    contentPadding: const EdgeInsets.all(15),
                    controller: aboutKu,
                    hintText: Trans.kurdish.trans(),
                  ),
                  const SizedBox(height: 15),
                  GeneralTextFiled(
                    validate: validateName,
                    viewBorder: false,
                    showLabel: true,
                    maxLines: null,
                    textInputType: TextInputType.multiline,
                    contentPadding: const EdgeInsets.all(15),
                    controller: aboutAr,
                    hintText: Trans.arabic.trans(),
                  ),
                  const SizedBox(height: 15),
                  GeneralTextFiled(
                    validate: validateName,
                    viewBorder: false,
                    showLabel: true,
                    maxLines: null,
                    textInputType: TextInputType.multiline,
                    contentPadding: const EdgeInsets.all(15),
                    controller: aboutEn,
                    hintText: Trans.english.trans(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Text(Trans.address.trans(),
                        style: const TextStyle(fontSize: 17)),
                  ),
                  Column(
                    children: [
                      GeneralTextFiled(
                        validate: validateName,
                        viewBorder: false,
                        showLabel: true,
                        maxLines: null,
                        textInputType: TextInputType.multiline,
                        contentPadding: const EdgeInsets.all(15),
                        controller: addressKu,
                        hintText: Trans.kurdish.trans(),
                      ),
                      const SizedBox(height: 15),
                      GeneralTextFiled(
                        validate: validateName,
                        viewBorder: false,
                        showLabel: true,
                        maxLines: null,
                        textInputType: TextInputType.multiline,
                        contentPadding: const EdgeInsets.all(15),
                        controller: addressAr,
                        hintText: Trans.arabic.trans(),
                      ),
                      const SizedBox(height: 15),
                      GeneralTextFiled(
                        validate: validateName,
                        viewBorder: false,
                        showLabel: true,
                        maxLines: null,
                        textInputType: TextInputType.multiline,
                        contentPadding: const EdgeInsets.all(15),
                        controller: addressEn,
                        hintText: Trans.english.trans(),
                      ),
                    ],
                  ),
                  if (widget.elementType == ElementType.doctor)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: Text(Trans.specialist.trans(),
                          style: const TextStyle(fontSize: 17)),
                    ),
                  if (widget.elementType == ElementType.doctor)
                    GeneralDropDownTextFiled<SpecialiestsModel>(
                      onChange: (p0) {
                        specialiests = p0;
                      },
                      // value: specialiests,
                      validate: (p0) {
                        if (p0 == null) {
                          return Trans.required.trans();
                        }
                        return null;
                      },
                      list: CategoriesNotifer.instance.categories,
                      getVal: (p0) {
                        return p0;
                      },
                      getLabel: (p0) {
                        return p0.name.english;
                      },
                      viewBorder: false,
                      showLabel: true,
                      textInputType: TextInputType.multiline,
                      contentPadding: const EdgeInsets.all(15),
                      hintText: Trans.specialist.trans(),
                    ),
                  const SizedBox(height: 15),

                  GeneralDropDownTextFiled<String>(
                    onChange: (p0) {
                      city = p0;
                    },
                    list: cities,
                    getVal: (p0) {
                      return p0;
                    },
                    viewBorder: false,
                    showLabel: true,
                    value: city,
                    getLabel: (p0) {
                      return p0.trans();
                    },
                    validate: validateName,
                    textInputType: TextInputType.multiline,
                    contentPadding: const EdgeInsets.all(15),
                    hintText: Trans.city.trans(),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Text(Trans.othersInformations.trans(),
                        style: const TextStyle(fontSize: 17)),
                  ),
                  GeneralTextFiled(
                      validate: validateName,
                      viewBorder: false,
                      showLabel: true,
                      textInputType: TextInputType.phone,
                      contentPadding: const EdgeInsets.all(15),
                      controller: phone,
                      hintText: Trans.phone.trans()),
                  const SizedBox(height: 20),
                  GeneralTextFiled(
                      validate: validateName,
                      viewBorder: false,
                      textInputType: TextInputType.phone,
                      showLabel: true,
                      contentPadding: const EdgeInsets.all(15),
                      controller: mobile,
                      hintText: Trans.mobile.trans()),

                  const SizedBox(height: 20),
                  GeneralTextFiled(
                      validate: validateName,
                      viewBorder: false,
                      showLabel: true,
                      textInputType: TextInputType.emailAddress,
                      contentPadding: const EdgeInsets.all(15),
                      controller: email,
                      hintText: Trans.email.trans()),
                  const SizedBox(height: 20),
                  const SizedBox(height: 20),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Text(Trans.practiceDays.trans(),
                        style: const TextStyle(fontSize: 17))
                  ]),
                  const SizedBox(height: 20),
                  Wrap(spacing: 15, runSpacing: 10, children: <Widget>[
                    for (int index = 0; index < daysData.length; index++)
                      ChoiceChip(
                        labelPadding: const EdgeInsets.symmetric(
                            vertical: 2, horizontal: 20),
                        label: SizedBox(
                          // width: 31,
                          child: Text(
                            daysData[index].name.trans(),
                            style: TextStyle(
                                height: 1,
                                color: daysData[index].selected
                                    ? Colors.white
                                    : primaryColor,
                                fontSize: 14),
                          ),
                        ),
                        selected: daysData[index].selected,
                        selectedColor: primaryColor,
                        backgroundColor: openColor,
                        onSelected: (value) {
                          if (index == 0) {
                            for (var element in daysData) {
                              element.selected = value;
                            }
                          } else {
                            daysData[0].selected = false;
                            daysData[index].selected = value;
                            var unSelected = daysData.where((element) =>
                                element.selected == false &&
                                element.name != Trans.all.trans());
                            if (unSelected.isEmpty) {
                              for (var element in daysData) {
                                element.selected = value;
                              }
                            }
                          }

                          setState(() {});
                        },
                        elevation: 1,
                      )
                  ]),
                  SwitchListTile(
                      title: Text(Trans.open24.trans(),
                          style: const TextStyle(fontSize: 17)),
                      value: isOpen24,
                      onChanged: (value) {
                        isOpen24 = !isOpen24;
                        setState(() {
                          if (isOpen24) {
                            openTime = null;
                            cLosingTime = null;
                          }
                        });
                      }),
                  Visibility(
                    visible: !isOpen24,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                                width: MediaQuery.of(context).size.width / 2.3,
                                child: GeneralTextFiled(
                                    validate: validateName,
                                    viewBorder: false,
                                    readOnly: true,
                                    subfixIcon: const Icon(Icons.timer),
                                    showLabel: true,
                                    onTap: () async {
                                      openTime = await showCustomeTimePicker(
                                          context, openTime);
                                      setState(() {});
                                    },
                                    maxLines: null,
                                    textInputType: TextInputType.text,
                                    contentPadding: const EdgeInsets.all(15),
                                    controller: TextEditingController(
                                        text: formatTimeOfDay(openTime)),
                                    hintText: Trans.from.trans()))
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // const Text("To", style: TextStyle(fontSize: 17)),
                            // const SizedBox(height: 5),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2.3,
                              child: GeneralTextFiled(
                                validate: validateName,
                                viewBorder: false,
                                readOnly: true,
                                subfixIcon: const Icon(Icons.timer),
                                showLabel: true,
                                onTap: () async {
                                  cLosingTime = await showCustomeTimePicker(
                                      context, cLosingTime);
                                  setState(() {});
                                },
                                maxLines: null,
                                textInputType: TextInputType.text,
                                contentPadding: const EdgeInsets.all(15),
                                controller: TextEditingController(
                                    text: formatTimeOfDay(cLosingTime)),
                                hintText: Trans.to.trans(),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Text(Trans.location.trans(),
                        style: const TextStyle(fontSize: 17))
                  ]),
                  const SizedBox(height: 15),
                  MapWidget(
                    key: ValueKey("$longitude$latitude"),
                    isEditable: true,
                    latitude: latitude,
                    longitude: longitude,
                    getLocation: (p0) {
                      latitude = p0.latitude;
                      longitude = p0.longitude;
                      setState(() {});
                      logger("location $p0");
                    },
                    title: Trans.selectLocation.trans(),
                  )
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  GeneralButton(
                      width: 200.w,
                      onTap: () async {
                        if (latitude == null || longitude == null) {
                          showToast(Trans.pleaseSelectLocationOnMap.trans(),
                              toastGravity: ToastGravity.TOP);
                          return;
                        }
                        if (formKey.currentState?.validate() != true) {
                          return;
                        }

                        final newModel = GeneralModel(
                            city: city!,
                            specialiestId: specialiests?.id ?? 0,
                            id: widget.model?.id ?? 0,
                            name: Names(
                                kurdish: nameKu.text.trim(),
                                arabic: nameAr.text.trim(),
                                english: nameEn.text.trim()),
                            email: email.text.trim(),
                            phone: phone.text.trim(),
                            mobile: mobile.text.trim(),
                            address: Names(
                                kurdish: addressKu.text.trim(),
                                arabic: addressAr.text.trim(),
                                english: addressEn.text.trim()),
                            about: Names(
                                kurdish: aboutKu.text.trim(),
                                arabic: aboutAr.text.trim(),
                                english: aboutEn.text.trim()),
                            latitude: latitude!,
                            longitude: longitude!,
                            rate: widget.model?.rate ?? 0,
                            availableDays: DayClass(
                                sat: getSelectedByDay(Trans.sat),
                                sun: getSelectedByDay(Trans.sun),
                                mon: getSelectedByDay(Trans.mon),
                                tues: getSelectedByDay(Trans.tues),
                                wed: getSelectedByDay(Trans.wed),
                                thu: getSelectedByDay(Trans.thu),
                                fri: getSelectedByDay(Trans.fri)),
                            workingHours: WorkTime(
                                isOpen24: isOpen24,
                                closeTime: cLosingTime,
                                openTime: openTime),
                            isAdd: widget.model?.isAdd ?? false);
                        if (widget.model == null) {
                          await getGeneralNotifier(widget.elementType)
                              ?.add(newModel);
                        } else {
                          await getGeneralNotifier(widget.elementType)
                              ?.edit(newModel, 1, widget.elementType);
                        }
                      },
                      text: Trans.save.trans()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MapWidget extends StatelessWidget {
  final double? latitude;
  final double? longitude;
  final bool isEditable;
  final String title;
  final Function(LatLng) getLocation;
  const MapWidget(
      {Key? key,
      required this.title,
      required this.isEditable,
      required this.longitude,
      required this.latitude,
      required this.getLocation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final markers = <Marker>[
      if (latitude != null && latitude != null)
        Marker(
            point: LatLng(latitude!, longitude!),
            builder: (ctx) =>
                const Icon(Icons.push_pin, color: Colors.red, size: 45))
    ];

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 250,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: InkWell(
          onTap: () async {
            final res = await Navigator.push<LatLng?>(
                context,
                MaterialPageRoute(
                    builder: (_) => FullScreenMap(
                        isEditable: isEditable,
                        latLng: latitude == null || longitude == null
                            ? null
                            : LatLng(latitude!, longitude!),
                        title: title)));
            logger("res $res");
            if (res != null) {
              getLocation(res);
            }
          },
          child: IgnorePointer(
            ignoring: true,
            child: FlutterMap(
              options: MapOptions(
                  center: (latitude != null && longitude != null)
                      ? LatLng(latitude!, longitude!)
                      : null,
                  zoom: 13,
                  minZoom: 3),
              children: [
                TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png'),
                MarkerLayer(markers: markers)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
