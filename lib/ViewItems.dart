import 'package:bucketlist/MainScreen.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
class ViewItemsScreen extends StatefulWidget {
  String title;
  String imageUrl;
  int index;
  ViewItemsScreen({super.key, required this.title, required this.imageUrl,required this.index});

  @override
  State<ViewItemsScreen> createState() => _AddBucketListScreenState();
}

class _AddBucketListScreenState extends State<ViewItemsScreen> {
  void printData() {
    print("$widget.title");
  }
  
  void deleteData()async{
    try{
      Response response = await Dio().delete("https://flutter1-9b7a6-default-rtdb.firebaseio.com/bucketlist/${widget.index}.json");
    }catch(e){
      print(e);
    }
  }
  @override
  initState() {
    printData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.title}"),
        actions: [
          PopupMenuButton(
              onSelected: (value){
                if(value==1){
                  showDialog(context: context, builder: (context){
                    return AlertDialog(
                      actions: [
                        InkWell(onTap:(){
                          Navigator.pop(context);
                        },child: Text("Cancel")),
                        InkWell(onTap:(){
                          deleteData();
                          Navigator.push(context,MaterialPageRoute(builder: (context){return MainScreen();}));
                        },child: Text("Confirm"))
                      ],
                      title: Text("Are you sure to Delete"),);
                  });
                }
              },
              itemBuilder: (context) {
            return [
              PopupMenuItem(value:1,child: Text("Delete"),),
              PopupMenuItem(value:2,child: Text("Mark as Done"),),

            ];
          })
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover, image: NetworkImage(widget.imageUrl))),
          ),
        ],
      ),
    );
  }
}
