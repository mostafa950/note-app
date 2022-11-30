import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/shared/components/components.dart';

class BMIResult extends StatelessWidget {
  final int? age ;
  final double? result ;
  final String? gender ;

  BMIResult({
    @required this.age,
    @required this.result,
    @required this.gender,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: words(
          color: Colors.white,
          name: "BMI Result",
        ),
        backgroundColor: Colors.black,
        leading: MaterialButton(
          onPressed: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.reply_rounded,color: Colors.white,),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 100 , vertical: 250),
        child: Center(
          child: Column(
            children:
            [
              words(name: "${result!.round()}", color: Colors.black, ),
              words(name: gender , color: Colors.black, ),
              words(name: "${age}" , color: Colors.black, ),
            ],
          ),
        ),
      ),
    );
  }
}
