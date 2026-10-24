import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../tema/cores.dart';

/// Tela inicial do app, reproduzida a partir do Figma ("Telas MAF").
///
/// O layout original foi desenhado num quadro de 1080 px de largura. Todas as
/// medidas abaixo estão nessa unidade e são convertidas pela [_escala], que
/// adapta o desenho à largura real da tela.
class TelaInicial extends StatelessWidget {
  const TelaInicial({
    super.key,
    this.onPesquisar,
    this.onTutorialDoMaf,
    this.onWhatsapp,
    this.onUber,
    this.onYoutube,
    this.onIfood,
    this.onHistorico,
    this.onFavoritos,
  });

  final ValueChanged<String>? onPesquisar;
  final VoidCallback? onTutorialDoMaf;
  final VoidCallback? onWhatsapp;
  final VoidCallback? onUber;
  final VoidCallback? onYoutube;
  final VoidCallback? onIfood;
  final VoidCallback? onHistorico;
  final VoidCallback? onFavoritos;

  static const double _larguraFigma = 1080;
  static const double _margem = 120;
  static const double _espacoEntreCards = 72;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Cores.fundo,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final escala = constraints.maxWidth / _larguraFigma;
            double s(double valor) => valor * escala;

            return SingleChildScrollView(
              padding: EdgeInsets.all(s(_margem)),
              child: Column(
                children: [
                  _BarraDePesquisa(escala: escala, onPesquisar: onPesquisar),
                  SizedBox(height: s(24)),
                  _BotaoTutorialDoMaf(escala: escala, onTap: onTutorialDoMaf),
                  SizedBox(height: s(48)),
                  _LinhaDeCards(
                    escala: escala,
                    esquerda: _CardTema(
                      escala: escala,
                      titulo: 'WHATSAPP',
                      icone: _IconeSvg('whatsapp', escala: escala),
                      onTap: onWhatsapp,
                    ),
                    direita: _CardTema(
                      escala: escala,
                      titulo: 'UBER',
                      icone: _IconeSvg('uber', escala: escala),
                      onTap: onUber,
                    ),
                  ),
                  SizedBox(height: s(_espacoEntreCards)),
                  _LinhaDeCards(
                    escala: escala,
                    esquerda: _CardTema(
                      escala: escala,
                      titulo: 'YOUTUBE',
                      icone: _IconeSvg('youtube', escala: escala),
                      onTap: onYoutube,
                    ),
                    direita: _CardTema(
                      escala: escala,
                      titulo: 'IFOOD',
                      icone: _IconeSvg('ifood', escala: escala),
                      onTap: onIfood,
                    ),
                  ),
                  SizedBox(height: s(_espacoEntreCards)),
                  _LinhaDeCards(
                    escala: escala,
                    esquerda: _CardTema(
                      escala: escala,
                      titulo: 'HISTÓRICO',
                      cor: Cores.azulEscuro,
                      icone: const Icon(Icons.replay),
                      onTap: onHistorico,
                    ),
                    direita: _CardTema(
                      escala: escala,
                      titulo: 'FAVORITOS',
                      cor: Cores.azulEscuro,
                      icone: _TresEstrelas(escala: escala),
                      onTap: onFavoritos,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Estilo de texto padrão das telas: Montserrat Black, 48 px no Figma.
TextStyle _estiloTexto(double escala, Color cor) => TextStyle(
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.w900,
      fontSize: 48 * escala,
      color: cor,
    );

class _BarraDePesquisa extends StatelessWidget {
  const _BarraDePesquisa({required this.escala, this.onPesquisar});

  final double escala;
  final ValueChanged<String>? onPesquisar;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 144 * escala,
      padding: EdgeInsets.only(left: 19 * escala, right: 10 * escala),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(90 * escala),
        border: Border.all(color: Cores.azulEscuro, width: 20 * escala),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onSubmitted: onPesquisar,
              textInputAction: TextInputAction.search,
              style: _estiloTexto(escala, Cores.azulEscuro),
              decoration: InputDecoration.collapsed(
                hintText: 'Pesquise aqui',
                hintStyle: _estiloTexto(
                  escala,
                  Cores.azulEscuro.withValues(alpha: 0.5),
                ),
              ),
            ),
          ),
          Icon(Icons.search, color: Cores.azulEscuro, size: 80 * escala),
        ],
      ),
    );
  }
}

class _BotaoTutorialDoMaf extends StatelessWidget {
  const _BotaoTutorialDoMaf({required this.escala, this.onTap});

  final double escala;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final raio = BorderRadius.circular(35 * escala);

    return Material(
      color: Cores.azulEscuro,
      borderRadius: raio,
      child: InkWell(
        onTap: onTap,
        borderRadius: raio,
        child: SizedBox(
          width: double.infinity,
          height: 144 * escala,
          child: Center(
            child: Text(
              'TUTORIAL DO MAF',
              style: _estiloTexto(escala, Cores.fundo),
            ),
          ),
        ),
      ),
    );
  }
}

class _LinhaDeCards extends StatelessWidget {
  const _LinhaDeCards({
    required this.escala,
    required this.esquerda,
    required this.direita,
  });

  final double escala;
  final Widget esquerda;
  final Widget direita;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: esquerda),
        SizedBox(width: TelaInicial._espacoEntreCards * escala),
        Expanded(child: direita),
      ],
    );
  }
}

class _CardTema extends StatelessWidget {
  const _CardTema({
    required this.escala,
    required this.titulo,
    required this.icone,
    this.cor = Cores.verde,
    this.onTap,
  });

  final double escala;
  final String titulo;
  final Widget icone;
  final Color cor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final raio = BorderRadius.circular(35 * escala);

    return AspectRatio(
      aspectRatio: 1,
      child: Material(
        color: cor,
        borderRadius: raio,
        child: InkWell(
          onTap: onTap,
          borderRadius: raio,
          child: Padding(
            padding: EdgeInsets.only(top: 31 * escala),
            child: Column(
              children: [
                Text(titulo, style: _estiloTexto(escala, Cores.fundo)),
                Expanded(
                  child: Center(
                    child: IconTheme(
                      data: IconThemeData(
                        color: Cores.fundo,
                        size: 200 * escala,
                      ),
                      child: icone,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Ícone de app vindo de `lib/assets/icons/<nome>.svg`, pintado na cor de fundo.
class _IconeSvg extends StatelessWidget {
  const _IconeSvg(this.nome, {required this.escala});

  final String nome;
  final double escala;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'lib/assets/icons/$nome.svg',
      width: 200 * escala,
      height: 200 * escala,
      colorFilter: const ColorFilter.mode(Cores.fundo, BlendMode.srcIn),
    );
  }
}

class _TresEstrelas extends StatelessWidget {
  const _TresEstrelas({required this.escala});

  final double escala;

  @override
  Widget build(BuildContext context) {
    final pequena = 80 * escala;
    final grande = 110 * escala;

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Icon(Icons.star, size: pequena),
        Icon(Icons.star, size: grande),
        Icon(Icons.star, size: pequena),
      ],
    );
  }
}
