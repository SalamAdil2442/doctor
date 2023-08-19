// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:tandrustito/core/cities.dart';
import 'package:tandrustito/core/shared/imports.dart';
import 'package:tandrustito/features/specialiests/model/specialiests_model.dart';
import 'package:tandrustito/features/specialiests/precentation/controller/specialiests_controller.dart';
import 'package:tandrustito/localization/translate_keys.dart';
import 'package:tandrustito/model/names_model.dart';
import 'package:tandrustito/views/home.dart';

class ValueClass {
  List<String> cities;
  int specialiests;
  ValueClass({
    required this.cities,
    required this.specialiests,
  });
}

Future<ValueClass?> selectCity(
    List<String> selected, int specialiests, bool havSpecialiests) {
  return showModalBottomSheet<ValueClass?>(
      context: Halper.i.context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      // useRootNavigator: true,
      builder: (BuildContext context) {
        return CityPicker(
            havSpecialiests: havSpecialiests,
            specialiests: specialiests,
            selected: selected);
      });
}

class CityPicker extends StatefulWidget {
  const CityPicker({
    Key? key,
    required this.selected,
    required this.specialiests,
    required this.havSpecialiests,
  }) : super(key: key);
  final List<String> selected;
  final int specialiests;
  final bool havSpecialiests;

  @override
  State<CityPicker> createState() => _CityPickerState();
}

SpecialiestsModel all = SpecialiestsModel(
    id: 0,
    name: Names(kurdish: "هەموو", arabic: "الكل", english: "all"),
    description: Names(kurdish: "هەموو", arabic: "الكل", english: "all"));

class _CityPickerState extends State<CityPicker> {
  List<String> selectedCities = [];
  int specialiests = 0;
  @override
  void initState() {
    selectedCities = [...widget.selected];
    specialiests = widget.specialiests;
    super.initState();
  }

  final allCities = ["all", ...cities];
  @override
  Widget build(BuildContext context) {
    logger("cities 1 $cities");
    logger("cities 2 $selectedCities");
    if (selectedCities
            .sortedByCompare((element) => element, (a, b) => a.compareTo(b))
            .toList()
            .join() ==
        cities
            .sortedByCompare((element) => element, (a, b) => a.compareTo(b))
            .toList()
            .join()) {
      selectedCities = [...allCities];
    }
    logger(selectedCities.length);
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.maxFinite,
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Text(
                  Trans.filtering.trans(),
                  style: context.titleStyle.copyWith(color: Colors.white),
                ),
                Positioned(
                  right: 20,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop(ValueClass(
                          cities: selectedCities, specialiests: specialiests));
                    },
                    child: Icon(Icons.check, size: 25.sp, color: Colors.white),
                  ),
                )
              ],
            ),
          ),
          if (widget.havSpecialiests)
            Container(
              width: context.width,
              padding: const EdgeInsets.all(10),
              child: Text(
                Trans.specialist.trans(),
                style: context.titleStyle,
              ),
            ),
          if (widget.havSpecialiests)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [all, ...CategoriesNotifer.instance.categories]
                    .map((e) => ChoiceChip(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 12),
                          label: Text(
                            getNames(e.name),
                            style: TextStyle(
                                height: 1,
                                fontWeight: FontWeight.normal,
                                color:
                                    specialiests == e.id ? Colors.white : null,
                                fontSize: 15.sp),
                          ),
                          selectedColor: primaryColor,
                          disabledColor: openColor,
                          selected: specialiests == e.id,
                          onSelected: (bool selected) {
                            specialiests = e.id;
                            logger("selectedCities ${selectedCities.length}");
                            setState(() {});
                          },
                        ))
                    .toList(),
              ),
            ),
          if (widget.havSpecialiests) const SizedBox(height: 8),
          Container(
            width: context.width,
            padding: const EdgeInsets.all(10),
            child: Text(
              Trans.cities.trans(),
              style: context.titleStyle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: allCities
                  .map((e) => ChoiceChip(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 12),
                        label: Text(
                          e.trans(),
                          style: TextStyle(
                              height: 1,
                              fontWeight: FontWeight.normal,
                              color: selectedCities.contains(e)
                                  ? Colors.white
                                  : null,
                              fontSize: 15.sp),
                        ),
                        selectedColor: primaryColor,
                        disabledColor: openColor,
                        selected: selectedCities.contains(e),
                        onSelected: (bool selected) {
                          logger("selected $selected");
                          if (e != "all") {
                            selectedCities.remove("all");
                            if (selected) {
                              selectedCities.add(e);
                            } else {
                              selectedCities.remove(e);
                            }
                          } else {
                            if (selected) {
                              selectedCities = [...allCities];
                            } else {
                              selectedCities = [];
                            }
                          }
                          selectedCities = selectedCities.toSet().toList();
                          logger("selectedCities ${selectedCities.length}");
                          setState(() {});
                        },
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
