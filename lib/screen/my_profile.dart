import 'package:flutter/material.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF09C184),
        title: const Text(
          'Look for a ride',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Exibindo a imagem do usuário
            CircleAvatar(
              backgroundImage: AssetImage("assets/images/joao_dantas.jpg"),
            ),
            SizedBox(height: 16.0),

            // Exibindo informações do usuário
            Text('Nome: João Dantas', style: TextStyle(fontSize: 18.0)),
            Text('Email: joao.dantas@ufrn.edu.br',
                style: TextStyle(fontSize: 18.0)),
            Text('Gênero: Masculino', style: TextStyle(fontSize: 18.0)),
            Text('Data de Nascimento: 29/12/2001',
                style: TextStyle(fontSize: 18.0)),
            Text('Avaliação: 4.8', style: TextStyle(fontSize: 18.0)),
            SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
