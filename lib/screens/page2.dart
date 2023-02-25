import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../services/api_client.dart';

class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  List? userList;
  Future getData() async {
    var page2 = await ApiClient.fetchData("users?page=2");
    setState(() {
      userList = jsonDecode(page2.body)["data"];
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Api Integration"),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.all(height / 84.4),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(height / 42.2),
                gradient: LinearGradient(
                    colors: [Colors.blueAccent, Colors.blueGrey],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    transform: GradientRotation(pi / 2))),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(height / 42.2)),
                  child: Image.network(
                    "${userList?[index]["avatar"]}",
                  ),
                ),
                SizedBox(
                  width: width / 39,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${userList?[index]["first_name"].toString()}" +
                        "${userList?[index]["last_name"].toString()}"),
                    Text("${userList?[index]["email"].toString()}")
                  ],
                )
              ],
            ),
          );
        },
        itemCount: userList == null ? 0 : userList?.length,
      ),
    );
  }
}
