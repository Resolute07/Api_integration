import 'dart:convert';
import 'dart:math';

import 'package:api_integration/screens/page2.dart';
import 'package:api_integration/services/api_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List? userList;
  Future getData() async {
    var page1 = await ApiClient.fetchData("users");
    var page2 = await ApiClient.fetchData("users?page=2");
    setState(() {
      userList = jsonDecode(page1.body)["data"];
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
        actions: [
          GestureDetector(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Page2()));
              },
              child: Row(
                children: [
                  Text("Next page"),
                  Icon(Icons.arrow_forward_ios),
                ],
              ))
        ],
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
