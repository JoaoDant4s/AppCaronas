import 'package:flutter/material.dart';

class BottomModal extends StatelessWidget {
  const BottomModal({super.key});
BoxDecoration myBoxDecoration(){
  return BoxDecoration(
    border: Border(top: BorderSide(
      color: Colors.black,
      width: 3.0,
    ))
  );
}
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 14.0),
            padding: const EdgeInsets.only(bottom: 70.0),
            width: 70,
            decoration: myBoxDecoration(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: GestureDetector(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width: 120.0,
                          height: 120.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/gifs/espanhol.gif"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      const Text(
                        "Passenger",
                        style: TextStyle(fontSize: 20,),
                      )
                    ],
                  ),
                  onTap: () {
                  Navigator.of(context).pushNamed(AppRoutes.REGISTER);
                  },
                ),
              ),
              Expanded(
                child: GestureDetector(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 120.0,
                        height: 120.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/gifs/volante.gif"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const Text(
                        "Driver",
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                  onTap: () {
                    print('you clicked me');
                  },
                ),
              )
            ],
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
