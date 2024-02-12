import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';

class QiblahPage extends StatefulWidget {
  const QiblahPage({Key? key}) : super(key: key);

  @override
  State<QiblahPage> createState() => _QiblahPageState();
}

class _QiblahPageState extends State<QiblahPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  double _begin = 0.0;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _animation = Tween(begin: 0.0, end: 0.0).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background 2.jpg'),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text('القبلة'),
        ),
        body: StreamBuilder<QiblahDirection>(
          stream: FlutterQiblah.qiblahStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator(
                  color: Color(0xff87854f),
                ),
              );
            }
            final qiblahDirection = snapshot.data;
            _animation = Tween(
              begin: _begin,
              end: (qiblahDirection!.qiblah * (pi / 180) * -1),
            ).animate(_animationController);
            _begin = (qiblahDirection.qiblah * (pi / 180) * -1);
            _animationController.forward(from: 0);
            return Center(
              child: SizedBox(
                child: AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _animation.value,
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Image.asset('assets/images/qublah.png'),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}