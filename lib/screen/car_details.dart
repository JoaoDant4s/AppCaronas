import 'package:flutter/material.dart';
import '../models/car.dart';

class CarDetail extends StatefulWidget {
  final Car car;

  const CarDetail(this.car);

  @override
  State<CarDetail> createState() => _CarDetailState();
}

class _CarDetailState extends State<CarDetail> {
  // Função para mostrar o diálogo de confirmação de exclusão
  Future<void> _showDeleteConfirmationDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmação de Exclusão'),
          content: Text('Tem certeza de que deseja excluir este carro?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Fecha o diálogo
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                // Coloque a lógica para excluir o carro aqui
                // Após a exclusão, você pode navegar para a página anterior ou fazer outra ação necessária
                Navigator.of(context).pop(); // Fecha o diálogo
                // Adicione a lógica de exclusão aqui
              },
              child: Text('Excluir'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF09C184),
        title: const Text(
          'Car Details',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Icon(
                Icons.directions_car,
                size: 100,
                color: const Color(0xFF09C184),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: Icon(Icons.branding_watermark),
                  title: Text(
                    'Brand: ${widget.car.brand}',
                    style: const TextStyle(fontSize: 18.0),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.car_rental),
                  title: Text(
                    'Model: ${widget.car.model}',
                    style: const TextStyle(fontSize: 18.0),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.calendar_today),
                  title: Text(
                    'Year: ${widget.car.year}',
                    style: const TextStyle(fontSize: 18.0),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.local_parking),
                  title: Text(
                    'License Plate: ${widget.car.licensePlate}',
                    style: const TextStyle(fontSize: 18.0),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.color_lens),
                  title: Text(
                    'Color: ${widget.car.color}',
                    style: const TextStyle(fontSize: 18.0),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.event_seat),
                  title: Text(
                    'Available Seats: ${widget.car.availableSeats}',
                    style: const TextStyle(fontSize: 18.0),
                  ),
                ),
                // Adicione outras informações do carro como desejado
                // Por exemplo:
                // ListTile(
                //   leading: Icon(Icons.feature),
                //   title: Text(
                //     'Feature: ${widget.car.feature}',
                //     style: const TextStyle(fontSize: 18.0),
                //   ),
                // ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF09C184),
                      minimumSize: const Size(200, 60),
                    ),
                    onPressed: () {
                      // Coloque a lógica para editar as características do carro aqui
                    },
                    child: const Text(
                      'Editar',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF09C184),
                      minimumSize: const Size(200, 60),
                    ),
                    onPressed: () {
                      _showDeleteConfirmationDialog(); // Mostra o diálogo de confirmação de exclusão
                    },
                    child: const Text(
                      'Excluir',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
