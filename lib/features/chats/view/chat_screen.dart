import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:tandrustito/core/shared/imports.dart';
import 'package:tandrustito/features/chats/data_source/remote_chat.dart';
import 'package:tandrustito/features/chats/model/message.dart';
import 'package:tandrustito/localization/translate_keys.dart';
import 'package:tandrustito/views/forms_widget/text_filed.dart';
import 'package:tandrustito/views/home.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    super.key,
    required this.userModel,
    required this.collectionId,
    required this.title,
  });
  final UserModel userModel;
  final String title, collectionId;
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      RemoveCHatSource.instance.getMessages(widget.collectionId);
    });
    super.initState();
  }

  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("App Support"),
        ),
        body: Consumer<RemoveCHatSource>(builder: (context, myType, child) {
          return SafeArea(
            child: Column(
              children: [
                Expanded(
                    child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 350),
                  child: myType.list.isEmpty
                      ? Center(
                          child: Container(
                            height: 350,
                            width: 350,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(Icons.info_outline, size: 68),
                                    SizedBox(height: 32),
                                    Text(
                                      "Need Help?",
                                      style: TextStyle(fontSize: 28),
                                    ),
                                    SizedBox(height: 12),
                                    Text(
                                        "Have any questions regarding our application or need help contacting a doctor? dont hesitate to ask us and we will get back to you as soon as possible!",
                                        textAlign: TextAlign.center),
                                  ]),
                            ),
                          ),
                        )
                      : ListView.builder(
                          controller: scrollController,
                          itemCount: myType.list.length,
                          itemBuilder: (context, index) {
                            return MessageWidget(
                                model: myType.list[index],
                                otherId: widget.userModel.uuid);
                          },
                        ),
                )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GeneralTextFiled(
                    controller: controller,
                    subfixIcon: InkWell(
                      onTap: () {
                        if (controller.text.trim().isNotEmpty) {
                          myType.addMessage(
                            widget.collectionId,
                            widget.userModel.uuid,
                            controller.text.trim(),
                          );
                          controller.clear();
                        }
                      },
                      child: Icon(
                        Icons.send,
                        size: 30.sp,
                      ),
                    ),
                    maxLines: null,
                    textInputType: TextInputType.multiline,
                    hintText: Trans.message.trans(),
                  ),
                )
              ],
            ),
          );
        }));
  }
}

final ScrollController scrollController = ScrollController();

class MessageWidget extends StatelessWidget {
  const MessageWidget({super.key, required this.model, required this.otherId});
  final MessageModel model;
  final String otherId;

  @override
  Widget build(BuildContext context) {
    final bool byMe = model.senderId == otherId;
    return Bubble(
      borderUp: false,
      borderWidth: 0,
      elevation: 0,
      color: openColor,
      margin: BubbleEdges.only(
          top: 10, left: !byMe ? 50 : 5, right: !byMe ? 5 : 50),
      nip: byMe ? BubbleNip.leftBottom : BubbleNip.rightBottom,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(model.text),
          Text(formatDate(model.date)),
        ],
      ),
    );
  }
}
