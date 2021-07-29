import 'package:chat_app/AuthManagment/Auth.dart';
import 'package:chat_app/AuthManagment/Chat.dart';
import 'package:chat_app/AuthManagment/Message.dart';
import 'package:chat_app/config/colors.dart';
import 'package:chat_app/config/icons.dart';
import 'package:chat_app/views/routes/routes.dart';
import 'package:chat_app/views/routes/routes_names.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  @override
  String email;
  String uid;
  ChatScreen({
    this.email,
    this.uid,
  });
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  ScrollController _scrollController;
  TextEditingController messagectl;
  void initState() {
    _scrollController = ScrollController();
    super.initState();
    messagectl = new TextEditingController();
  }

  void dispose() {
    messagectl.dispose();
    super.dispose();
  }

  FocusNode _node = FocusNode();
  Chat _chat = new Chat();
  Auth _auth = new Auth();
  Message msg = new Message();
  String text;

  Widget build(BuildContext context) {
    final scwidth = MediaQuery.of(context).size.width;
    final scheight = MediaQuery.of(context).size.height;
    final user = Provider.of<User>(context);
    final us1mail = user.email;
    final us2mail = widget.email;
    String chatidCreation() {
      String chatid;
      if (us1mail.substring(0, 1).codeUnitAt(0) >
          us2mail.substring(0, 1).codeUnitAt(0)) {
        chatid = "$us2mail\_$us1mail";
      } else {
        chatid = "$us1mail\_$us2mail";
      }
      return chatid;
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                await _auth.signOut();
                Navigator.pushReplacement(
                    context,
                    Routes.onGenerateRoute(
                        RouteSettings(name: AppRoutes.login)));
              })
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: _chat.showMessages(chatidCreation()),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data.docs.length);
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: ListView.builder(
                        reverse: true,
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, int index) {
                          return buildMessageBubble(
                              snapshot, index, scwidth, context);
                        },
                        itemCount: snapshot.data.docs.length,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Stack(
                      children: [
                        buildTextFieldsendmessage(context, user),
                        Positioned(
                          right: 10,
                          top: 5,
                          child: IconButton(
                            highlightColor: AppColors.field,
                            icon: AppIcons.snd,
                            onPressed: () async {
                              _node.unfocus();
                              if (messagectl.text.isNotEmpty) {
                                msg.message = messagectl.text;
                                msg.sender = user.email;
                                msg.time = DateTime.now();
                                await _chat.sendMessage(
                                  msg,
                                  user.email,
                                  widget.email,
                                );
                                messagectl.clear();
                                msg.message = null;
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }

  UnconstrainedBox buildMessageBubble(AsyncSnapshot<QuerySnapshot> snapshot,
      int index, double scwidth, BuildContext context) {
    return UnconstrainedBox(
      alignment: Alignment(
          snapshot.data.docs[index]["by"] == widget.email ? -0.8 : 0.8, 0),
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
        constraints: BoxConstraints(
          maxWidth: scwidth * 0.7,
        ),
        decoration: BoxDecoration(
            color: snapshot.data.docs[index]["by"] == widget.email
                ? AppColors.grey
                : AppColors.msgcolor,
            borderRadius: BorderRadius.circular(20)),
        margin: EdgeInsets.only(bottom: 10),
        child: Text(
          snapshot.data.docs[index]["message"],
          style: Theme.of(context).textTheme.bodyText2.copyWith(
              fontSize: 18,
              color: snapshot.data.docs[index]["by"] == widget.email
                  ? AppColors.backgrd
                  : AppColors.white),
        ),
      ),
    );
  }

  TextField buildTextFieldsendmessage(BuildContext context, User user) {
    return TextField(
      focusNode: _node,
      maxLines: null,
      cursorColor: AppColors.white,
      style: Theme.of(context).textTheme.bodyText2,
      controller: messagectl,
      decoration: InputDecoration(
        fillColor: AppColors.msgcolor,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: BorderSide.none,
        ),
        hintText: "Enter your message",
      ),
    );
  }
}
