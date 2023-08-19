import 'package:flutter/material.dart';
import 'package:tandrustito/core/error/failures.dart';
import 'package:tandrustito/core/network_services.dart';
import 'package:tandrustito/core/shared/imports.dart';
import 'package:tandrustito/features/specialiests/model/specialiests_model.dart';
import 'package:tandrustito/localization/translate_keys.dart';

class CategoriesNotifer extends ChangeNotifier {
  static final CategoriesNotifer _singleton = CategoriesNotifer._();
  static CategoriesNotifer get instance => _singleton;
  CategoriesNotifer._();

  Failure? failure;
  List<SpecialiestsModel> categories = [];

  Status status = Status.initial;
  add(SpecialiestsModel model) async {
    final res = await removeDataSourceImp.create(
        data: model.toMap(),
        name: Trans.specialist.trans(),
        showLoading: ShowLoading.Show,
        showMessage: ShowMessageEnum.showBothAlert,
        fromJsonModel: SpecialiestsModel.fromMap,
        endPoint: "/api/Specialiests");
    res.fold((l) {}, (r) {
      Halper.i.pop();
      if (r != null) {
        categories.add(r);
        var seen = <int>{};
        categories =
            categories.where((student) => seen.add(student.id)).toList();

        status = Status.success;
      }
      status = Status.success;
      _setData();
      notifyListeners();
    });
  }

  delete(int id) async {
    final res = await removeDataSourceImp.delete(
        endPoint: "/api/Specialiests/$id",
        name: Trans.specialist.trans(),
        showLoading: ShowLoading.Show,
        showMessage: ShowMessageEnum.showBothAlert);
    if (res.isRight()) {
      categories = categories.where((element) => element.id != id).toList();
      if (categories.isEmpty) {
        status = Status.empty;
      }
      notifyListeners();
    }
  }

  edit(SpecialiestsModel model) async {
    final res = await removeDataSourceImp.update(
        body: model.toMap(),
        fromJsonModel: SpecialiestsModel.fromMap,
        showLoading: ShowLoading.Show,
        name: Trans.specialist.trans(),
        showMessage: ShowMessageEnum.showBothAlert,
        endPoint: "/api/Specialiests/${model.id}");
    if (res.isRight()) {
      categories = categories
          .map((element) => element.id != model.id ? element : model)
          .toList();
      Halper.i.pop();
      if (categories.isEmpty) {
        status = Status.empty;
      }
      _setData();
      notifyListeners();
    }
  }

  Map<int, SpecialiestsModel> map = {};

  Future<void> refresh() async {
    status = Status.initial;
    categories = [];
    await getData();
    notifyListeners();
  }

  _setData() {
    map = {};

    for (var element in categories) {
      map[element.id] = element;
    }
  }

  Future<void> getData() async {
    if (categories.isNotEmpty) {
      status = Status.loading;
      notifyListeners();
    }
    final res = await removeDataSourceImp.getData(
        endPoint: "/api/Specialiests",
        name: Trans.specialist.trans(),
        fromJsonModel: SpecialiestsModel.fromMap);
    res.fold((l) {
      if (categories.isEmpty) {
        failure = l;
      }
    }, (r) {
      failure = null;
      status = Status.success;
      categories.addAll(r);
    });
    _setData();
    notifyListeners();
  }
}
//http://115.113.25.82:990/api/Specialiests
//http://185.213.25.86:7147/api/Specialiests