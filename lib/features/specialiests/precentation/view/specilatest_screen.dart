import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tandrustito/core/shared/imports.dart';
import 'package:tandrustito/features/specialiests/precentation/controller/specialiests_controller.dart';
import 'package:tandrustito/features/specialiests/precentation/view/create_edit_specilatest.dart';
import 'package:tandrustito/features/specialiests/precentation/view/specilatest_widget.dart';
import 'package:tandrustito/localization/translate_keys.dart';
import 'package:tandrustito/views/home.dart';
import 'package:tandrustito/views/status_widgets/failure_screen.dart';
import 'package:tandrustito/views/status_widgets/loading_widget.dart';

class SpecilatestScreen extends StatefulWidget {
  const SpecilatestScreen({Key? key}) : super(key: key);
  @override
  State<SpecilatestScreen> createState() => _SpecilatestStateScreen();
}

class _SpecilatestStateScreen extends State<SpecilatestScreen> {
  Future<void> onRefresh() async {
    return await CategoriesNotifer.instance.refresh();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:
            AppBar(centerTitle: true, title: Text(Trans.specialist.trans())),
        floatingActionButton: FloatingActionButton(
            backgroundColor: primaryColor,
            child: const Icon(Icons.add, color: Colors.white),
            onPressed: () {
              context.to(const AddEditSpecilatest(category: null));
            }),
        body: Consumer<CategoriesNotifer>(
          builder: (context, myType, child) {
            if (myType.status.isLoadingOrInitial) {
              return const LoadingWidget();
            }
            if (myType.failure != null) {
              return FailureScreen(
                  failure: myType.failure!, onRefresh: onRefresh);
            }
            return RefreshIndicator(
              onRefresh: onRefresh,
              child: ListView.builder(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemCount: myType.categories.length,
                itemBuilder: (BuildContext context, int index) {
                  return SpecilatestWidget(
                      index: index, model: myType.categories[index]);
                },
              ),
            );
          },
        ),
      ),
    );
  }

  final ScrollController _scrollController = ScrollController();
}
