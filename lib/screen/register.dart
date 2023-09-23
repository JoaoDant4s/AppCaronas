import 'package:flutter/material.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Register your ride here',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body:SingleChildScrollView(
        reverse: true,
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0),
                    blurRadius: 6.0,
                  )
                ],
              ),
              child: Column(
                children: [
                  SizedBox(height: 60.0,),
                  Container(
                    width: 180.0,
                    height: 180.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/gifs/car.gif"),


                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(top: 80, right: 50, left: 50),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Origin',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(top: 40, right: 50, left: 50),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Destiny',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(top: 40, right: 50, left: 50,bottom: 30),
                    child: TextField(
                      decoration: InputDecoration(

                        labelText: 'Date',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar:

      Container(
        margin: EdgeInsets.only(bottom: 38, left: 50, right: 50),

        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF09C184),
            padding: EdgeInsets.all(20),
          ),
          onPressed: () {},
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Register',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 20,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),

    );
  }
}