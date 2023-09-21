import 'package:flutter/material.dart';

class BottomModal extends StatelessWidget {
  const BottomModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/gifs/espanhol.gif",
                  height: 120.0,
                  width: 120.0,
                ),
                const Text(
                  "Passageiro",
                  style: TextStyle(fontSize: 27),
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/gifs/volante.gif",
                  height: 120.0,
                  width: 120.0,
                ),
                const Text(
                  "Motorista",
                  style: TextStyle(fontSize: 27),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
