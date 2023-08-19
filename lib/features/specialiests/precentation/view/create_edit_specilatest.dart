import 'package:flutter/material.dart';
import 'package:tandrustito/core/shared/imports.dart';
import 'package:tandrustito/core/shared/validations.dart';
import 'package:tandrustito/features/specialiests/model/specialiests_model.dart';
import 'package:tandrustito/features/specialiests/precentation/controller/specialiests_controller.dart';
import 'package:tandrustito/localization/translate_keys.dart';
import 'package:tandrustito/model/names_model.dart';
import 'package:tandrustito/views/forms_widget/text_filed.dart';
import 'package:tandrustito/views/genera_button.dart';

class AddEditSpecilatest extends StatefulWidget {
  const AddEditSpecilatest({Key? key, required this.category})
      : super(key: key);
  final SpecialiestsModel? category;
  @override
  AddEditSpecilatestState createState() => AddEditSpecilatestState();
}

class AddEditSpecilatestState extends State<AddEditSpecilatest> {
  late TextEditingController nameKu;
  late TextEditingController nameAr;
  late TextEditingController nameEn;
  late TextEditingController descriptionKu;
  late TextEditingController descriptionAr;
  late TextEditingController descriptionEn;
  @override
  void initState() {
    nameKu = TextEditingController(text: widget.category?.name.kurdish ?? "");
    nameAr = TextEditingController(text: widget.category?.name.arabic ?? "");
    nameEn = TextEditingController(text: widget.category?.name.english ?? "");
    descriptionKu =
        TextEditingController(text: widget.category?.description.kurdish ?? "");
    descriptionAr =
        TextEditingController(text: widget.category?.description.arabic ?? "");
    descriptionEn =
        TextEditingController(text: widget.category?.description.english ?? "");
    super.initState();
  }

  final GlobalKey<FormState> _fromKey =
      GlobalKey<FormState>(debugLabel: "werthjyujyhregwghtujyhtge");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.category == null
              ? Trans.add.trans(args: [Trans.specialist.trans()])
              : Trans.edit.trans(args: [Trans.specialist.trans()]))),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                left: 10,
                right: 10,
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Form(
                key: _fromKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 15),
                    Text(Trans.name.trans(), style: context.titleStyle),
                    const SizedBox(height: 15),
                    GeneralTextFiled(
                      validate: validateName,
                      contentPadding: const EdgeInsets.all(15),
                      showLabel: true,
                      controller: nameKu,
                      hintText: Trans.kurdish.trans(),
                    ),
                    const SizedBox(height: 15),
                    GeneralTextFiled(
                      validate: validateName,
                      contentPadding: const EdgeInsets.all(15),
                      showLabel: true,
                      controller: nameAr,
                      hintText: Trans.arabic.trans(),
                    ),
                    const SizedBox(height: 15),
                    GeneralTextFiled(
                      validate: validateName,
                      contentPadding: const EdgeInsets.all(15),
                      showLabel: true,
                      controller: nameEn,
                      hintText: Trans.english.trans(),
                    ),
                    const SizedBox(height: 15),
                    Text(Trans.description.trans(), style: context.titleStyle),
                    const SizedBox(height: 15),
                    GeneralTextFiled(
                      maxLines: null,
                      validate: withoutValidate,
                      textInputType: TextInputType.multiline,
                      contentPadding: const EdgeInsets.all(15),
                      showLabel: true,
                      controller: descriptionKu,
                      hintText: Trans.kurdish.trans(),
                    ),
                    const SizedBox(height: 15),
                    GeneralTextFiled(
                      maxLines: null,
                      validate: withoutValidate,
                      textInputType: TextInputType.multiline,
                      contentPadding: const EdgeInsets.all(15),
                      showLabel: true,
                      controller: descriptionAr,
                      hintText: Trans.arabic.trans(),
                    ),
                    const SizedBox(height: 15),
                    GeneralTextFiled(
                      maxLines: null,
                      validate: withoutValidate,
                      textInputType: TextInputType.multiline,
                      contentPadding: const EdgeInsets.all(15),
                      showLabel: true,
                      controller: descriptionEn,
                      hintText: Trans.english.trans(),
                    ),
                  ],
                )),
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GeneralButton(
              radius: 45,
              width: MediaQuery.of(context).size.width / 3,
              onTap: () async {
                if (_fromKey.currentState?.validate() == true) {
                  final model = SpecialiestsModel(
                    id: widget.category?.id ?? 0,
                    name: Names(
                        kurdish: nameKu.text.trim(),
                        arabic: nameAr.text.trim(),
                        english: nameEn.text.trim()),
                    description: Names(
                        kurdish: descriptionKu.text.trim(),
                        arabic: descriptionAr.text.trim(),
                        english: descriptionEn.text.trim()),
                  );
                  if (widget.category == null) {
                    await CategoriesNotifer.instance.add(model);
                  } else {
                    await CategoriesNotifer.instance.edit(model);
                  }
                }
              },
              text: Trans.save.trans()),
          SizedBox(height: 20.h)
        ],
      ),
    );
  }
}
