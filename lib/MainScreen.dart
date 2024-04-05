import 'package:bucketlist/ViewItems.dart';
import 'package:bucketlist/addBucketList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<dynamic> dataFromApi = [];
  bool isLoading = false;
  bool isError=false;
  Future<void> getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      Response response = await Dio().get(
          "https://flutter1-9b7a6-default-rtdb.firebaseio.com/bucketlist.json");
      print(response.data);
      if (response.data is List){
        dataFromApi = response.data;
      }else{
        dataFromApi = [];
      }

      isLoading = false;
      isError=false;
      setState(() {});
    } catch (e) {
      isLoading = false;
      isError=true;
      setState(() {});
      
    }
  }
Widget ErrorMsg(String errorText){
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.warning),
        SizedBox(height: 10,),
        Text(errorText),
        SizedBox(height: 10,),
        ElevatedButton(onPressed: (){getData();}, child: Text("Try Again"))
      ],),
  );
}
Widget ListData(){
    return ListView.builder(
        itemCount: dataFromApi.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child:
            (dataFromApi[index] is Map) ? ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                      return ViewItemsScreen(
                        index: index,
                        title: dataFromApi[index]['item'] ?? "",
                        imageUrl: dataFromApi[index]['image'] ?? "",
                      );
                    }));
              },
              leading: CircleAvatar(
                backgroundImage:
                NetworkImage(dataFromApi[index]?['image'] ?? ""),
              ),
              title: Text(dataFromApi[index]['item'] ?? ""),
              trailing: Text(dataFromApi[index]['price'] ?? ""),
            ) : SizedBox(),
          );
        });
}
  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AddBucketListScreen();
          }));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Color(0xFF202020),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text("BucketList App"),
        actions: [
          InkWell(
            onTap: getData,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.refresh),
            ),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          getData();
        },
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : isError ? ErrorMsg("Error While Connecting to Server") : dataFromApi.length <1 ? Center(child:
        Text("No List Added",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),) :ListData(),
      ),
    );
  }
}
