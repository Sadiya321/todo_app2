import 'package:flutter/material.dart';
import 'package:todo_app/widgets/app_textview.dart';

class AllCategories extends StatefulWidget {
  const AllCategories({super.key});

  @override
  _AllCategoriesState createState() => _AllCategoriesState();
}

class _AllCategoriesState extends State<AllCategories> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true); // Repeat animation in reverse

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // List of categories
    final List<String> categories = [
      'Personal',
      'Teams',
      'Work',
      'Shopping',
      'Health',
      'Travel',
      'Finance',
      'Education',
      'Fitness',
      'Other',
    ];

    return Scaffold(
      appBar: AppBar(
        title: AppTextView(
          text: "All Categories",
          textStyle: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color: Theme.of(context).colorScheme.surface,
                fontWeight: FontWeight.bold,
              ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Two items per row
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 3 / 2, // Adjust aspect ratio for better layout
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Card(
            elevation: 4,
            child: InkWell(
              onTap: () {
                // Handle category tap
                Navigator.of(context).pop(); // Example navigation
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedBuilder(
                    animation: _pulseAnimation,
                    child: Icon(
                      _getCategoryIcon(category),
                      size: 40,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _pulseAnimation.value, // Pulsate
                        child: child,
                      );
                    },
                  ),
                  SizedBox(height: 8),
                  AppTextView(
                    text: category,
                    textStyle: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Personal':
        return Icons.person;
      case 'Teams':
        return Icons.group;
      case 'Work':
        return Icons.work;
      case 'Shopping':
        return Icons.shopping_cart;
      case 'Health':
        return Icons.health_and_safety;
      case 'Travel':
        return Icons.travel_explore;
      case 'Finance':
        return Icons.monetization_on;
      case 'Education':
        return Icons.school;
      case 'Fitness':
        return Icons.fitness_center;
      default:
        return Icons.category;
    }
  }
}
