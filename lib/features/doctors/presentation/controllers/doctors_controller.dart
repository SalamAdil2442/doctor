import 'package:tandrustito/features/doctors/presentation/controllers/doctors_controllercopy.dart';
import 'package:tandrustito/localization/translate_keys.dart';

class DoctorsNotifer extends GeneralNotifier {
  static final DoctorsNotifer _singleton = DoctorsNotifer._();
  static DoctorsNotifer get instance => _singleton;
  DoctorsNotifer._() : super("/api/Physicians", Trans.doctor.trans());
}

class LabsNotifer extends GeneralNotifier {
  static final LabsNotifer _singleton = LabsNotifer._();
  static LabsNotifer get instance => _singleton;
  LabsNotifer._() : super("/api/Labs", Trans.laboratory.trans());
}

class PharmaciesNotifer extends GeneralNotifier {
  static final PharmaciesNotifer _singleton = PharmaciesNotifer._();
  static PharmaciesNotifer get instance => _singleton;
  PharmaciesNotifer._() : super("/api/Pharmacies", Trans.pharmacy.trans());
}
class SettingsNotifer extends GeneralNotifier {
  static final SettingsNotifer _singleton = SettingsNotifer._();
  static SettingsNotifer get instance => _singleton;
  SettingsNotifer._() : super("", Trans.pharmacy.trans());
}
