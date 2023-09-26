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

  _submitSearch() {
    final origin = _originController.text;
    final destiny = _destinyController.text;

    if (origin.isEmpty && destiny.isEmpty) return;

    widget.onSearch(origin, destiny);
  }

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
              decoration: const InputDecoration(
                labelText: 'Origin',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
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
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF09C184),
                padding: const EdgeInsets.all(20.0),
              ),
              onPressed: _submitSearch,
              child: const Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
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
          ),
        ],
      ),
    );
  }
}
