import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDEDED),
      appBar: AppBar(
        backgroundColor: const Color(0xFF09C184),
        title: Text(
          'Look for a ride',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: 300.0,
            margin: EdgeInsets.all(20.0),
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.9),
                  offset: Offset(2, 2),
                  blurRadius: 4.0,
                ),
              ],
            ),
            child: Column(
              children: [
                SizedBox(height: 70.0),
                Container(
                  width: 140.0,
                  height: 140.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/gifs/map.gif"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 50.0),
                Container(
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      offset: Offset(0, 2),
                      blurRadius: 4.0,
                    ),
                  ],
                ),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Origin',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Icon(Icons.location_on),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        offset: Offset(0, 2),
                        blurRadius: 4.0,
                      ),
                    ],
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      labelText: 'Destiny',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.location_on),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        offset: Offset(0, 2),
                        blurRadius: 4.0,
                      ),
                    ],
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Date',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.calendar_today),
                    ),
                  ),
                ),
                SizedBox(height: 80.0),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
          margin: EdgeInsets.only(top: 25, bottom: 20.0, left: 40.0, right: 40.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF09C184),
            padding: EdgeInsets.all(20.0),
          ),
          onPressed: () {},
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.search,
                color: Colors.white,
              ),
              SizedBox(width: 10.0),
              Text(
                'Search',
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
