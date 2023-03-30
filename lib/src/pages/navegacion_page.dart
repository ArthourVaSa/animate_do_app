// ignore_for_file: unnecessary_this

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class NavegacionPage extends StatelessWidget {
  const NavegacionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _NotificationModel(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,
          title: const Text('Navegacion'),
        ),
        floatingActionButton: const BotonFlotante(),
        bottomNavigationBar: const BottomNavigation(),
      ),
    );
  }
}

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final int notiNumero = Provider.of<_NotificationModel>(context).numero;

    return BottomNavigationBar(
      currentIndex: 0,
      selectedItemColor: Colors.pink,
      items: [
        const BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.bone),
          label: 'Bones',
        ),
        BottomNavigationBarItem(
          icon: Stack(
            children: [
              const FaIcon(FontAwesomeIcons.bell),
              Positioned(
                top: 0,
                right: 0,
                // child: const Icon(
                //   Icons.brightness_1,
                //   size: 8,
                //   color: Colors.redAccent,
                // ),
                child: BounceInDown(
                  from: 10,
                  animate: notiNumero > 0 ? true : false,
                  child: Bounce(
                    from: 10,
                    controller: (controller) => Provider.of<_NotificationModel>(context).bounceController = controller,
                    child: Container(
                      width: 12,
                      height: 12,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: Colors.redAccent,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        "$notiNumero",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 7,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          label: 'Notifications',
        ),
        const BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.dog),
          label: 'My Dog',
        ),
      ],
    );
  }
}

class BotonFlotante extends StatelessWidget {
  const BotonFlotante({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.pink,
      child: const FaIcon(FontAwesomeIcons.play),
      onPressed: () {
        final notiModel = Provider.of<_NotificationModel>(context, listen: false);

        int numero = notiModel.numero;
        numero++;
        notiModel.numero = numero;

        if(numero >= 2){
          final controller = notiModel.bounceController;
          print(controller);
          controller?.forward(from: 0.0);
        }

      },
    );
  }
}

class _NotificationModel extends ChangeNotifier {

  int _numero = 0;
  AnimationController? _bounceController;

  int get numero => this._numero;

  set numero(int valor) {
    this._numero = valor;
    notifyListeners();
  }

  AnimationController? get bounceController => this._bounceController;
  set bounceController(AnimationController? controller) {
    this._bounceController = controller;
  }

}
