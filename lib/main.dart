import 'package:flutter/material.dart';

import 'tema/cores.dart';
import 'telas/tela_inicial.dart';

void main() {
  runApp(const MeAjudaFilhoteApp());
}

class MeAjudaFilhoteApp extends StatelessWidget {
  const MeAjudaFilhoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Me Ajuda, Filhote',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Montserrat',
        colorScheme: ColorScheme.fromSeed(seedColor: Cores.verde),
        scaffoldBackgroundColor: Cores.fundo,
      ),
      home: const TelaInicial(),
    );
  }
}
