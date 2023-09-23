import 'package:flutter/material.dart';
import 'dart:convert'; // Importe esta biblioteca para trabalhar com JSON

class CarpoolList extends StatefulWidget {
  const CarpoolList({super.key});

  @override
  State<CarpoolList> createState() => _CarpoolList();
}

class _CarpoolList extends State<CarpoolList> {
  List<CardData> cardList = []; // Lista de dados dos cards

  @override
  void initState() {
    super.initState();
    loadCardData(); // Carregue os dados dos cards ao iniciar a tela
  }

  void loadCardData() async {
    // Suponha que você tenha um arquivo JSON chamado 'cards.json' na pasta assets.
    String jsonStr = await DefaultAssetBundle.of(context).loadString('assets/cards.json');
    List<dynamic> jsonList = jsonDecode(jsonStr);

    // Converta os dados JSON em objetos CardData
    List<CardData> cards = [];
    for (var json in jsonList) {
      cards.add(CardData.fromJson(json));
    }

    setState(() {
      cardList = cards;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "EasyDrive",
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back, // Ícone de seta para a esquerda
            size: 40,
            color: Colors.white,
          ),
          onPressed: () {
            // Navegar de volta para a página inicial
            Navigator.of(context).pop();
          },
        ),
        actions: const [
          SizedBox(
            width: 40,
            height: 40,
          )
        ],
      ),
      body: Stack(
        children: [
          Container(
            color: Color.fromRGBO(0, 0, 0, 0.2), // Cor de sobreposição semi-transparente
          ),
          Center(
            child: CardListWidget(cardList: cardList),
          ),
        ],
      ),
    );
  }
}

class CardData {
  final String name;
  final String userImage;
  final double rating;
  final double price;
  final String time;
  final String availableSeats;

  CardData({
    required this.name,
    required this.userImage,
    required this.rating,
    required this.price,
    required this.time,
    required this.availableSeats,
  });

  factory CardData.fromJson(Map<String, dynamic> json) {
    return CardData(
      name: json['name'],
      userImage: json['userImage'],
      rating: json['rating'],
      price: json['price'],
      time: json['time'],
      availableSeats: json['availableSeats'],
    );
  }
}
class CardListWidget extends StatelessWidget {
  final List<CardData> cardList;

  CardListWidget({required this.cardList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(16.0),
      itemCount: cardList.length,
      itemBuilder: (BuildContext context, int index) {
        final card = cardList[index];

        return Card(
          child: Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(card.userImage),
                ),
                title: Text(card.name),
                subtitle: Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber),
                    Text(card.rating.toString()),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('\$${card.price.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 12.0),
                    ),
                    Text('${card.time}',
                      style: TextStyle(fontSize: 12.0),
                    ),
                    Text('${card.availableSeats}',
                      style: TextStyle(fontSize: 12.0),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
