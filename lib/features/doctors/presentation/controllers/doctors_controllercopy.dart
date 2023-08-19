import 'package:flutter/material.dart';
import 'package:tandrustito/core/cities.dart';
import 'package:tandrustito/core/error/failures.dart';
import 'package:tandrustito/core/network_services.dart';
import 'package:tandrustito/core/shared/imports.dart';
import 'package:tandrustito/core/shared/theme_lang_notifier.dart';
import 'package:tandrustito/features/reklams/controller/reklam_notifier.dart';
import 'package:tandrustito/model/general_model.dart';
import 'package:tandrustito/views/city_picker.dart';
import 'package:tandrustito/views/doctor_info.dart';

class GeneralNotifier extends ChangeNotifier {
  final String endPoint;
  final String name;
  TextEditingController textEditingController = TextEditingController();
  Failure? failure;

  List<GeneralModel> data = [];
  int selectedCategory = 0;
  setSelectedCat(int cat) {
    cat = selectedCategory;
    notifyListeners();
  }

  List<String> selectedCity = [...cities];
  setSelectedCity(ValueClass valueClass) {
    selectedCity = valueClass.cities;
    selectedCategory = valueClass.specialiests;
    notifyListeners();
  }

  Status status = Status.initial;
  _onChnage() {
    ReklamNotifiers.instance.setData();
  }

  GeneralNotifier(this.endPoint, this.name);
  add(GeneralModel model) async {
    final res = await removeDataSourceImp.create(
        data: model.toMap(),
        isFormData: true,
        name: name,
        paths: [
          if (!checkIsNull(ThemeLangNotifier.instance.file?.path))
            (ThemeLangNotifier.instance.file?.path)!
        ],
        showLoading: ShowLoading.Show,
        showMessage: ShowMessageEnum.showBothAlert,
        fromJsonModel: GeneralModel.fromMap,
        endPoint: endPoint);
    res.fold((l) {}, (r) {
      Halper.i.pop();
      if (r != null) {
        _onChnage();
        data.add(r);
        status = Status.success;
      }
      notifyListeners();
    });
  }

  delete(int id, int popUpTimes) async {
    final res = await removeDataSourceImp.delete(
        endPoint: "$endPoint/$id",
        showLoading: ShowLoading.Show,
        popUpTimes: popUpTimes,
        name: name,
        showMessage: ShowMessageEnum.showBothAlert);
    if (res.isRight()) {
      data = data.where((element) => element.id != id).toList();
      if (data.isEmpty) {
        status = Status.empty;
      }
      notifyListeners();
      _onChnage();
    }
  }

  edit(GeneralModel model, int popUpTimes, ElementType elementType) async {
    final res = await removeDataSourceImp.update(
        body: model.toMap(),
        isFormData: true,
        name: name,
        popUpTimes: popUpTimes,
        paths: [
          if (!checkIsNull(ThemeLangNotifier.instance.file?.path))
            (ThemeLangNotifier.instance.file?.path)!
        ],
        fromJsonModel: GeneralModel.fromMap,
        showLoading: ShowLoading.Show,
        showMessage: ShowMessageEnum.showBothAlert,
        endPoint: "$endPoint/${model.id}");
    res.fold((l) {}, (right) {
      logger("r $right");
      data = data
          .map((element) => element.id != model.id ? element : (right ?? model))
          .toList();

      Navigator.pushReplacement(
          Halper.i.context,
          MaterialPageRoute(
              builder: (_) => DoctorsInfo(
                    index: "0",
                    model: right ?? model,
                    elementType: elementType,
                  )));
      notifyListeners();
      _onChnage();
    });
  }

  Future<void> refresh() async {
    status = Status.initial;
    data = [];
    await getData();
    notifyListeners();
  }

  Future<void> getData() async {
    if (data.isNotEmpty) {
      return;
    }
    if (data.isEmpty) {
      status = Status.loading;
      notifyListeners();
    }
    final res = await removeDataSourceImp.getData(
        name: name, endPoint: endPoint, fromJsonModel: GeneralModel.fromMap);
    status = Status.success;
    res.fold((l) {
      if (data.isEmpty) {
        failure = l;
      }
    }, (r) {
      failure = null;
      data = (r);
    });
    notifyListeners();
    _onChnage();
  }
}
