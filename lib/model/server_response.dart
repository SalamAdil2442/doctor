import 'package:tandrustito/features/doctors/presentation/controllers/favs_controller.dart';
import 'package:tandrustito/model/general_model.dart';

class OptionGroup {
  OptionGroup({
    required this.doctors,
    required this.pharma,
    required this.labsArr,
  });

  ServerFavLists toFavLists() {
    List<GeneralModel> doctorsP = <GeneralModel>[];
    List<GeneralModel> pharmaP = <GeneralModel>[];
    List<GeneralModel> labsP = <GeneralModel>[];
    for (var element in doctors) {
      doctorsP.addAll(element);
    }
    for (var element in labsArr) {
      labsP.addAll(element);
    }
    for (var element in pharma) {
      pharmaP.addAll(element);
    }
    return ServerFavLists(physicians: doctorsP, labs: labsP, pharmas: pharmaP);
  }

  List<List<GeneralModel>> doctors;
  List<List<GeneralModel>> pharma;
  List<List<GeneralModel>> labsArr;

  factory OptionGroup.fromMap(Map<String, dynamic> json) => OptionGroup(
        doctors: List<List<GeneralModel>>.from(json["doctors"].map((x) =>
            List<GeneralModel>.from(x.map((x) => GeneralModel.fromMap(x))))),
        pharma: List<List<GeneralModel>>.from(json["pharma"].map((x) =>
            List<GeneralModel>.from(x.map((x) => GeneralModel.fromMap(x))))),
        labsArr: List<List<GeneralModel>>.from(json["labsArr"].map((x) =>
            List<GeneralModel>.from(x.map((x) => GeneralModel.fromMap(x))))),
      );

 
}