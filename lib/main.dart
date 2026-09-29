import 'package:flutter/material.dart';

void main() => runApp(const GiuliettaApp());

class GiuliettaApp extends StatelessWidget {
  const GiuliettaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GiuliettaPage(),
    );
  }
}

class GiuliettaPage extends StatefulWidget {
  const GiuliettaPage({super.key});

  @override
  State<GiuliettaPage> createState() => _GiuliettaPageState();
}

class _GiuliettaPageState extends State<GiuliettaPage>
    with SingleTickerProviderStateMixin {
  int _counter = 0;

  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  );

  late final Animation<double> _scale = Tween<double>(begin: 0.4, end: 1.4)
      .animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

  late final Animation<double> _opacity = TweenSequence<double>([
    TweenSequenceItem(tween: ConstantTween(1.0), weight: 60),
    TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0), weight: 40),
  ]).animate(_controller);

  void _onPressed() {
    setState(() => _counter++);
    _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Giulietta counter: $_counter',
                  style: const TextStyle(
                    fontSize: 28,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _onPressed,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text('Giulietta', style: TextStyle(fontSize: 20)),
                  ),
                ),
              ],
            ),
          ),
          // Сердечко
          IgnorePointer(
            child: Align(
              alignment: const Alignment(0, -0.6),
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) => Opacity(
                  opacity: _controller.isDismissed ? 0 : _opacity.value,
                  child: Transform.scale(scale: _scale.value, child: child),
                ),
                child: const Icon(Icons.favorite, color: Colors.red, size: 120),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
