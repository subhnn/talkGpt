import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talkgpt/histroryModel.dart';
import 'package:talkgpt/services.dart';

class ViewVisitor extends StatefulWidget {
  const ViewVisitor({super.key});

  @override
  State<ViewVisitor> createState() => _ViewVisitorState();
}

class _ViewVisitorState extends State<ViewVisitor> {
  Future<List<Speechs>>? data;

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  Future<void> initializeData() async {
    SharedPreferences prefer = await SharedPreferences.getInstance();
    String userId = prefer.getString("securityId") ?? "";
    setState(() {
      data = SecurityApiService().getSpeechs(userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
          ),
          title: Text("Prompt History", style: TextStyle(color: Colors.white)),
          backgroundColor: Color(0xFF000066),
        ),
        body: FutureBuilder<List<Speechs>>(
          future: data,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Color(0xFF9EB7D3),
                    child: ListTile(
                      subtitle: Text(snapshot.data![index].speech),
                    ),
                  );
                },
              );
            } else {
              return Center(child: Text("No data found"));
            }
          },
        ),
      ),
    );
  }
}
