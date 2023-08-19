import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tandrustito/core/error/failures.dart';
import 'package:tandrustito/core/network_services.dart';
import 'package:tandrustito/core/shared/imports.dart';
import 'package:tandrustito/core/shared/local_favs.dart';
import 'package:tandrustito/model/general_model.dart';
import 'package:tandrustito/model/server_response.dart';

class FavsNotifier extends ChangeNotifier {
  static final FavsNotifier _singleton = FavsNotifier._();
  static FavsNotifier get instance => _singleton;
  FavsNotifier._();

  inti() {
    localFavModel = LocalFavs.instance.favs;
    refresh();
  }

  bool isFaved(int id, ElementType type) {
    int index = -1;
    if (type == ElementType.doctor) {
      index = localFavModel.physicians.indexWhere((element) => element == id);
    } else if (type == ElementType.laboratory) {
      index = localFavModel.labs.indexWhere((element) => element == id);
    } else if (type == ElementType.pharmacy) {
      index = localFavModel.pharmas.indexWhere((element) => element == id);
    }
    logger("indexindex $index");
    return index > -1;
  }

  Failure? failure;
  ServerFavLists serverFavLists =
      const ServerFavLists(physicians: [], labs: [], pharmas: []);
  LocalFavModel localFavModel =
      LocalFavModel(physicians: [], labs: [], pharmas: []);
  Status status = Status.initial;

  delete(int id, ElementType type) async {
    if (type == ElementType.doctor) {
      localFavModel = localFavModel.copyWith(physicians: [
        ...localFavModel.physicians.where((element) => element != id).toList()
      ]);
    } else if (type == ElementType.laboratory) {
      localFavModel = localFavModel.copyWith(
          labs: localFavModel.labs.where((element) => element != id).toList());
    } else if (type == ElementType.pharmacy) {
      localFavModel = localFavModel.copyWith(
          pharma:
              localFavModel.pharmas.where((element) => element != id).toList());
    }
    if (type == ElementType.doctor) {
      serverFavLists = serverFavLists.copyWith(physicians: [
        ...serverFavLists.physicians
            .where((element) => element.id != id)
            .toList()
      ]);
    } else if (type == ElementType.laboratory) {
      serverFavLists = serverFavLists.copyWith(
          labs: serverFavLists.labs
              .where((element) => element.id != id)
              .toList());
    } else if (type == ElementType.pharmacy) {
      serverFavLists = serverFavLists.copyWith(
          pharams: serverFavLists.pharmas
              .where((element) => element.id != id)
              .toList());
    }
    LocalFavs.instance.setMode(localFavModel);

    notifyListeners();
  }

  add(ElementType elementType, GeneralModel model) async {
    if (isFaved(model.id, elementType)) {
      delete(model.id, elementType);
      return;
    }
    if (elementType == ElementType.doctor) {
      localFavModel = localFavModel
          .copyWith(physicians: [...localFavModel.physicians, model.id]);
    } else if (elementType == ElementType.laboratory) {
      localFavModel =
          localFavModel.copyWith(labs: [...localFavModel.labs, model.id]);
    } else if (elementType == ElementType.pharmacy) {
      localFavModel =
          localFavModel.copyWith(pharma: [...localFavModel.pharmas, model.id]);
    }
    if (elementType == ElementType.doctor) {
      serverFavLists = serverFavLists
          .copyWith(physicians: [...serverFavLists.physicians, model]);
    } else if (elementType == ElementType.laboratory) {
      serverFavLists =
          serverFavLists.copyWith(labs: [...serverFavLists.labs, model]);
    } else if (elementType == ElementType.pharmacy) {
      serverFavLists =
          serverFavLists.copyWith(pharams: [...serverFavLists.pharmas, model]);
    }
    LocalFavs.instance.setMode(localFavModel);
    notifyListeners();
  }

  Future<void> refresh() async {
    status = Status.initial;

    await getData();
    notifyListeners();
  }

  Future<void> getData() async {
    status = Status.loading;
    notifyListeners();
    final res = await removeDataSourceImp.create(
        data: localFavModel.toMap(),
        name: "FavLists",
        isFormData: false,
        endPoint: "/api/Physicians/GetAllData",
        fromJsonModel: OptionGroup.fromMap);
    status = Status.success;
    res.fold((l) {
      failure = l;
    }, (r) {
      if (r != null) {
        failure = null;
        serverFavLists = (r.toFavLists());
      }
    });
    notifyListeners();
  }
}

class ServerFavLists extends Equatable {
  final List<GeneralModel> physicians;
  final List<GeneralModel> labs;
  final List<GeneralModel> pharmas;

  const ServerFavLists({
    required this.physicians,
    required this.labs,
    required this.pharmas,
  });

  @override
  List<Object> get props => [physicians, labs, pharmas];

  ServerFavLists copyWith({
    List<GeneralModel>? physicians,
    List<GeneralModel>? labs,
    List<GeneralModel>? pharams,
  }) {
    return ServerFavLists(
      physicians: physicians ?? this.physicians,
      labs: labs ?? this.labs,
      pharmas: pharams ?? pharmas,
    );
  }

  factory ServerFavLists.fromMap(Map<String, dynamic> map) {
    return ServerFavLists(
      physicians: List<GeneralModel>.from(
          map['physicians']?.map((x) => GeneralModel.fromMap(x))),
      labs: List<GeneralModel>.from(
          map['labs']?.map((x) => GeneralModel.fromMap(x))),
      pharmas: List<GeneralModel>.from(
          map['pharmas']?.map((x) => GeneralModel.fromMap(x))),
    );
  }

  @override
  String toString() =>
      'FavLists(doctors: $physicians, labs: $labs, pharams: $pharmas)';
}
