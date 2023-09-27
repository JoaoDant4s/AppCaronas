import 'dart:io';

import 'package:caronas/models/user.dart';

final loginData = [
  User(
    id: '1',
    email: 'joao.dantas.017@ufrn.edu.br',
    birth: DateTime(2001, 12, 29),
    gender: 'Male',
    name: 'João Dantas',
    password: 'senha123',
    image: File('assets/images/joao_dantas.jpg'),
    rating: 4.2,
  ),
  User(
    id: '2',
    email: 'usuario2@example.com',
    birth: DateTime(1985, 8, 22),
    gender: 'Female',
    name: 'User 2',
    password: 'password456',
    image: File('/path/to/image2.png'),
    rating: 4.2,
  ),
  User(
    id: '3',
    email: 'usuario3@example.com',
    birth: DateTime(1995, 3, 10),
    gender: 'Male',
    name: 'User 3',
    password: 'password789',
    image: File('/path/to/image3.png'),
    rating: 4.7,
  ),
  User(
    id: '4',
    email: 'usuario4@example.com',
    birth: DateTime(1988, 12, 5),
    gender: 'Female',
    name: 'User 4',
    password: 'passwordabc',
    image: File('/path/to/image4.png'),
    rating: 4.0,
  ),
  User(
    id: '5',
    email: 'usuario5@example.com',
    birth: DateTime(1992, 9, 20),
    gender: 'Male',
    name: 'User 5',
    password: 'passwordxyz',
    image: File('/path/to/image5.png'),
    rating: 4.9,
  ),
  User(
    id: '6',
    email: 'usuario6@example.com',
    birth: DateTime(1987, 6, 12),
    gender: 'Female',
    name: 'User 6',
    password: 'passwordmno',
    image: File('/path/to/image6.png'),
    rating: 3.8,
  ),
  User(
    id: '7',
    email: 'usuario7@example.com',
    birth: DateTime(1993, 7, 8),
    gender: 'Male',
    name: 'User 7',
    password: 'password789',
    image: File('/path/to/image7.png'),
    rating: 3.5,
  ),
  User(
    id: '8',
    email: 'usuario8@example.com',
    birth: DateTime(1998, 4, 25),
    gender: 'Female',
    name: 'User 8',
    password: 'passwordxyz',
    image: File('/path/to/image8.png'),
    rating: 4.8,
  ),
  User(
    id: '9',
    email: 'usuario9@example.com',
    birth: DateTime(1989, 12, 18),
    gender: 'Male',
    name: 'User 9',
    password: 'passwordmnp',
    image: File('/path/to/image9.png'),
    rating: 4.2,
  ),
  User(
    id: '10',
    email: 'usuario10@example.com',
    birth: DateTime(1996, 2, 14),
    gender: 'Female',
    name: 'User 10',
    password: 'passwordjkl',
    image: File('/path/to/image10.png'),
    rating: 4.6,
  ),
];
