import 'package:flutter/material.dart';

class ViewItemsScreen extends StatefulWidget {
  String title;
  String imageUrl;

  ViewItemsScreen({super.key, required this.title, required this.imageUrl});

  @override
  State<ViewItemsScreen> createState() => _AddBucketListScreenState();
}

class _AddBucketListScreenState extends State<ViewItemsScreen> {
  void printData() {
    print("$widget.title");
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
                          Navigator.pop(context);
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
