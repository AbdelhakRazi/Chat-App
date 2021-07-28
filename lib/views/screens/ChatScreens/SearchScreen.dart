import 'package:chat_app/AuthManagment/Auth.dart';
import 'package:chat_app/AuthManagment/Chat.dart';
import 'package:chat_app/config/colors.dart';
import 'package:chat_app/config/icons.dart';
import 'package:chat_app/views/routes/routes.dart';
import 'package:chat_app/views/routes/routes_names.dart';
import 'package:chat_app/views/screens/ChatScreens/ChatScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  TextEditingController searchctl = new TextEditingController();
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Chat _chat = new Chat();
  Auth _auth = new Auth();
  Widget build(BuildContext context) {
    final scheight = MediaQuery.of(context).size.height;
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
                        RouteSettings(name: AppRoutes.choose)));
              })
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _chat.showUsers(widget.searchctl.text),
        builder: (BuildContext ctx, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      "Communicate\nWith Anyone",
                      style: Theme.of(context)
                          .textTheme
                          .headline1
                          .copyWith(fontSize: 30),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: scheight * 0.02,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: TextField(
                      cursorColor: AppColors.white,
                      style: Theme.of(context).textTheme.bodyText2,
                      controller: widget.searchctl,
                      decoration: InputDecoration(
                        fillColor: AppColors.msgcolor,
                        hintText: "Search any user",
                        suffixIcon: IconButton(
                          icon: AppIcons.search,
                          onPressed: () async {},
                        ),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: scheight * 0.02,
                  ),
                ),
                SliverList(
                    delegate: SliverChildBuilderDelegate(
                  (BuildContext ctx, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatScreen(
                                      email: snapshot.data.docs[index]["email"],
                                      uid: snapshot.data.docs[index]["uid"],
                                    )));
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                        margin: EdgeInsets.only(
                          left: 20,
                          bottom: 10,
                          right: 20,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.msgcolor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              snapshot.data.docs[index]["name"],
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(fontSize: 20),
                            ),
                            Text(
                              snapshot.data.docs[index]["email"],
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  childCount: snapshot.data.docs.length,
                )),
              ],
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
