import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main()
{

  runApp(MaterialApp(home: demo(),
    debugShowCheckedModeBanner: false,
  ));

}
class demo extends StatefulWidget {
  const demo({Key? key}) : super(key: key);

  @override
  State<demo> createState() => _demoState();
}

class _demoState extends State<demo> {

  int h=0;
  int m=0;
  int s=0;
  bool t=false;


  @override
  void initState()
  {

    super.initState();
    get().listen((event){
      print("Time : $event");
    });

  }
  Stream<String> get()
  async*{

    while(true)
    {

      String time = "${h} : ${m} : ${s}";
      await Future.delayed(Duration(milliseconds: 19));
      if(t)
      {

        s++;
        if(s<=100)
        {

        }
        else if(s>100 )
        {

          m++;
          s = 0;

        }
        if(m<=60)
        {

        }
        else if(m>60)
        {
          h++;
          m = 0;

        }

      }
      yield time;

    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Time",style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold,fontStyle:FontStyle.italic,color: Colors.yellowAccent),),centerTitle: true,backgroundColor: Colors.black,),
        backgroundColor: Colors.black,
        body:Column(children: [
          StreamBuilder(stream: get(),builder: (context, snapshot) {
            if(snapshot.connectionState==ConnectionState.waiting)
            {

              return Column(children: [Container(margin: EdgeInsets.only(top: 200),child: CircularProgressIndicator(color: Colors.white,),)],);

            }
            else
            {

              return Column(children: [Container(alignment: Alignment.center,height: 210,width: 210,margin: EdgeInsets.only(top: 150),
                  decoration: BoxDecoration(border: Border.all(width: 5,color: Colors.yellowAccent),color:  Colors.black,shape: BoxShape.circle),
                  child: Text("${snapshot.data}",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,color: Colors.yellowAccent,fontStyle: FontStyle.italic),))]);

            }
          },),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(margin: EdgeInsets.all(15),child: ElevatedButton.icon(onPressed: () {
                setState(() {
                  t=true;
                });
              }, icon: Icon(Icons.not_started_outlined),label: Text('Start'),style: ElevatedButton.styleFrom(primary: Colors.black,elevation: 35,shadowColor:Colors.yellowAccent,textStyle: TextStyle(color: Colors.white) ),),),
              Container(margin: EdgeInsets.all(15),child: ElevatedButton.icon(onPressed: () {
                setState(() {
                  t=false;
                });
              },
                icon:Icon(Icons.stop), label: Text("Stop"),style: ElevatedButton.styleFrom(primary: Colors.black,elevation: 35,shadowColor: Colors.yellowAccent,textStyle: TextStyle(color: Colors.yellowAccent)),),),
              Container(margin: EdgeInsets.all(15),child: ElevatedButton.icon(onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                  return demo();
                },));
              },
                icon:Icon(Icons.restart_alt_sharp), label: Text("Restart"),style: ElevatedButton.styleFrom(primary: Colors.black,elevation: 35,shadowColor: Colors.yellowAccent,textStyle: TextStyle(color: Colors.yellowAccent)),),),


            ],),
        ])

    );
  }
}
