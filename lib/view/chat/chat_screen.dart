import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/config/colors.dart';
import 'package:my_app/config/image_string.dart';
import 'package:my_app/extension/media_query_extension.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        scrolledUnderElevation: 0.0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: AppColors.lightoffblack,
            )),
        // actions: [
        //   IconButton(
        //     onPressed: () {},
        //     icon: SvgPicture.asset(
        //       ImageString.search,
        //       width: 20,
        //       height: 20,
        //     ),
        //   )
        // ],
      ),
      extendBody: true,
      body: Column(
        children: [
       
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.only(
                      left: 14, right: 14, top: 10, bottom: 10),
                  child: Align(
                    alignment: (messages[index].messageType == "receiver"
                        ? Alignment.topLeft
                        : Alignment.topRight),
                    child: Row(
                      mainAxisAlignment:
                          (messages[index].messageType == "receiver"
                              ? MainAxisAlignment.start
                              : MainAxisAlignment.end),
                      children: [
                        Container(
                          width: 50.w,
                          height: 50.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: messages[index].messageType == "sender"
                                ? Colors.transparent
                                : AppColors.lightoffblack,
                            border: messages[index].messageType == "sender"
                                ? Border.all(
                                    color: AppColors.redColor, width: 1.5)
                                : null,
                            image: messages[index].messageType == "sender"
                                ? const DecorationImage(
                                    image: AssetImage(ImageString.girlImage))
                                : null,
                          ),
                          child: messages[index].messageType == "receiver"
                              ? const Icon(
                                  Icons.person,
                                  color: Colors.white,
                                )
                              : const SizedBox(),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: context.width * .7,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: (messages[index].messageType == "receiver"
                                ? const Color(0xffF3F4F6)
                                : AppColors.redColor),
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            messages[index].messageContent,
                            style: GoogleFonts.roboto(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                                color:
                                    (messages[index].messageType == "receiver")
                                        ? AppColors.lightoffblack
                                        : Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0.r),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black45,
                      offset: Offset(-1, -1),
                      spreadRadius: 0.5,
                      blurRadius: 0.4),
                  BoxShadow(
                      color: Colors.black45,
                      offset: Offset(1, 1),
                      spreadRadius: 0.5,
                      blurRadius: 0.4)
                ]),
            margin: const EdgeInsets.all(20),
            child: TextField(
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0.r),
                      borderSide: BorderSide.none),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0.r),
                      borderSide: BorderSide.none),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0.r),
                      borderSide: BorderSide.none),
                  hintText: "Type here...",
                  hintStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18.sp,
                      color: const Color(0xffDBDADA)),
                  suffixIcon: Container(
                    width: 50.w,
                    height: 50.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0.r),
                      color: AppColors.redColor,
                    ),
                    child: Center(
                      child: IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(ImageString.paperPlane)),
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }

  List<ChatMessage> messages = [
    ChatMessage(
        messageContent: "Hi, how can I help you?", messageType: "receiver"),
    ChatMessage(
        messageContent:
            "Hello, I ordered two fried chicken burgers. can I know how much time it will get to arrive?",
        messageType: "sender"),
    ChatMessage(
        messageContent: "Ok, please let me check!", messageType: "receiver"),
    ChatMessage(messageContent: "Sure...", messageType: "sender"),
    ChatMessage(
        messageContent: "It’ll get 25 minutes to arrive to your address",
        messageType: "receiver"),
    ChatMessage(
        messageContent: "Ok, thanks you for your support",
        messageType: "sender"),
  ];
}

class ChatMessage {
  String messageContent;
  String messageType;
  ChatMessage({required this.messageContent, required this.messageType});
}
