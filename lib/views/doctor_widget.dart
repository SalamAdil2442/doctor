import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:tandrustito/core/alert/confirm_alert.dart';
import 'package:tandrustito/core/shared/imports.dart';
import 'package:tandrustito/features/doctors/presentation/controllers/favs_controller.dart';
import 'package:tandrustito/features/doctors/presentation/view/create_edit_general.dart';
import 'package:tandrustito/features/specialiests/precentation/controller/specialiests_controller.dart';
import 'package:tandrustito/localization/translate_keys.dart';
import 'package:tandrustito/model/general_model.dart';
import 'package:tandrustito/views/banner.dart';
import 'package:tandrustito/views/doctor_info.dart';
import 'package:tandrustito/views/home.dart';
import 'package:tandrustito/views/net_image.dart';

class DoctorWidget extends StatelessWidget {
  final GeneralModel model;
  final int index;
  final ElementType elementType;
  const DoctorWidget({
    Key? key,
    required this.model,
    required this.elementType,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, left: 12, right: 12),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DoctorsInfo(
                      elementType: elementType,
                      model: model,
                      index: index.toString())));
        },
        child: Slidable(
          key: ValueKey(index),

          startActionPane: (!canEdit)
              ? null
              : ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    const SizedBox(width: 10),
                    SlidableAction(
                      flex: 1,
                      onPressed: (_) async {
                        final res = await getConfirm(
                            desc: Trans.areYouSureToDeleteThisData
                                .trans(args: [elementType.name.trans()]));
                        if (res == true) {
                          getGeneralNotifier(elementType)?.delete(model.id, 0);
                        }
                      },
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      backgroundColor: const Color(0xFFFE4A49),
                      foregroundColor: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      icon: Icons.delete,
                      label: Trans.delete.trans(),
                    ),
                    const SizedBox(width: 10),
                  ],
                ),

          // The end action pane is the one at the right or the bottom side.
          endActionPane: (!canEdit)
              ? null
              : ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    const SizedBox(width: 10),
                    SlidableAction(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      flex: 1,
                      onPressed: (_) {
                        context.to(CreateEditDoctor(
                            elementType: elementType, model: model));
                      },
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      icon: Icons.archive,
                      borderRadius: BorderRadius.circular(20),
                      label: Trans.edit.trans(),
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
          child: Ribbon(
            color: primaryColor,
            nearLength: 35,
            location: (!canEdit)
                ? RibbonLocation.none
                : model.isAdd
                    ? context.isEn
                        ? RibbonLocation.topEnd
                        : RibbonLocation.topStart
                    : RibbonLocation.none,
            farLength: 70,
            titleStyle: TextStyle(
                height: 1.3,
                color: Colors.amber,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold),
            title: "VIP",
            child: Container(
              decoration: BoxDecoration(
                  color: openColor, borderRadius: BorderRadius.circular(20)),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Row(
                children: <Widget>[
                  Hero(
                      tag: index.toString(),
                      child: ImageChecker(
                          linkImage: model.image,
                          height: 75,
                          width: 75,
                          radius: 16,
                          fit: BoxFit.cover)),
                  const SizedBox(width: 17),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(getNames(model.name),
                          style: TextStyle(
                              height: 1.1,
                              color: Colors.black,
                              fontSize: 19.sp)),
                      const SizedBox(height: 8),
                      Text(
                          "${getNames(CategoriesNotifer.instance.map[model.specialiestId]?.name)} | ${model.city?.trans()}",
                          style:
                              TextStyle(fontSize: 14.sp, color: Colors.black87))
                    ],
                  ),
                  const Spacer(),
                  Consumer<FavsNotifier>(builder: (context, myType, child) {
                    bool isFaved = myType.isFaved(model.id, elementType);

                    return InkWell(
                      onTap: () {
                        if (!isFaved) {
                          myType.add(elementType, model);
                        } else {
                          myType.delete(model.id, elementType);
                        }
                      },
                      child: Icon(
                          isFaved ? Icons.favorite : Icons.favorite_border),
                    );
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
