import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(myApp());
}

class myApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: ThemeData(primaryColor: Colors.pinkAccent) ,home: demo(),);
  }
}

class demo extends StatefulWidget {
  @override
  demoState createState() => demoState();
}

class demoState extends State<demo> {

  TextEditingController heightController=TextEditingController();
  TextEditingController weightController=TextEditingController();
  double? result1;
  String? bmi_status;
  bool validateh = false , validatew = false;

  Color? getTextColor(String? s1) {
    if (s1 == "正常") {
      return Colors.green;
    }
    else if (s1 == "過輕") {
      return Colors.amberAccent;
    }
    else if (s1 == "過重") {
      return Colors.redAccent;
    }
  }

  @override
  void dispose() {
    heightController.dispose();
    weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("BMI Calculator"), centerTitle: true, backgroundColor: Colors.pinkAccent,),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'height in cm',
                hintText: 'cm',
                errorText: validateh? "不得為空" : null,
                icon: Icon(Icons.trending_up),
              ),
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(height: 20),
            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'weight in Kg',
                hintText: 'kg',
                errorText: validatew? "不得為空" : null,
                icon: Icon(Icons.trending_down),
              ),
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              child: Text("計算", style: TextStyle(color: Colors.white),),
              onPressed: () {
                setState(() {
                  heightController.text.isEmpty? validateh=true : validateh=false;
                  weightController.text.isEmpty? validatew=true : validatew=false;
                });
                calculateBMI(); },
              style: ElevatedButton.styleFrom(textStyle: TextStyle(fontSize: 20)),
            ),
            SizedBox(height: 15),
            Text(
              result1==null?"":"您的BMI值 = ${result1?.toStringAsFixed(2)}",
              style: TextStyle(color:Colors.blueAccent,
                  fontSize: 22,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 15),
            RichText(text: TextSpan(style:TextStyle(color: Colors.blueAccent,
                fontSize: 22,
                fontWeight: FontWeight.w500) ,
                children:<TextSpan>[
                  TextSpan(text: bmi_status==null? "" : "您的體重狀態為 : "),
                  TextSpan(text: bmi_status==null? "" : "${bmi_status}",
                      style:TextStyle(color: getTextColor(bmi_status),
                          fontWeight:FontWeight.bold)),


                ]))
            //          Text(
            //           bmi_status==null?"":"您的體重狀態為 : ${bmi_status}",
            //            style: TextStyle(color:Colors.blueAccent,
            //                fontSize: 22,
            //               fontWeight: FontWeight.w500),
            //         ),
          ],
        ),
      ),
    );
  }
  void calculateBMI() {
    double h=double.parse(heightController.text)/100;
    double w=double.parse(weightController.text);
    double result=w/(h*h);
    result1=result;
    if(result1! < 18.5) {
      bmi_status = "過輕";
    }
    else if (result1! > 25) {
      bmi_status = "過重";
    }
    else {
      bmi_status = "正常";
    }
    setState(() {});
  }
}