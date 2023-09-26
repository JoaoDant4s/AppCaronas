import 'package:flutter/material.dart';

class SearchBarRide extends StatefulWidget {
  void Function(String, String) onSearch;

  SearchBarRide(this.onSearch);
  @override
  State<SearchBarRide> createState() => _SearchBarRideState();
}

class _SearchBarRideState extends State<SearchBarRide> {
  final _originController = TextEditingController();
  final _destinyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.9),
            offset: const Offset(2, 2),
            blurRadius: 4.0,
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  offset: const Offset(0, 2),
                  blurRadius: 4.0,
                ),
              ],
            ),
            child: TextField(
              controller: _destinyController,
              onChanged: (value) {
                widget.onSearch(
                  _originController.text,
                  _destinyController.text,
                );
              },
              decoration: const InputDecoration(
                fillColor: Colors.white,
                filled: true,
                labelText: 'Destiny',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.location_on),
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  offset: const Offset(0, 2),
                  blurRadius: 4.0,
                ),
              ],
            ),
            child: TextField(
              controller: _originController,
              onChanged: (value) {
                widget.onSearch(
                  _originController.text,
                  _destinyController.text,
                );
              },
              decoration: const InputDecoration(
                labelText: 'Origin',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
                prefixIcon: Icon(Icons.location_on),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  offset: const Offset(0, 2),
                  blurRadius: 4.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
