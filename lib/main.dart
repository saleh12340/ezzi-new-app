import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GroceryProvider(prefs)),
      ],
      child: const EzziGroceryApp(),
    ),
  );
}

class EzziGroceryApp extends StatelessWidget {
  const EzziGroceryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'بقالة العزي للمواد الغذائية',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Cairo',
        scaffoldBackgroundColor: const Color(0xFFF7F9F8),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1B5E20),
          primary: const Color(0xFF1B5E20),
          secondary: const Color(0xFFC67D0A),
        ),
      ),
      home: const MainNavigationScreen(),
    );
  }
}

class GroceryProvider extends ChangeNotifier {
  final SharedPreferences _prefs;
  GroceryProvider(this._prefs);
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const OrdersScreen(),
    const AccountScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: _screens,
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 10,
                offset: const Offset(0, -3),
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: const Color(0xFFC67D0A),
            unselectedItemColor: Colors.grey.shade600,
            selectedFontSize: 12,
            unselectedFontSize: 12,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: 'الرئيسية',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_outlined),
                activeIcon: Icon(Icons.shopping_cart),
                label: 'الطلبات',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                activeIcon: Icon(Icons.person),
                label: 'الحساب',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined),
                activeIcon: Icon(Icons.settings),
                label: 'الإعدادات',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFE2F0E5),
              Color(0xFFFCF7EC),
              Color(0xFFFFFFFF),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.45, 1.0],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 8),
                const Text(
                  'بقالة العزي للمواد الغذائية',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 16),
                _buildIllustrationBanner(),
                const SizedBox(height: 20),
                const Text(
                  'مرحباً بكم في بقالتكم المفضلة!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.extrabold,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'تطبيقكم الشامل للتسوق، التقارير، والخدمات البنكية.',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF64748B),
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: 1.35,
                  children: [
                    _buildFeatureCard(
                      context,
                      title: 'التسوق الفوري',
                      iconData: Icons.shopping_cart_checkout_rounded,
                      bgColor: const Color(0xFFD4A338),
                      textColor: Colors.white,
                      onTap: () {},
                    ),
                    _buildFeatureCard(
                      context,
                      title: 'تقارير المبيعات\nوالمخزون',
                      iconData: Icons.bar_chart_rounded,
                      bgColor: const Color(0xFFD4A338),
                      textColor: Colors.white,
                      onTap: () {},
                    ),
                    _buildFeatureCard(
                      context,
                      title: 'خدمات كاش ونقد',
                      iconData: Icons.handshake_rounded,
                      bgColor: const Color(0xFF2E7D32),
                      textColor: Colors.white,
                      onTap: () {},
                    ),
                    _buildFeatureCard(
                      context,
                      title: 'دفتر الحسابات',
                      iconData: Icons.menu_book_rounded,
                      bgColor: const Color(0xFF1B5E20),
                      textColor: Colors.white,
                      onTap: () {},
                    ),
                    _buildFeatureCard(
                      context,
                      title: 'طباعة الفواتير الحرارية',
                      iconData: Icons.receipt_long_rounded,
                      bgColor: Colors.white,
                      textColor: const Color(0xFF1E293B),
                      isLight: true,
                      onTap: () {},
                    ),
                    _buildFeatureCard(
                      context,
                      title: 'تقارير PDF الشهرية',
                      iconData: Icons.picture_as_pdf_rounded,
                      bgColor: Colors.white,
                      textColor: const Color(0xFF1E293B),
                      isLight: true,
                      onTap: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.settings, size: 14, color: Colors.grey),
                    SizedBox(width: 4),
                    Text(
                      'الإصدار 1.0 (تقنية فلاتر)',
                      style: TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIllustrationBanner() {
    return Container(
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.4),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFFFF3E0),
                ),
                child: const Icon(Icons.local_grocery_store, size: 32, color: Color(0xFFD4A338)),
              ),
              const SizedBox(width: 15),
              Container(
                width: 85,
                height: 85,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                  color: const Color(0xFFE8F5E9),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const CircleAvatar(
                  backgroundColor: Color(0xFFC8E6C9),
                  child: Icon(Icons.person_pin, size: 55, color: Color(0xFF1B5E20)),
                ),
              ),
              const SizedBox(width: 15),
              Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFE8F5E9),
                ),
                child: const Icon(Icons.nature, size: 32, color: Color(0xFF2E7D32)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context, {
    required String title,
    required IconData iconData,
    required Color bgColor,
    required Color textColor,
    required VoidCallback onTap,
    bool isLight = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        border: isLight ? Border.all(color: Colors.grey.shade200, width: 1.5) : null,
        boxShadow: [
          BoxShadow(
            color: isLight ? Colors.black.withOpacity(0.04) : bgColor.withOpacity(0.25),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  iconData,
                  size: 36,
                  color: isLight ? const Color(0xFF334155) : Colors.white,
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                    height: 1.2,
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

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الطلبات والمبيعات'), backgroundColor: const Color(0xFF1B5E20), foregroundColor: Colors.white),
      body: const Center(child: Text('شاشة إدارة الطلبات والمبيعات')),
    );
  }
}

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('حسابي'), backgroundColor: const Color(0xFF1B5E20), foregroundColor: Colors.white),
      body: const Center(child: Text('شاشة الحساب الشخصي والعملاء')),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الإعدادات'), backgroundColor: const Color(0xFF1B5E20), foregroundColor: Colors.white),
      body: const Center(child: Text('إعدادات تطبيق بقالة العزي')),
    );
  }
}
