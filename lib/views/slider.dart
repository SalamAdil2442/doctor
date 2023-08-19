import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tandrustito/core/shared/imports.dart';
import 'package:tandrustito/features/specialiests/precentation/controller/specialiests_controller.dart';
import 'package:tandrustito/localization/translate_keys.dart';
import 'package:tandrustito/model/slider_model.dart';
import 'package:tandrustito/views/doctor_info.dart';
import 'package:tandrustito/views/home.dart';
import 'package:tandrustito/views/net_image.dart';
import 'package:get/get.dart';

class DoctorsPageView extends StatefulWidget {
  const DoctorsPageView({
    Key? key,
    required this.lists,
  }) : super(key: key);
  final List<SliderModel> lists;
  @override
  State<DoctorsPageView> createState() => _DoctorsPageViewState();
}

class _DoctorsPageViewState extends State<DoctorsPageView> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 250,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: widget.lists.length,
            separatorBuilder: (context, index) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              return SizedBox(
                height: 150,
                width: 140,
                child: SpecialistTile(
                  hasSlider: false,
                  index: index,
                  model: widget.lists[index],
                ),
              );
            }),
      ),
    );
  }
}

class SpecialistTile extends StatefulWidget {
  final SliderModel model;
  final bool hasSlider;
  const SpecialistTile({
    Key? key,
    required this.model,
    required this.hasSlider,
    required this.index,
  }) : super(key: key);
  final int index;

  @override
  State<SpecialistTile> createState() => _SpecialistTileState();
}

class _SpecialistTileState extends State<SpecialistTile> {
  @override
  Widget build(BuildContext context) {
    Widget child = Container(
      decoration: BoxDecoration(
          color: primaryColor, borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Stack(alignment: AlignmentDirectional.center, children: [
            SizedBox(
              height: Get.height / 11,
              width: Get.height / 11,//hhhhhhhhhhhhhh buasta nihawet lasar buaseta esta real device esh nakat hhhhhhhhhhhhhhhhhhhhhh
              child: ImageChecker(
                linkImage: widget.model.generalModel.image,
                fit: BoxFit.fill,
              ),
            ),
          ]), //mama duai agar majat habu project  bamn eshi to nia bale medeia guere size .widthmnish  yan na  bdat lasar responsive
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "${getNames(widget.model.generalModel.name)} | ${getNames(CategoriesNotifer.instance.map[widget.model.generalModel.specialiestId]?.name)}",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.model.generalModel.phone,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: TextStyle(
                              height: 1.5,
                              color: Colors.white,
                              fontSize: 14.sp),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => DoctorsInfo(
                      elementType: widget.model.elementType,
                      model: widget.model.generalModel,
                      index: "${widget.index}0")));
        },
        child: child);
  }
}
