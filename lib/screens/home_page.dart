import 'package:flutter/material.dart';
import '1_discount_calculator_screen/discount_calculator_screen.dart';
import '2_sales_price_calculator_screen/sales_price_calculator_screen.dart';
import '3_product_inventory_screen/product_inventory_screen.dart';
import '4_sales_history_screen/sales_history_screen.dart';
import '../main.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Center(child: Text(widget.title)), // Centered title
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              MyApp.of(context)?.toggleTheme();
            },
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  _buildMenuButton(
                    context,
                    'Calculadora de Descuentos',
                    Icons.discount,
                    constraints,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ScreenOne()),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildMenuButton(
                    context,
                    'Calculadora Precios Venta',
                    Icons.price_change,
                    constraints,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ScreenTwo()),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildMenuButton(
                    context,
                    'Inventario de Productos',
                    Icons.inventory,
                    constraints,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ScreenThree()),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildMenuButton(
                    context,
                    'Historial de Ventas',
                    Icons.history,
                    constraints,
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ScreenFour()),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context, String title, IconData icon,
      BoxConstraints constraints, VoidCallback onPressed) {
    double buttonWidth = constraints.maxWidth > 600 
        ? constraints.maxWidth * 0.7 
        : constraints.maxWidth * 0.9;

    return MouseRegion(
      onEnter: (_) => _animationController.forward(),
      onExit: (_) => _animationController.reverse(),
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) => Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            width: buttonWidth,
            height: 80,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 4,
              ),
              onPressed: onPressed,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(icon, size: 30),
                  Expanded(
                    child: Center(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
