import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tandrustito/core/alert/confirm_alert.dart';
import 'package:tandrustito/core/shared/imports.dart';
import 'package:tandrustito/features/specialiests/model/specialiests_model.dart';
import 'package:tandrustito/features/specialiests/precentation/controller/specialiests_controller.dart';
import 'package:tandrustito/features/specialiests/precentation/view/create_edit_specilatest.dart';
import 'package:tandrustito/localization/translate_keys.dart';
import 'package:tandrustito/views/home.dart';

class SpecilatestWidget extends StatelessWidget {
  const SpecilatestWidget({Key? key, required this.index, required this.model})
      : super(key: key);
  final int index;
  final SpecialiestsModel model;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Slidable(
        closeOnScroll: true,
        key: ValueKey(index),
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            const SizedBox(width: 10),
            SlidableAction(
              flex: 1,
              autoClose: false,
              onPressed: (_) async {
                final res = await getConfirm(
                    desc: Trans.areYouSureToDeleteThisData.trans());
                if (res == true) {
                  CategoriesNotifer.instance.delete(model.id);
                }
              },
              padding: const EdgeInsets.symmetric(horizontal: 10),
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              borderRadius: BorderRadius.circular(20),
              icon: Icons.delete,
              label: Trans.delete.trans(),
            ),
            SizedBox(width: 10.h),
          ],
        ),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SizedBox(width: 10.h),
            SlidableAction(
              autoClose: true,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              flex: 1,
              onPressed: (_) {
                context.to(AddEditSpecilatest(category: model));
              },
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
              icon: Icons.archive,
              borderRadius: BorderRadius.circular(20),
              label: Trans.edit.trans(),
            ),
            SizedBox(width: 10.h),
          ],
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: openColor, borderRadius: BorderRadius.circular(20)),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(model.name.kurdish,
                  style: TextStyle(height: 1.1, fontSize: 18.sp)),
              SizedBox(height: 6.h),
              Text(model.name.arabic,
                  style: TextStyle(height: 1.1, fontSize: 18.sp)),
              SizedBox(height: 6.h),
              Text(model.name.english,
                  style: TextStyle(height: 1.1, fontSize: 18.sp)),
            ],
          ),
        ),
      ),
    );
  }
}
