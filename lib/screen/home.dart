import 'package:caronas/components/bottom_modal.dart';
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
        actions: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.menu,
                    size: 40,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
                const Text(
                  "CARON",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                const SizedBox(
                  width: 55,
                )
              ],
            ),
          )
        ],
      ),
      body: const Center(
        child: Text(
          "Home Page",
          style: TextStyle(fontSize: 40),
        ),
      ),
    );
  }
}
