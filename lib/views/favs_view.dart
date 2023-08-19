import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:tandrustito/core/shared/imports.dart';
import 'package:tandrustito/features/doctors/presentation/controllers/doctors_controller.dart';
import 'package:tandrustito/features/doctors/presentation/controllers/favs_controller.dart';
import 'package:tandrustito/localization/translate_keys.dart';
import 'package:tandrustito/model/general_model.dart';
import 'package:tandrustito/views/doctor_widget.dart';
import 'package:tandrustito/views/home.dart';
import 'package:tandrustito/views/status_widgets/failure_screen.dart';
import 'package:tandrustito/views/status_widgets/loading_widget.dart';

class FavScreen extends StatefulWidget {
  const FavScreen({super.key});

  @override
  _FavScreenState createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      FavsNotifier.instance.inti();
    });
    super.initState();
  }

  Future<void> onRefresh() async {
    FavsNotifier.instance.inti();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(title: Text(Trans.favorites.trans())),
          body: RefreshIndicator(
            onRefresh: onRefresh,
            backgroundColor: primaryColor,
            color: Colors.white,
            displacement: 50,
            child: Consumer<FavsNotifier>(builder: (context, myType, child) {
              if (myType.status.isLoadingOrInitial) {
                return const SizedBox(child: LoadingWidget());
              }
              if (myType.failure != null) {
                return SizedBox(
                    child: FailureScreen(
                        failure: myType.failure!, onRefresh: onRefresh));
              }
              return ListView(
                padding: const EdgeInsets.symmetric(vertical: 20),
                children: [
                  FaavView(
                    doctors: myType.serverFavLists.pharmas,
                    elementType: ElementType.pharmacy,
                  ),
                  FaavView(
                    doctors: myType.serverFavLists.labs,
                    elementType: ElementType.laboratory,
                  ),
                  FaavView(
                    doctors: myType.serverFavLists.physicians,
                    elementType: ElementType.doctor,
                  ),
                ],
              );
            }),
          )),
    );
  }
}

class FaavView extends StatefulWidget {
  const FaavView({super.key, required this.doctors, required this.elementType});
  final List<GeneralModel> doctors;
  final ElementType elementType;
  @override
  State<FaavView> createState() => _FaavViewState();
}

class _FaavViewState extends State<FaavView> {
  Future<void> onRefresh() async {
    return await DoctorsNotifer.instance.refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: widget.doctors
            .map((e) => DoctorWidget(
                elementType: widget.elementType, index: e.id, model: e))
            .toList());
  }
}
