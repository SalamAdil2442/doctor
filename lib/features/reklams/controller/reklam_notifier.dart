import 'package:flutter/cupertino.dart';
import 'package:tandrustito/core/shared/enums.dart';
import 'package:tandrustito/features/doctors/presentation/controllers/doctors_controller.dart';
import 'package:tandrustito/model/slider_model.dart';

class ReklamNotifiers extends ChangeNotifier {
  List<SliderModel> list = [];
  static final ReklamNotifiers _singleton = ReklamNotifiers._();
  static ReklamNotifiers get instance => _singleton;
  ReklamNotifiers._();
  setData() {
    final doctors =
        DoctorsNotifer.instance.data.where((element) => element.isAdd).toList();
    final labs =
        LabsNotifer.instance.data.where((element) => element.isAdd).toList();
    final pharma = PharmaciesNotifer.instance.data
        .where((element) => element.isAdd)
        .toList();
    list = [];
    list.addAll(doctors.map((e) => SliderModel(ElementType.doctor, e)));
    list.addAll(labs.map((e) => SliderModel(ElementType.laboratory, e)));
    list.addAll(pharma.map((e) => SliderModel(ElementType.pharmacy, e)));
    notifyListeners();
  }
}
