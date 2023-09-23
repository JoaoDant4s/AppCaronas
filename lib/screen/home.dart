import 'package:caronas/components/bottom_modal.dart';
import 'package:caronas/components/drawer.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void _showBottomModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      clipBehavior: Clip.hardEdge,
      builder: (BuildContext context) {
        return BottomModal();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        width: 70,
        height: 70,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () {
              _showBottomModal(context);
            },
            backgroundColor: const Color(0xFF09C184),
            shape: const CircleBorder(),
            child: const Icon(
              Icons.directions_car,
              color: Colors.white,
              size: 35,
            ),
          ),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "EasyDrive",
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
        leading: Builder(
          builder: (BuildContext context) => IconButton(
            icon: const Icon(
              Icons.menu,
              size: 40,
              color: Colors.white,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        actions: const [
          SizedBox(
            width: 40,
            height: 40,
          )
        ],
      ),
      drawer: HomeDrawer(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Hello there!",
                          style: TextStyle(fontSize: 27, fontWeight: FontWeight.w500,),
                        ),
                        SizedBox(height: 30,),
                        Text('How about we look for a ride?',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey[700], fontSize: 12),)
                      ],
                    ),
                  ],
                ),
              ),
              Stack(children: <Widget>[Image(image: AssetImage("assets/images/3dcar.png"),width: 800,fit: BoxFit.cover,),

              ],)
            ],
          ),
        ),
      ),
    );
  }
}
