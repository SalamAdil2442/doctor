import 'package:flutter/material.dart';
import 'package:tandrustito/core/shared/imports.dart';
import 'package:tandrustito/core/shared/logger.dart';
import 'package:tandrustito/localization/translate_keys.dart';
import 'package:tandrustito/views/forms_widget/text_filed.dart';
import 'package:tandrustito/views/card.dart';

import '../features/doctors/presentation/controllers/doctors_controller.dart';

class new_detail_of_doctors extends StatefulWidget {
  const new_detail_of_doctors({super.key});

  @override
  State<new_detail_of_doctors> createState() => _new_detail_of_doctorsState();
}

class _new_detail_of_doctorsState extends State<new_detail_of_doctors> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          Trans.doctors.trans(context: context).toUpperCase(),
          style: TextStyle(color: Color.fromARGB(255, 77, 170, 80)),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(children: [
          //search
          Container(
            height: 80.sp,
            width: 390.sp,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
            child: GeneralTextFiled(
              fillColor: Color.fromARGB(255, 245, 244, 244),
              viewBorder: false,
              controller: [
                DoctorsNotifer.instance,
                PharmaciesNotifer.instance,
                LabsNotifer.instance,
              ][index]
                  .textEditingController,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              raduis: 30,
              readOnly: false,
              onChange: (p0) {
                logger("p0 $p0");
                setState(() {});
                setState(() {});
                setState(() {});
              },
              onTap: () {},
              hintText: Trans.search.trans(context: context),
              prefixIcon: Container(
                margin: const EdgeInsets.all(3),
                child: const Icon(Icons.search,
                    color: Color.fromARGB(255, 77, 170, 80)),
              ),
            ),
          ),
          SizedBox(
            height: 20.sp,
          ),
          // view/card
          Expanded(child: card()),
        ]),
      ),
    );
  }
}
