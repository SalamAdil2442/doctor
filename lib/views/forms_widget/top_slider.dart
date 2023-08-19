import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tandrustito/features/reklams/controller/reklam_notifier.dart';
import 'package:tandrustito/localization/translate_keys.dart';
import 'package:tandrustito/views/doctor_widget.dart';

class TopSlider extends StatefulWidget {
  const TopSlider({super.key});

  @override
  State<TopSlider> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<TopSlider> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(centerTitle: true, title: Text(Trans.reklams.trans())),
          body: Consumer<ReklamNotifiers>(builder: (context, myType, child) {
            return ListView.builder(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              itemCount: myType.list.length,
              itemBuilder: (context, index) {
                return DoctorWidget(
                    model: myType.list[index].generalModel,
                    elementType: myType.list[index].elementType,
                    index: index);
              },
            );
          })),
    );
  }
}
