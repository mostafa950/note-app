import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/modules/BMI/BMI%20Result.dart';
import 'package:untitled1/shared/components/components.dart';

class BMIScreen extends StatefulWidget {
  @override
  State<BMIScreen> createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  bool isMale = false;
  double isHeight = 100;
  int age = 5;
  int weight = 5;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: words(
          color: Colors.white,
          name: "BMI Calculator",
        ),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black87,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isMale = true;
                        });
                      },
                      child: square(
                        name: 'Male',
                        image: "assets/male.png",
                        colorOfBox: isMale ? Colors.red : Colors.black,
                        colorOfWord: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isMale = false;
                        });
                      },
                      child: square(
                        name: 'Female',
                        image: "assets/female.png",
                        colorOfBox: isMale ? Colors.black : Colors.red,
                        colorOfWord: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                height: 180,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    words(
                      name: "Height",
                      color: Colors.black,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        words(color: Colors.black, name: "${isHeight.round()}"),
                        Text(
                          '.cm',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    Slider(
                        value: isHeight,
                        max: 220,
                        min: 80,
                        inactiveColor: Colors.black,
                        activeColor: Colors.red,
                        onChanged: (value) {
                          setState(() {
                            isHeight = value;
                          });
                        })
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: square2(
                      num: age,
                      name: "Age",
                      addFunction: () {
                        setState(() {
                          age += 5;
                        });
                      },
                      removeFunction: () {
                        setState(() {
                          age--;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  Expanded(
                    child: square2(
                      num: weight,
                      name: "Weight",
                      addFunction: () {
                        setState(() {
                          weight += 5;
                        });
                      },
                      removeFunction: () {
                        setState(() {
                          weight--;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                color: Colors.redAccent,
                width: double.infinity,
                child: MaterialButton(
                  onPressed: () {
                    double result = weight / pow(isHeight / 100, 2);
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BMIResult(
                                    age: age,
                                result: result,
                                gender: isMale? "Male" : "Female",
                                  )));
                    });
                  },
                  child: words(name: "calculate", color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
