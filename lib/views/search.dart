// import 'package:flutter/material.dart';
// import 'package:tandrustito/features/categories/caregories_model.dart';
// import 'package:tandrustito/localization/translate_keys.dart';
// import 'package:tandrustito/views/genera_button.dart';
// import 'package:tandrustito/views/home.dart';

// Future<SpecialiestsModel?> searchInAreas(
//     context, List<SpecialiestsModel> areas) async {
//   return await showDialog<SpecialiestsModel?>(
//       context: context,
//       useRootNavigator: true,
//       useSafeArea: true,
//       builder: (BuildContext context) {
//         return _AreaAlert(areas: areas);
//       }).whenComplete(() {
//     Future.delayed(const Duration(milliseconds: 500)).then((value) {});
//   });
// }

// class _AreaAlert extends StatefulWidget {
//   const _AreaAlert({Key? key, required this.areas}) : super(key: key);
//   final List<SpecialiestsModel> areas;

//   @override
//   State<_AreaAlert> createState() => _AreaAlertState();
// }

// class _AreaAlertState extends State<_AreaAlert> {
//   List<SpecialiestsModel> areas = [];
//   @override
//   void initState() {
//     areas = widget.areas;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//         title: Theme(
//           data: Theme.of(context).copyWith(platform: TargetPlatform.android),
//           child: TextField(
//             style:
//                 TextStyle(color: Theme.of(context).textTheme.bodyText1?.color),
//             decoration: InputDecoration(
//               border: const OutlineInputBorder(),
//               hintText: Trans.search.trans(),
//             ),
//             onChanged: (str) {
//               areas = [];
//               for (var element in widget.areas) {
//                 if (element
//                     .toString()
//                     .toLowerCase()
//                     .replaceAll(" ", "")
//                     .contains(str.toLowerCase().trim())) {
//                   areas.add(element);
//                 }
//               }
//               setState(() {});
//             },
//           ),
//         ),
//         actions: [
//           SizedBox(
//             width: MediaQuery.of(context).size.width,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 GeneralButton(
//                   width: 150,
//                   text: Trans.close.trans(),
//                   onTap: () {
//                     FocusScope.of(context).unfocus();

//                     Navigator.pop(context);
//                   },
//                 ),
//               ],
//             ),
//           )
//         ],
//         contentPadding: const EdgeInsets.fromLTRB(24, 4, 24, 4),
//         content: SizedBox(
//             height: double.maxFinite,
//             width: MediaQuery.of(context).size.width,
//             child: ListView.separated(
//               separatorBuilder: (BuildContext context, int index) {
//                 return const Divider(color: primaryColor, height: 1);
//               },
//               shrinkWrap: true,
//               itemCount: areas.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return InkWell(
//                   onTap: () {
//                     Navigator.of(context).pop(areas[index]);
//                   },
//                   child: Row(children: [
//                     Image.asset(
//                       areas[index].imgAssetPath,
//                       width: 50,
//                       height: 50,
//                     ),
//                     const SizedBox(width: 5),
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(areas[index].doctorName),
//                         Text(areas[index].speciality),
//                       ],
//                     ),
//                   ]),
//                 );
//               },
//             )));
//   }
// }
