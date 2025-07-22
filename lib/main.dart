import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'dart:ui';
import 'package:image_picker/image_picker.dart';
import 'weather_service.dart';
import 'location_service.dart';
import 'all_features_screen.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(LumioApp());
}

class LumioApp extends StatelessWidget {
  const LumioApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lumio',
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFF1F2937, {
          50: Color(0xFFF9FAFB),
          100: Color(0xFFF3F4F6),
          200: Color(0xFFE5E7EB),
          300: Color(0xFFD1D5DB),
          400: Color(0xFF9CA3AF),
          500: Color(0xFF1F2937),
          600: Color(0xFF1F2937),
          700: Color(0xFF374151),
          800: Color(0xFF111827),
          900: Color(0xFF0F172A),
        }),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Inter',
        scaffoldBackgroundColor: Color(0xFFF9FAFB),
        cardTheme: CardThemeData(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: Colors.white,
          shadowColor: Colors.black.withOpacity(0.05),
        ),
        appBarTheme: AppBarTheme(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Color(0xFF1F2937),
          foregroundColor: Colors.white,
          titleTextStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            letterSpacing: -0.5,
          ),
          iconTheme: IconThemeData(color: Colors.white),
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          elevation: 8,
          selectedItemColor: Color(0xFF1F2937),
          unselectedItemColor: Color(0xFF6B7280),
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
          unselectedLabelStyle: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: Color(0xFF1F2937),
            foregroundColor: Colors.white,
            textStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Color(0xFFE5E7EB)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Color(0xFFE5E7EB)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Color(0xFF1F2937)),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
      home: MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();
  late AnimationController _animationController;

  final List<Widget> _screens = [
    HomeScreen(),
    WeatherWidget(),
    MovieManagerScreen(),
    MarketplaceScreen(),
    FoodDeliveryScreen(),
    BookingScreen(),
  ];

  final List<BottomNavigationBarItem> _bottomNavItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      activeIcon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.explore_outlined),
      activeIcon: Icon(Icons.explore),
      label: 'Explore',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.movie_outlined),
      activeIcon: Icon(Icons.movie),
      label: 'Movies',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.shopping_bag_outlined),
      activeIcon: Icon(Icons.shopping_bag),
      label: 'Shop',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.restaurant_outlined),
      activeIcon: Icon(Icons.restaurant),
      label: 'Food',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.event_outlined),
      activeIcon: Icon(Icons.event),
      label: 'Events',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: PageView(
        controller: _pageController,
        children: _screens,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
          HapticFeedback.lightImpact();
        },
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            items: _bottomNavItems,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
              _pageController.animateToPage(
                index,
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
              HapticFeedback.lightImpact();
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

// Enhanced Home Screen
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120,
            floating: true,
            pinned: true,
            backgroundColor: Color(0xFF2563EB),
            flexibleSpace: FlexibleSpaceBar(
              title: Row(
                children: [
                  Image.asset(
                    'assets/images/logobg.PNG',
                    height: 66,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Lumio',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              centerTitle: false,
              titlePadding: EdgeInsets.only(left: 20, bottom: 16),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF2563EB), Color(0xFF3B82F6)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
            actions: [
              Container(
                margin: EdgeInsets.only(right: 16),
                child: CircleAvatar(
                  backgroundColor: Colors.white.withOpacity(0.2),
                  child: Icon(
                    Icons.notifications_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hero Section
                  Container(
                    width: double.infinity,
                    height: 180,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF6366F1),
                          Color(0xFF8B5CF6),
                          Color(0xFFEC4899),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF6366F1).withOpacity(0.3),
                          blurRadius: 20,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        // Decorative elements
                        Positioned(
                          right: -20,
                          top: -20,
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        Positioned(
                          left: -30,
                          bottom: -30,
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/logobg.PNG',
                                height: 90,
                                fit: BoxFit.contain,
                              ),
                              SizedBox(height: 12),
                              Text(
                                'Welcome to Lumio',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Your all-in-one city companion',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 32),

                  // Quick Access Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Quick Access',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => AllFeaturesScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'View All',
                          style: TextStyle(
                            color: Color(0xFF6366F1),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 16),

                  // Enhanced Quick Access Grid
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.2,
                    children: [
                      _buildEnhancedQuickAccessCard(
                        icon: Icons.explore,
                        title: 'Events',
                        subtitle: 'Booking events',
                        colors: [Color(0xFF10B981), Color(0xFF059669)],
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => BookingScreen(),
                            ),
                          );
                        },
                      ),
                      _buildEnhancedQuickAccessCard(
                        icon: Icons.movie,
                        title: 'Movies',
                        subtitle: 'Watch & track',
                        colors: [Color(0xFFEF4444), Color(0xFFDC2626)],
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => MovieManagerScreen(),
                            ),
                          );
                        },
                      ),
                      _buildEnhancedQuickAccessCard(
                        icon: Icons.shopping_bag,
                        title: 'Marketplace',
                                                subtitle: 'Buy & sell',
                        colors: [Color.fromARGB(255, 54, 31, 168), Color.fromARGB(255, 21, 21, 221)],
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => MarketplaceScreen(),
                            ),
                          );
                        },
                      ),
                      _buildEnhancedQuickAccessCard(
                        icon: Icons.restaurant,
                        title: 'Food Delivery',
                        subtitle: 'Order now',
                        colors: [Color(0xFF8B5CF6), Color(0xFF7C3AED)],
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => FoodDeliveryScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),

                  SizedBox(height: 32),

                  // Recent Activity
                  Text(
                    'Recent Activity',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),

                  SizedBox(height: 16),
                  _buildEnhancedActivityCard(
                    icon: Icons.favorite,
                    title: 'Added movie to favorites',
                    subtitle: '5 hours ago',
                    color: Color(0xFFEF4444),
                  ),
                  _buildEnhancedActivityCard(
                    icon: Icons.shopping_cart,
                    title: 'Ordered from Pizza Palace',
                    subtitle: '1 day ago',
                    color: Color(0xFF10B981),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEnhancedQuickAccessCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required List<Color> colors,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: colors[0].withOpacity(0.3),
              blurRadius: 12,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: 32, color: Colors.white),
              SizedBox(height: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEnhancedActivityCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
        ],
      ),
    );
  }
}

class WeatherWidget extends StatefulWidget {
  const WeatherWidget({Key? key}) : super(key: key);

  @override
  State<WeatherWidget> createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  String? _city;
  String? _condition;
  double? _temp;
  bool _loading = false;
  final _controller = TextEditingController();
  String? _error;
  bool _isCelsius = true;

  IconData _getWeatherIcon(String? condition) {
    if (condition == null) return Icons.help_outline;
    final c = condition.toLowerCase();
    if (c.contains('sun') || c.contains('clear')) return Icons.wb_sunny;
    if (c.contains('cloud')) return Icons.cloud;
    if (c.contains('rain')) return Icons.umbrella;
    if (c.contains('storm') || c.contains('thunder')) return Icons.flash_on;
    if (c.contains('snow')) return Icons.ac_unit;
    if (c.contains('fog') || c.contains('mist')) return Icons.blur_on;
    return Icons.wb_cloudy;
  }

  double? get _displayTemp =>
      _temp == null ? null : (_isCelsius ? _temp : (_temp! * 9 / 5 + 32));
  String get _unit => _isCelsius ? '°C' : '°F';

  Future<void> _getWeatherByCity(String city) async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final weather = await WeatherService.fetchWeatherByCity(city: city);
      setState(() {
        _city = weather['city'];
        _condition = weather['condition'];
        _temp = weather['temp'];
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Unable to find weather for "$city".';
        _loading = false;
      });
    }
  }

  Future<void> _getWeatherByIpLocation() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final city = await IPLocationService.getCityByIP();
      if (city != null) {
        await _getWeatherByCity(city);
      } else {
        setState(() {
          _error = 'Could not detect city from IP.';
          _loading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Could not detect city from IP.';
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    return Center(
      child: Container(
        constraints: BoxConstraints(maxWidth: 500, minHeight: 480),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(36),
          gradient: LinearGradient(
            colors: [Color(0xFF4F8DFD).withOpacity(0.92), Color(0xFF1F2937).withOpacity(0.92)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.blueGrey.withOpacity(0.22),
              blurRadius: 48,
              offset: Offset(0, 24),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Decorative background circle
            Positioned(
              right: -60,
              top: -60,
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.07),
                ),
              ),
            ),
            Positioned(
              left: -40,
              bottom: -40,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.06),
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(36),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 48),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Weather',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                      ),
                      IconButton(
                        icon: Icon(_isCelsius ? Icons.thermostat : Icons.device_thermostat, color: Colors.white),
                        tooltip: 'Switch to \\${_isCelsius ? 'Fahrenheit' : 'Celsius'}',
                        onPressed: () => setState(() => _isCelsius = !_isCelsius),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${now.day.toString().padLeft(2, '0')}.${now.month.toString().padLeft(2, '0')}.${now.year}  |  ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}',
                    style: TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Enter city',
                            hintStyle: TextStyle(color: Colors.white54),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.08),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.search, color: Colors.white),
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                _getWeatherByCity(_controller.text);
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                          ),
                          onSubmitted: (val) {
                            _getWeatherByCity(val);
                          },
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.public, color: Colors.white),
                        tooltip: 'Detect my city (via IP)',
                        onPressed: _getWeatherByIpLocation,
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  AnimatedSwitcher(
                    duration: Duration(milliseconds: 400),
                    child: _loading
                        ? Column(
                            key: ValueKey('loading'),
                            children: [
                              SizedBox(height: 16),
                              CircularProgressIndicator(color: Colors.white),
                              SizedBox(height: 8),
                              Text('Fetching weather...', style: TextStyle(color: Colors.white70)),
                            ],
                          )
                        : _error != null
                            ? Container(
                                key: ValueKey('error'),
                                padding: EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: Colors.red.withOpacity(0.13),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.error_outline, color: Colors.redAccent),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Text(_error!, style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w500)),
                                    ),
                                  ],
                                ),
                              )
                            : _city != null
                                ? Column(
                                    key: ValueKey('weather'),
                                    children: [
                                      AnimatedSwitcher(
                                        duration: Duration(milliseconds: 500),
                                        child: Icon(
                                          _getWeatherIcon(_condition),
                                          key: ValueKey(_condition),
                                          size: 72,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 16),
                                      Text(
                                        _city!,
                                        style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
                                      ),
                                      Text(
                                        _condition ?? '',
                                        style: TextStyle(fontSize: 18, color: Colors.white70, fontWeight: FontWeight.w400),
                                      ),
                                      SizedBox(height: 14),
                                      AnimatedSwitcher(
                                        duration: Duration(milliseconds: 500),
                                        child: Text(
                                          _displayTemp != null ? '${_displayTemp!.toStringAsFixed(1)} $_unit' : '',
                                          key: ValueKey(_displayTemp.toString() + _unit),
                                          style: const TextStyle(fontSize: 48, fontWeight: FontWeight.w700, color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  )
                                : SizedBox.shrink(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// Movie Card Widget with Hero Animation and Tooltips
class _MovieCard extends StatelessWidget {
  final Map<String, dynamic> movie;
  final bool isFavorite;
  final bool isWatchLater;
  final VoidCallback onFavorite;
  final VoidCallback onWatchLater;
  final VoidCallback onDetails;
  final VoidCallback onWatch;

  const _MovieCard({
    required this.movie,
    required this.isFavorite,
    required this.isWatchLater,
    required this.onFavorite,
    required this.onWatchLater,
    required this.onDetails,
    required this.onWatch,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isFavorite
            ? BorderSide(color: Colors.red, width: 2)
            : isWatchLater
                ? BorderSide(color: Colors.blue, width: 2)
                : BorderSide.none,
      ),
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                gradient: LinearGradient(
                  colors: [
                    movie['color'],
                    movie['color'].withOpacity(0.7),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: movie['image'] != null
                  ? Hero(
                      tag: 'movieImage_${movie['title']}',
                      child: ClipRRect(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(12),
                        ),
                        child: Image.asset(
                          movie['image'],
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Center(
                              child: Icon(
                                Icons.movie,
                                size: 40,
                                color: Colors.white,
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  : Center(
                      child: Icon(
                        Icons.movie,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie['title'],
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text(
                  '${movie['year']} • ${movie['genre']}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 14,
                        ),
                        SizedBox(width: 2),
                        Text(
                          movie['rating'].toString(),
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Tooltip(
                          message: isFavorite ? 'Remove from favorites' : 'Add to favorites',
                          child: GestureDetector(
                            onTap: onFavorite,
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 200),
                              decoration: BoxDecoration(
                                color: isFavorite ? Colors.red : Colors.grey[200],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: EdgeInsets.all(4),
                              child: Icon(
                                isFavorite ? Icons.favorite : Icons.favorite_border,
                                size: 16,
                                color: isFavorite ? Colors.white : Colors.red,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Tooltip(
                          message: isWatchLater ? 'Remove from watch later' : 'Add to watch later',
                          child: GestureDetector(
                            onTap: onWatchLater,
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 200),
                              decoration: BoxDecoration(
                                color: isWatchLater ? Colors.blue : Colors.grey[200],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: EdgeInsets.all(4),
                              child: Icon(
                                isWatchLater ? Icons.watch_later : Icons.watch_later_outlined,
                                size: 16,
                                color: isWatchLater ? Colors.white : Colors.blue,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: onDetails,
                        icon: Icon(Icons.info_outline),
                        label: Text('Details'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[200],
                          foregroundColor: Colors.black87,
                          elevation: 0,
                          minimumSize: Size(double.infinity, 32),
                          padding: EdgeInsets.symmetric(vertical: 4),
                          textStyle: TextStyle(fontSize: 13),
                        ),
                      ),
                    ),
                    SizedBox(width: 6),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: onWatch,
                        icon: Icon(Icons.play_arrow),
                        label: Text('Watch'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[400],
                          foregroundColor: Colors.white,
                          elevation: 0,
                          minimumSize: Size(double.infinity, 32),
                          padding: EdgeInsets.symmetric(vertical: 4),
                          textStyle: TextStyle(fontSize: 13),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Enhanced Movie Manager Screen
class MovieManagerScreen extends StatefulWidget {
  const MovieManagerScreen({Key? key}) : super(key: key);

  @override
  MovieManagerScreenState createState() => MovieManagerScreenState();
}

class MovieManagerScreenState extends State<MovieManagerScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Map<String, dynamic>> favorites = [];
  List<Map<String, dynamic>> watchLater = [];

  final List<Map<String, dynamic>> movies = [
    {
      'title': 'The Prestige',
      'year': 2006,
      'rating': 8.5,
      'genre': 'Sci-fi',
      'director': 'Christopher Nolan',
      'cast': ['Christian Bale', 'Hugh Jackman', 'Michael Caine'],
      'duration': '130 min',
      'language': 'English',
      'color': Color(0xFFEF4444),
      'image': 'assets/images/prestige.jpg',
      'description':
          'Two friends and fellow magicians become bitter enemies after a sudden tragedy. As they devote themselves to this rivalry, they make sacrifices that bring them fame but, with terrible consequences.',
      'url': 'https://rezka-ua.tv/films/drama/795-prestizh-2006.html',
    },
    {
      'title': 'Forrest Gump',
      'year': 1994,
      'rating': 8.8,
      'genre': 'Comedy',
      'director': 'Robert Zemeckis',
      'cast': ['Tom Hanks', 'Robin Wright', 'Gary Sinise'],
      'duration': '142 min',
      'language': 'English',
      'color': Color(0xFFEF4444),
      'image': 'assets/images/forrest_gump.jfif',
      'description':
          'Forrest, a man with low IQ , recounts the early years of his life when he found himself in the middle of key historical events.',
      'url': 'https://rezka-ua.tv/films/drama/763-forrest-gamp-1994.html',
    },
     {
      'title': 'The Matrix',
      'year': 1999,
      'rating': 8.7,
      'genre': 'Sci-Fi',
      'director': 'Lana Wachowski, Lilly Wachowski',
      'cast': ['Keanu Reeves', 'Laurence Fishburne', 'Carrie-Anne Moss'],
      'duration': '136 min',
      'language': 'English',
      'color': Color(0xFFEF4444),
      'image': 'assets/images/matrix.jpg',
      'description':
          'A computer hacker learns about the true nature of his reality and his role in the war against its controllers.',
      'url': 'https://rezka-ua.tv/films/fiction/981-matrica-1999.html',
    },
    {
      'title': 'Inception',
      'year': 2010,
      'rating': 8.8,
      'genre': 'Thriller',
      'director': 'Christopher Nolan',
      'cast': ['Leonardo DiCaprio', 'Joseph Gordon-Levitt', 'Elliot Page'],
      'duration': '148 min',
      'language': 'English',
      'color': Color(0xFF10B981),
      'image': 'assets/images/inception.jpg',
      'description': 'A thief who steals corporate secrets through dream-sharing technology is given the inverse task of planting an idea.',
      'url': 'https://rezka-ua.tv/films/action/770-nachalo-2010.html',
    },
    {
      'title': 'Interstellar',
      'year': 2014,
      'rating': 8.6,
      'genre': 'Sci-Fi',
      'director': 'Christopher Nolan',
      'cast': ['Matthew McConaughey', 'Anne Hathaway', 'Jessica Chastain'],
      'duration': '169 min',
      'language': 'English',
      'color': Color(0xFF6366F1),
      'image': 'assets/images/interstaller.jfif',
      'description': 'A team of explorers travel through a wormhole in space in an attempt to ensure humanity\'s survival.',
      'url': 'https://rezka-ua.tv/films/fiction/2259-interstellar-2014.html',
    },
    {
      'title': 'The Dark Knight',
      'year': 2008,
      'rating': 9.0,
      'genre': 'Action',
      'director': 'Christopher Nolan',
      'cast': ['Christian Bale', 'Heath Ledger', 'Aaron Eckhart'],
      'duration': '152 min',
      'language': 'English',
      'color': Color(0xFF8B5CF6),
      'image': 'assets/images/dark_knight.jfif',
      'description': 'Batman faces the Joker, a criminal mastermind who plunges Gotham City into chaos.',
      'url': 'https://rezka-ua.tv/films/action/703-temnyy-rycar-2008-latest.html',
    },
    {
      'title': 'Pulp Fiction',
      'year': 1994,
      'rating': 8.9,
      'genre': 'Crime',
      'director': 'Quentin Tarantino',
      'cast': ['John Travolta', 'Uma Thurman', 'Samuel L. Jackson'],
      'duration': '154 min',
      'language': 'English',
      'color': Color(0xFFDC2626),
      'image': 'assets/images/pulp_fiction.jfif',
      'description': 'The lives of two mob hitmen, a boxer, and others intertwine in four tales of violence and redemption.',
      'url': 'https://rezka-ua.tv/films/drama/822-kriminalnoe-chtivo-1994-latest.html',
    },
    {
      'title': 'The Shawshank Redemption',
      'year': 1994,
      'rating': 9.3,
      'genre': 'Drama',
      'director': 'Frank Darabont',
      'cast': ['Tim Robbins', 'Morgan Freeman', 'Bob Gunton'],
      'duration': '142 min',
      'language': 'English',
      'color': Color(0xFF2563EB),
      'image': 'assets/images/shawshank.jfif',
      'description': 'Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency.',
      'url': 'https://rezka-ua.tv/films/drama/806-pobeg-iz-shoushenka-1994-latest.html',
    },
    {
      'title': 'Parasite',
      'year': 2019,
      'rating': 8.6,
      'genre': 'Thriller',
      'director': 'Bong Joon-ho',
      'cast': ['Kang-ho Song', 'Sun-kyun Lee', 'Yeo-jeong Jo'],
      'duration': '132 min',
      'language': 'Korean',
      'color': Color(0xFF059669),
      'image': 'assets/images/parasite.jfif',
      'description': 'Greed and class discrimination threaten the newly formed symbiotic relationship between the wealthy Park family and the destitute Kim clan.',
      'url': 'https://rezka-ua.tv/films/drama/31349-parazity-2019.html',
    },
    {
      'title': 'Spirited Away',
      'year': 2001,
      'rating': 8.6,
      'genre': 'Animation',
      'director': 'Hayao Miyazaki',
      'cast': ['Rumi Hiiragi', 'Miyu Irino', 'Mari Natsuki'],
      'duration': '125 min',
      'language': 'Japanese',
      'color': Color(0xFF8B5CF6),
      'image': 'assets/images/spirited_away.jfif',
      'description': 'During her family\'s move to the suburbs, a sullen 10-year-old girl wanders into a world ruled by gods, witches, and spirits.',
      'url': 'https://rezka-ua.tv/animation/adventures/829-unesennye-prizrakami-2001.html',
    },
  ];

  String _searchQuery = '';
  String _selectedGenre = 'All';

  List<String> get genres {
    final gs = movies.map((e) => e['genre'] as String).toSet().toList();
    gs.sort();
    return ['All', ...gs];
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies & TV'),
        backgroundColor: Colors.red,
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Search'),
            Tab(text: 'Favorites'),
            Tab(text: 'Watch Later'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildSearchTab(),
          _buildFavoritesTab(),
          _buildWatchLaterTab(),
        ],
      ),
    );
  }

  Widget _buildSearchTab() {
    final filteredMovies = movies.where((m) {
      final matchesSearch =
          _searchQuery.isEmpty ||
          m['title'].toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesGenre =
          _selectedGenre == 'All' || m['genre'] == _selectedGenre;
      return matchesSearch && matchesGenre;
    }).toList();
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search movies and TV shows...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: (v) {
                  setState(() => _searchQuery = v);
                },
              ),
              SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: genres.map((g) {
                    final selected = _selectedGenre == g;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ChoiceChip(
                        label: Text(g),
                        selected: selected,
                        onSelected: (_) {
                          setState(() => _selectedGenre = g);
                        },
                        selectedColor: Colors.red,
                        labelStyle: TextStyle(
                          color: selected ? Colors.white : Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                        backgroundColor: Colors.grey[100],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: filteredMovies.isEmpty
              ? Center(
                  child: Text(
                    'No movies found.',
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                )
              : GridView.builder(
                  padding: EdgeInsets.all(16),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: filteredMovies.length,
                  itemBuilder: (context, index) {
                    final movie = filteredMovies[index];
                    final isFavorite = favorites.contains(movie);
                    final isWatchLater = watchLater.contains(movie);
                    return _MovieCard(
                      movie: movie,
                      isFavorite: isFavorite,
                      isWatchLater: isWatchLater,
                      onFavorite: () => _toggleFavorite(movie),
                      onWatchLater: () => _toggleWatchLater(movie),
                      onDetails: () => _showMovieDetails(context, movie),
                      onWatch: () => _watchMovie(movie),
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildFavoritesTab() {
    return favorites.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/empty_favorites.png',
                  width: 120,
                  height: 120,
                  errorBuilder: (context, error, stackTrace) => Icon(Icons.favorite_border, size: 64, color: Colors.grey),
                ),
                SizedBox(height: 16),
                Text(
                  'No favorites yet',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
                SizedBox(height: 8),
                Text(
                  'Add movies to your favorites to see them here',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          )
        : ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final movie = favorites[index];
              return ListTile(
                leading: Container(
                  width: 50,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.red.shade300,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: movie['image'] != null
                        ? Image.asset(
                            movie['image'],
                            width: 50,
                            height: 70,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Icon(Icons.movie, color: Colors.white),
                          )
                        : Icon(Icons.movie, color: Colors.white),
                  ),
                ),
                title: Text(movie['title']),
                subtitle: Text('${movie['year']} • ${movie['genre']}'),
                trailing: IconButton(
                  icon: Icon(Icons.favorite, color: Colors.red),
                  onPressed: () => _toggleFavorite(movie),
                ),
                onTap: () => _showMovieDetails(context, movie),
              );
            },
          );
  }

  Widget _buildWatchLaterTab() {
    return watchLater.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/empty_watchlater.png',
                  width: 120,
                  height: 120,
                  errorBuilder: (context, error, stackTrace) => Icon(Icons.watch_later_outlined, size: 64, color: Colors.grey),
                ),
                SizedBox(height: 16),
                Text(
                  'Watch later list is empty',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
                SizedBox(height: 8),
                Text(
                  'Add movies to watch later to see them here',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          )
        : ListView.builder(
            itemCount: watchLater.length,
            itemBuilder: (context, index) {
              final movie = watchLater[index];
              return ListTile(
                leading: Container(
                  width: 50,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade300,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: movie['image'] != null
                        ? Image.asset(
                            movie['image'],
                            width: 50,
                            height: 70,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Icon(Icons.movie, color: Colors.white),
                          )
                        : Icon(Icons.movie, color: Colors.white),
                  ),
                ),
                title: Text(movie['title']),
                subtitle: Text('${movie['year']} • ${movie['genre']}'),
                trailing: IconButton(
                  icon: Icon(Icons.watch_later, color: Colors.blue),
                  onPressed: () => _toggleWatchLater(movie),
                ),
                onTap: () => _showMovieDetails(context, movie),
              );
            },
          );
  }

  void _toggleFavorite(Map<String, dynamic> movie) {
    setState(() {
      if (favorites.contains(movie)) {
        favorites.remove(movie);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Removed from favorites')),
        );
      } else {
        favorites.add(movie);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Added to favorites')),
        );
      }
    });
  }

  void _toggleWatchLater(Map<String, dynamic> movie) {
    setState(() {
      if (watchLater.contains(movie)) {
        watchLater.remove(movie);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Removed from watch later')),
        );
      } else {
        watchLater.add(movie);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Added to watch later')),
        );
      }
    });
  }

  void _watchMovie(Map<String, dynamic> movie) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Watch Movie'),
        content: Text('Do you want to watch "${movie['title']}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pop();
              final url = movie['url'] as String?;
              if (url != null) {
                try {
                  await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Could not launch movie URL.')),
                  );
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('No URL available for this movie.')),
                );
              }
            },
            child: Text('Watch Now'),
          ),
        ],
      ),
    );
  }

  void _showMovieDetails(BuildContext context, Map<String, dynamic> movie) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      isScrollControlled: true,
      builder: (context) {
        final isFavorite = favorites.contains(movie);
        final isWatchLater = watchLater.contains(movie);
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.7,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          builder: (context, scrollController) => Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Center(
                  child: Hero(
                    tag: 'movieImage_${movie['title']}',
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: movie['image'] != null
                          ? Image.asset(
                              movie['image'],
                              width: 180,
                              height: 240,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                width: 180,
                                height: 240,
                                color: Colors.grey[200],
                                child: Icon(Icons.movie, size: 60, color: Colors.grey),
                              ),
                            )
                          : Container(
                              width: 180,
                              height: 240,
                              color: Colors.grey[200],
                              child: Icon(Icons.movie, size: 60, color: Colors.grey),
                            ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8),
                      Text(
                        movie['title'],
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text('${movie['year']} • ${movie['genre']} • ${movie['duration']}'),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 18),
                          SizedBox(width: 4),
                          Text('${movie['rating']}', style: TextStyle(fontSize: 16)),
                        ],
                      ),
                      SizedBox(height: 12),
                      Text(
                        movie['description'],
                        style: TextStyle(fontSize: 15, color: Colors.grey[800]),
                      ),
                      SizedBox(height: 16),
                      Text('Director: ${movie['director']}', style: TextStyle(fontWeight: FontWeight.w500)),
                      SizedBox(height: 4),
                      Text('Cast: ${movie['cast'].join(", ")}', style: TextStyle(color: Colors.grey[700])),
                      SizedBox(height: 80), // Space for sticky bar
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          _toggleFavorite(movie);
                        },
                        icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
                        label: Text(isFavorite ? 'Unfavorite' : 'Favorite'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          _toggleWatchLater(movie);
                        },
                        icon: Icon(isWatchLater ? Icons.watch_later : Icons.watch_later_outlined),
                        label: Text(isWatchLater ? 'Remove' : 'Watch Later'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// Marketplace Screen
class MarketplaceScreen extends StatefulWidget {
  const MarketplaceScreen({Key? key}) : super(key: key);

  @override
  MarketplaceScreenState createState() => MarketplaceScreenState();
}

class MarketplaceScreenState extends State<MarketplaceScreen> {
  final List<Map<String, dynamic>> items = [
    {
      'title': 'iPhone 13 Pro',
      'price': '12,000 TMT',
      'category': 'Electronics',
      'seller': 'Nury K.',
      'location': 'Ashgabat',
      'image': 'assets/images/iphone.jpg',
    },
    {
      'title': 'Leather Jacket',
      'price': '4,000 TMT',
      'category': 'Fashion',
      'seller': 'Leyli A.',
      'location': 'Balkan',
      'image': 'assets/images/jacket.jpg',
    },
    {
      'title': 'MacBook Air M2',
      'price': '16,000 TMT',
      'category': 'Electronics',
      'seller': 'Suleyman B.',
      'location': 'Dashoguz',
      'image': 'assets/images/macbook.jpg',
    },
    {
      'title': 'Bicycle Trek',
      'price': '3,000 TMT',
      'category': 'Sports',
      'seller': 'Rowshen P.',
      'location': 'Lebap',
      'image': 'assets/images/bike.jpg',
    },
    {
      'title': 'Samsung Galaxy S22',
      'price': '10,500 TMT',
      'category': 'Electronics',
      'seller': 'Ali G.',
      'location': 'Ashgabat',
      'image': 'assets/images/galaxy.jpg',
    },
    {
      'title': 'Mountain Bike',
      'price': '5,200 TMT',
      'category': 'Sports',
      'seller': 'Bekmyrat T.',
      'location': 'Mary',
      'image': 'assets/images/mountain_bike.jpg',
    },
    {
      'title': 'Designer Handbag',
      'price': '7,800 TMT',
      'category': 'Fashion',
      'seller': 'Leyla S.',
      'location': 'Ahal',
      'image': 'assets/images/handbag.jpg',
    },
    {
      'title': 'Gaming Laptop',
      'price': '18,000 TMT',
      'category': 'Electronics',
      'seller': 'Serdar N.',
      'location': 'Balkan',
      'image': 'assets/images/gaming_laptop.jpg',
    },
    {
      'title': 'Coffee Maker',
      'price': '1,200 TMT',
      'category': 'Home',
      'seller': 'Ayna R.',
      'location': 'Dashoguz',
      'image': 'assets/images/coffee_maker.jpg',
    },
    {
      'title': 'Children’s Toy Set',
      'price': '600 TMT',
      'category': 'Toys',
      'seller': 'Merdan J.',
      'location': 'Lebap',
      'image': 'assets/images/toy_set.jpg',
    },
    {
      'title': 'Cookbook Collection',
      'price': '350 TMT',
      'category': 'Books',
      'seller': 'Gulnar E.',
      'location': 'Ashgabat',
      'image': 'assets/images/cookbook.jpg',
    },
    {
      'title': 'Smart TV 55"',
      'price': '9,900 TMT',
      'category': 'Electronics',
      'seller': 'Rejep B.',
      'location': 'Mary',
      'image': 'assets/images/smart_tv.jpg',
    },
    {
      'title': 'Sofa Set',
      'price': '14,000 TMT',
      'category': 'Home',
      'seller': 'Aman K.',
      'location': 'Ahal',
      'image': 'assets/images/sofa.jpg',
    },
    {
      'title': 'Wrist Watch',
      'price': '2,500 TMT',
      'category': 'Fashion',
      'seller': 'Jahan S.',
      'location': 'Balkan',
      'image': 'assets/images/watch.jpg',
    },
    {
      'title': 'Electric Kettle',
      'price': '800 TMT',
      'category': 'Home',
      'seller': 'Batyr M.',
      'location': 'Dashoguz',
      'image': 'assets/images/kettle.jpg',
    },
    {
      'title': 'Soccer Ball',
      'price': '200 TMT',
      'category': 'Sports',
      'seller': 'Kerim A.',
      'location': 'Lebap',
      'image': 'assets/images/soccer_ball.jfif',
    },
  ];

  String _searchQuery = '';
  String _selectedCategory = 'All';
  String? _selectedCity;
  String? _minPrice;
  String? _maxPrice;
  final Set<Map<String, dynamic>> _wishlist = {};

  List<String> get categories {
    final cats = items.map((e) => e['category'] as String).toSet().toList();
    cats.sort();
    return ['All', ...cats];
  }

  @override
  Widget build(BuildContext context) {
    final filteredItems = items.where((item) {
      final matchesSearch =
          _searchQuery.isEmpty ||
          item['title'].toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesCategory =
          _selectedCategory == 'All' || item['category'] == _selectedCategory;
      final matchesCity = _selectedCity == null || item['location'] == _selectedCity;
      final matchesMinPrice = _minPrice == null ||
        (double.tryParse(item['price'].toString().replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0) >= (double.tryParse(_minPrice!) ?? 0);
      final matchesMaxPrice = _maxPrice == null ||
        (double.tryParse(item['price'].toString().replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0) <= (double.tryParse(_maxPrice!) ?? double.infinity);
      return matchesSearch && matchesCategory && matchesCity && matchesMinPrice && matchesMaxPrice;
    }).toList();
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120,
            floating: true,
            pinned: true,
            backgroundColor: Color(0xFF1F2937),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Marketplace',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              centerTitle: false,
              titlePadding: EdgeInsets.only(left: 20, bottom: 16),
            ),
            actions: [
              Container(
                margin: EdgeInsets.only(right: 16),
                child: CircleAvatar(
                  backgroundColor: Colors.grey[100],
                  child: IconButton(
                    icon: Icon(Icons.filter_list, color: Colors.black87),
                    onPressed: () async {
                      final result = await showDialog<Map<String, dynamic>>(
                        context: context,
                        builder: (context) {
                          String? selectedCategory = _selectedCategory == 'All' ? null : _selectedCategory;
                          String? selectedCity;
                          String? minPrice;
                          String? maxPrice;
                          return AlertDialog(
                            title: Text('Filters'),
                            content: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  DropdownButtonFormField<String>(
                                    value: selectedCategory,
                                    hint: Text('Category'),
                                    items: categories.where((c) => c != 'All').map((cat) => DropdownMenuItem(
                                      value: cat,
                                      child: Text(cat),
                                    )).toList(),
                                    onChanged: (v) => selectedCategory = v,
                                    decoration: InputDecoration(labelText: 'Category'),
                                  ),
                                  SizedBox(height: 12),
                                  DropdownButtonFormField<String>(
                                    value: selectedCity,
                                    hint: Text('City'),
                                    items: [
                                      'Ashgabat', 'Ahal', 'Balkan', 'Dashoguz', 'Lebap', 'Mary'
                                    ].map((city) => DropdownMenuItem(
                                      value: city,
                                      child: Text(city),
                                    )).toList(),
                                    onChanged: (v) => selectedCity = v,
                                    decoration: InputDecoration(labelText: 'City'),
                                  ),
                                  SizedBox(height: 12),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          decoration: InputDecoration(labelText: 'Min Price'),
                                          keyboardType: TextInputType.number,
                                          onChanged: (v) => minPrice = v,
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Expanded(
                                        child: TextFormField(
                                          decoration: InputDecoration(labelText: 'Max Price'),
                                          keyboardType: TextInputType.number,
                                          onChanged: (v) => maxPrice = v,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('Cancel'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context, {
                                    'category': selectedCategory,
                                    'city': selectedCity,
                                    'minPrice': minPrice,
                                    'maxPrice': maxPrice,
                                  });
                                },
                                child: Text('Apply'),
                              ),
                            ],
                          );
                        },
                      );
                      if (result != null) {
                        setState(() {
                          _selectedCategory = result['category'] ?? 'All';
                          _selectedCity = result['city'];
                          _minPrice = result['minPrice'];
                          _maxPrice = result['maxPrice'];
                        });
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search items...',
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 16,
                        ),
                      ),
                      onChanged: (v) => setState(() => _searchQuery = v),
                    ),
                  ),
                  SizedBox(height: 16),
                  // Category filter chips
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: categories.map((cat) {
                        final selected = _selectedCategory == cat;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: ChoiceChip(
                            label: Text(cat),
                            selected: selected,
                            onSelected: (_) {
                              setState(() => _selectedCategory = cat);
                            },
                            selectedColor: Color(0xFF2563EB),
                            labelStyle: TextStyle(
                              color: selected ? Colors.white : Colors.black87,
                              fontWeight: FontWeight.w500,
                            ),
                            backgroundColor: Colors.grey[100],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
          filteredItems.isEmpty
              ? SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Text(
                      'No items found.',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ),
                )
              : SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.75,
                  ),
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final item = filteredItems[index];
                    final isWishlisted = _wishlist.contains(item);
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ItemDetailsScreen(item: item),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(16),
                                    ),
                                    child: item['imageBytes'] != null
                                        ? Image.memory(
                                            item['imageBytes'],
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                          )
                                        : item['image'] != null
                                        ? (item['image'].toString().startsWith(
                                                '/',
                                              )
                                              ? Image.file(
                                                  File(item['image']),
                                                  width: double.infinity,
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.asset(
                                                  item['image'],
                                                  width: double.infinity,
                                                  fit: BoxFit.cover,
                                                ))
                                        : Container(
                                            color: Colors.grey[200],
                                            child: Center(
                                              child: Icon(
                                                Icons.image,
                                                size: 48,
                                                color: Colors.grey[400],
                                              ),
                                            ),
                                          ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item['title'],
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        item['price'],
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF2563EB),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.location_on,
                                            size: 14,
                                            color: Colors.grey[600],
                                          ),
                                          SizedBox(width: 4),
                                          Expanded(
                                            child: Text(
                                              item['location'],
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey[600],
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: GestureDetector(
                                onTap: () {
                                  // setState removed: wishlist logic is obsolete in placeholder
                                },
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 16,
                                  child: Icon(
                                    isWishlisted
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: isWishlisted
                                        ? Colors.red
                                        : Colors.grey,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }, childCount: filteredItems.length),
                ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 64.0, right: 16.0),
        child: FloatingActionButton.extended(
          onPressed: () async {
            final newItem = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PostItemScreen()),
            );
            if (newItem != null && newItem is Map<String, dynamic>) {
              setState(() {
                items.insert(0, newItem);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Item added to marketplace!')),
              );
            }
          },
          backgroundColor: Color(0xFF2563EB),
          icon: Icon(Icons.add),
          label: Text('Add Item'),
        ),
      ),
    );
  }
}

// Item Details Screen
class ItemDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> item;

  const ItemDetailsScreen({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item['title']),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            item['imageBytes'] != null
                ? Image.memory(
                    item['imageBytes'],
                    height: 300,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                : item['image'] != null
                ? (item['image'].toString().startsWith('/')
                      ? Image.file(
                          File(item['image']),
                          height: 300,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          item['image'],
                          height: 300,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ))
                : Container(
                    height: 300,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.orange.shade300,
                          Colors.orange.shade600,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.shopping_bag,
                        size: 80,
                        color: Colors.white,
                      ),
                    ),
                  ),
            Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['title'],
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    item['price'],
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.green,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(Icons.category, size: 18, color: Colors.grey),
                      SizedBox(width: 6),
                      Text(item['category']),
                      SizedBox(width: 20),
                      Icon(Icons.location_on, size: 18, color: Colors.grey),
                      SizedBox(width: 6),
                      Text(item['location']),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(Icons.person, size: 18, color: Colors.grey),
                      SizedBox(width: 6),
                      Text('Seller: ${item['seller']}'),
                    ],
                  ),
                  SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.call),
                    label: Text('Call Seller'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      minimumSize: Size(double.infinity, 48),
                    ),
                  ),
                  SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.message),
                    label: Text('Message Seller'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      minimumSize: Size(double.infinity, 48),
                    ),
                  ),
                  
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Food Delivery Screen
class FoodDeliveryScreen extends StatelessWidget {
  FoodDeliveryScreen({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> restaurants = [
  {
  'name': 'Pizza Palace',
  'cuisine': 'Italian',
  'rating': 4.7,
  'image': 'assets/images/pizza.jpg',
  },
  {
  'name': 'Sushi Express',
  'cuisine': 'Japanese',
  'rating': 4.6,
  'image': 'assets/images/sushi.jpg',
  },
  {
  'name': 'Burger Town',
  'cuisine': 'American',
  'rating': 4.5,
  'image': 'assets/images/burger.jpg',
  },
  {
  'name': 'Veggie Delight',
  'cuisine': 'Vegetarian',
  'rating': 4.8,
  'image': 'assets/images/veggie.jpg',
  },
  {
  'name': 'Kebab House',
  'cuisine': 'Turkmen',
  'rating': 4.4,
  'image': 'assets/images/kebap.jpg',
  },
  {
  'name': 'Cafe Paris',
  'cuisine': 'French',
  'rating': 4.3,
  'image': 'assets/images/paris.jfif',
  },
  {
  'name': 'Dragon Wok',
  'cuisine': 'Chinese',
  'rating': 4.5,
  'image': 'assets/images/chinese.jfif',
  },
  {
  'name': 'Tandoori Flame',
  'cuisine': 'Indian',
  'rating': 4.6,
  'image': 'assets/images/indian.jfif',
  },
  {
  'name': 'El Mexicano',
  'cuisine': 'Mexican',
  'rating': 4.2,
  'image': 'assets/images/mexican.jfif',
  },
  {
  'name': 'Bakery Bliss',
  'cuisine': 'Bakery',
  'rating': 4.9,
  'image': 'assets/images/bakery.jfif',
  },
  {
  'name': 'Seafood Harbor',
  'cuisine': 'Seafood',
  'rating': 4.7,
  'image': 'assets/images/seafood.jfif',
  },
  {
  'name': 'Shashlik Grill',
  'cuisine': 'Grill',
  'rating': 4.5,
  'image': 'assets/images/shashlik.jfif',
  },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Delivery'),
                actions: [
          IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {}),
        ],
      ),
      body: ListView.builder(
        itemCount: restaurants.length,
        itemBuilder: (context, index) {
          final restaurant = restaurants[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: restaurant['image'] != null
                  ? ClipOval(
                      child: Image.asset(
                        restaurant['image'],
                        width: 48,
                        height: 48,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return CircleAvatar(
                            backgroundColor: Colors.purple.shade100,
                            child: Center(
                           child: Icon(Icons.restaurant_menu, size: 60, color: Colors.white),
                           ),
                          );
                        },
                      ),
                    )
                  : CircleAvatar(
                      backgroundColor: Colors.purple.shade100,
                      child: Icon(Icons.restaurant_menu, color: Colors.purple),
                    ),
              title: Text(restaurant['name']),
              subtitle: Text(
                '${restaurant['cuisine']} • ${restaurant['rating']} ★',
              ),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        RestaurantDetailsScreen(restaurant: restaurant),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// Restaurant Details Screen
class RestaurantDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> restaurant;

  const RestaurantDetailsScreen({Key? key, required this.restaurant})
    : super(key: key);

  static final List<Map<String, dynamic>> defaultMenu = [
    {'name': 'Pizza Margherita', 'price': 30},
    {'name': 'Cheeseburger', 'price': 25},
    {'name': 'Sushi Roll', 'price': 40},
    {'name': 'Veggie Salad', 'price': 18},
    {'name': 'Chicken Kebab', 'price': 22},
    {'name': 'French Fries', 'price': 10},
    {'name': 'Baklava', 'price': 12},
    {'name': 'Coffee', 'price': 8},
    {'name': 'Juice', 'price': 7},
  ];

  void _showOrderDialog(BuildContext context) {
    final menu = defaultMenu;
    final quantities = List<int>.filled(menu.length, 0);
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            num total = 0;
            for (int i = 0; i < menu.length; i++) {
              total += menu[i]['price'] * quantities[i];
            }
            return AlertDialog(
              title: Text('Order from ${restaurant['name']}'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ...List.generate(menu.length, (i) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text('${menu[i]['name']}')), 
                        Text('${menu[i]['price']} TMT'),
                        IconButton(
                          icon: Icon(Icons.remove_circle_outline),
                          onPressed: quantities[i] > 0 ? () => setState(() => quantities[i]--) : null,
                        ),
                        Text('${quantities[i]}'),
                        IconButton(
                          icon: Icon(Icons.add_circle_outline),
                          onPressed: () => setState(() => quantities[i]++),
                        ),
                      ],
                    )),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total:', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('$total TMT', style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: total > 0
                      ? () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Your order was successfully completed')),
                          );
                        }
                      : null,
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant['name']),
              ),
      body: Column(
        children: [
          Container(
  height: 200,
  width: double.infinity,
  child: restaurant['image'] != null
      ? Image.asset(
          restaurant['image'],
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.purple.shade100,
              child: Center(
                child: Icon(
                  Icons.restaurant_menu,
                  size: 60,
                  color: Colors.purple,
                ),
              ),
            );
          },
        )
      : Container(
          color: Colors.purple.shade100,
          child: Center(
            child: Icon(
              Icons.restaurant_menu,
              size: 60,
              color: Colors.purple,
            ),
          ),
        ),
),
          Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  restaurant['name'],
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  '${restaurant['cuisine']} • ${restaurant['rating']} ★',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
                SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () => _showOrderDialog(context),
                  icon: Icon(Icons.shopping_cart),
                  label: Text('Order Now'),
                  style: ElevatedButton.styleFrom(
                                        minimumSize: Size(double.infinity, 48),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Booking Screen
class BookingScreen extends StatefulWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final List<Map<String, dynamic>> events = [
    {
      'title': 'Jazz Night',
      'date': '2024-07-10',
      'location': 'City Concert Hall',
      'category': 'Music',
      'image': 'assets/images/jazz.jpg',
      'desc': 'Enjoy a night of smooth jazz with top artists.'
    },
    {
      'title': 'Startup Meetup',
      'date': '2024-07-12',
      'location': 'Tech Hub',
      'category': 'Business',
      'image': 'assets/images/startup.jpg',
      'desc': 'Network with local entrepreneurs and investors.'
    },
    {
      'title': 'Art Expo',
      'date': '2024-07-15',
      'location': 'Modern Art Gallery',
      'category': 'Art',
      'image': 'assets/images/modern_art.jpg',
      'desc': 'Discover contemporary artworks from emerging artists.'
    },
    {
      'title': 'Food Festival',
      'date': '2024-07-20',
      'location': 'Central Park',
      'category': 'Food',
      'image': 'assets/images/food_festival.jpg',
      'desc': 'Taste dishes from the best local restaurants.'
    },
    {
      'title': 'Yoga in the Park',
      'date': '2024-07-22',
      'location': 'Green Meadows',
      'category': 'Wellness',
      'image': 'assets/images/yoga.jpg',
      'desc': 'Join a relaxing outdoor yoga session.'
    },
  ];

  String _search = '';
  String _selectedCategory = 'All';
  String? _selectedLocation;
  DateTime? _startDate;
  DateTime? _endDate;
  String? _bookingFeedback;

  List<String> get categories {
    final cats = events.map((e) => e['category'] as String).toSet().toList();
    cats.sort();
    return ['All', ...cats];
  }

  List<String> get locations {
    final locs = events.map((e) => e['location'] as String).toSet().toList();
    locs.sort();
    return locs;
  }

  List<Map<String, dynamic>> get filteredEvents {
    return events.where((e) {
      final matchesSearch = _search.isEmpty || e['title'].toLowerCase().contains(_search.toLowerCase());
      final matchesCat = _selectedCategory == 'All' || e['category'] == _selectedCategory;
      final matchesLoc = _selectedLocation == null || e['location'] == _selectedLocation;
      final eventDate = DateTime.tryParse(e['date']);
      final matchesStart = _startDate == null || (eventDate != null && !eventDate.isBefore(_startDate!));
      final matchesEnd = _endDate == null || (eventDate != null && !eventDate.isAfter(_endDate!));
      return matchesSearch && matchesCat && matchesLoc && matchesStart && matchesEnd;
    }).toList();
  }

  void _bookEvent(Map<String, dynamic> event) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Book Event'),
        content: Text('Do you want to book a spot for "${event['title']}"?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text('Cancel')),
          ElevatedButton(onPressed: () => Navigator.pop(context, true), child: Text('Book')),
        ],
      ),
    );
    if (confirmed == true) {
      setState(() {
        _bookingFeedback = 'Successfully booked for ${event['title']}!';
      });
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          _bookingFeedback = null;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Events'),
        backgroundColor: Color(0xFF2563EB),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search events...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  onChanged: (v) => setState(() => _search = v),
                ),
                SizedBox(height: 12),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: categories.map((cat) {
                      final selected = _selectedCategory == cat;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ChoiceChip(
                          label: Text(cat),
                          selected: selected,
                          onSelected: (_) => setState(() => _selectedCategory = cat),
                          selectedColor: Color(0xFF2563EB),
                          labelStyle: TextStyle(
                            color: selected ? Colors.white : Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                          backgroundColor: Colors.grey[100],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          if (_bookingFeedback != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
              child: Material(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.green),
                      SizedBox(width: 10),
                      Expanded(child: Text(_bookingFeedback!, style: TextStyle(color: Colors.green[900], fontWeight: FontWeight.w600))),
                    ],
                  ),
                ),
              ),
            ),
          Expanded(
            child: filteredEvents.isEmpty
                ? Center(child: Text('No events found.', style: TextStyle(color: Colors.grey, fontSize: 18)))
                : ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    itemCount: filteredEvents.length,
                    separatorBuilder: (_, __) => SizedBox(height: 18),
                    itemBuilder: (context, i) {
                      final event = filteredEvents[i];
                      return Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                        elevation: 4,
                        shadowColor: Colors.blue.withOpacity(0.08),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(18),
                          onTap: () => _bookEvent(event),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.horizontal(left: Radius.circular(18)),
                                child: Image.network(
                                  event['image'],
                                  width: 110,
                                  height: 110,
                                  fit: BoxFit.cover,
                                  errorBuilder: (c, e, s) => Container(
                                    width: 110,
                                    height: 110,
                                    color: Colors.grey[200],
                                    child: event['image'] != null
                                        ? Image.asset(
                                            event['image'],
                                            width: 40,
                                            height: 40,
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error, stackTrace) => Icon(Icons.event, size: 40, color: Colors.grey[400]),
                                          )
                                        : Icon(Icons.event, size: 40, color: Colors.grey[400]),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(event['title'], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1F2937))),
                                      SizedBox(height: 6),
                                      Row(
                                        children: [
                                          Icon(Icons.calendar_today, size: 15, color: Colors.blueGrey),
                                          SizedBox(width: 4),
                                          Text(event['date'], style: TextStyle(fontSize: 13, color: Colors.blueGrey)),
                                        ],
                                      ),
                                      SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Icon(Icons.place, size: 15, color: Colors.blueGrey),
                                          SizedBox(width: 4),
                                          Text(event['location'], style: TextStyle(fontSize: 13, color: Colors.blueGrey)),
                                        ],
                                      ),
                                      SizedBox(height: 8),
                                      Text(event['desc'], style: TextStyle(fontSize: 14, color: Colors.grey[700]), maxLines: 2, overflow: TextOverflow.ellipsis),
                                      SizedBox(height: 10),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: ElevatedButton(
                                          onPressed: () => _bookEvent(event),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Color(0xFF2563EB),
                                            foregroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                            padding: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
                                            textStyle: TextStyle(fontWeight: FontWeight.w600),
                                          ),
                                          child: Text('Book'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
  final List<Map<String, String>> events = [
  {
    'name': 'Concert in the Park',
    'date': '2023-10-15',
    'location': 'Central Park',
    'price': '50 TMT',
    'description': 'Enjoy live music in the park.',
  },
  {
    'name': 'Art Exhibition',
    'date': '2023-10-20',
    'location': 'City Gallery',
    'price': '30 TMT',
    'description': 'Explore modern art pieces.',
  },
  {
    'name': 'Food Festival',
    'date': '2023-10-25',
    'location': 'Downtown Square',
    'price': 'Free',
    'description': 'Taste cuisines from around the world.',
  },
  {
    'name': 'Tech Conference',
    'date': '2023-11-01',
    'location': 'Convention Center',
    'price': '100 TMT',
    'description': 'Learn about the latest in technology.',
  },
];

 void _bookEvent(BuildContext context, Map<String, dynamic> event) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Book ${event['name']}'),
      content: Text('Do you want to book this event for ${event['price']}?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Booked ${event['name']} successfully!')),
            );
          },
          child: Text('Book'),
        ),
      ],
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Events'), backgroundColor: Colors.blue),
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(event['name']?? 'Unknown Event'),
              subtitle: Text('${event['date']} - ${event['location']} - ${event['price']}'),
              trailing: ElevatedButton(
                onPressed: () => _bookEvent(context, event),
                child: Text('Book'),
              ),
            ),
          );
        },
      ),
      // FloatingActionButton removed as requested
    );
  }

// Post Item Screen
class PostItemScreen extends StatefulWidget {
  const PostItemScreen({Key? key}) : super(key: key);

  @override
  _PostItemScreenState createState() => _PostItemScreenState();
}

class _PostItemScreenState extends State<PostItemScreen> {
  final _formKey = GlobalKey<FormState>();
  File? _imageFile;
  String? _name;
  String? _category;
  String? _price;
  String? _city;
  String? _description;
  String? _phone;

  final List<String> _categories = [
    'Electronics', 'Fashion', 'Sports', 'Home', 'Toys', 'Books', 'Other'
  ];
  final List<String> _cities = [
    'Ashgabat', 'Ahal', 'Balkan', 'Dashoguz', 'Lebap', 'Mary'
  ];

  Future<void> _pickImage() async {
    try {
      final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (picked != null) {
        setState(() {
          _imageFile = File(picked.path);
        });
      }
    } catch (e) {
      setState(() {
        _imageFile = null;
      });
    }
  }

  void _selectCategory() async {
    final selected = await showDialog<String>(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text('Select Category'),
        children: _categories.map((cat) => SimpleDialogOption(
          child: Text(cat),
          onPressed: () => Navigator.pop(context, cat),
        )).toList(),
      ),
    );
    if (selected != null) {
      setState(() => _category = selected);
    }
  }

  void _selectCity() async {
    final selected = await showDialog<String>(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text('Select City'),
        children: _cities.map((city) => SimpleDialogOption(
          child: Text(city),
          onPressed: () => Navigator.pop(context, city),
        )).toList(),
      ),
    );
    if (selected != null) {
      setState(() => _city = selected);
    }
  }

  Future<void> _save() async {
    if (_formKey.currentState!.validate() && _category != null && _city != null) {
      _formKey.currentState!.save();
      final newItem = {
        'title': _name!,
        'price': _price!,
        'category': _category!,
        'seller': 'You',
        'location': _city!,
        'image': _imageFile?.path,
        'description': _description ?? '',
        'phone': _phone ?? '',
        'imageBytes': _imageFile != null ? await _imageFile!.readAsBytes() : null,
      };
      Navigator.pop(context, newItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Item'), backgroundColor: Colors.orange),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: GestureDetector(
                  onTap: _pickImage,
                  child: _imageFile == null
                      ? Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: Colors.orange.shade50,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Icon(Icons.camera_alt, size: 48, color: Colors.orange),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.file(_imageFile!, width: 120, height: 120, fit: BoxFit.cover),
                        ),
                ),
              ),
              SizedBox(height: 24),
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                validator: (v) => v == null || v.isEmpty ? 'Enter name' : null,
                onSaved: (v) => _name = v,
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: _selectCategory,
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Category',
                      hintText: 'Select category',
                    ),
                    validator: (v) => _category == null ? 'Select category' : null,
                    controller: TextEditingController(text: _category),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (v) => v == null || v.isEmpty ? 'Enter price' : null,
                onSaved: (v) => _price = v,
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: _selectCity,
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'City',
                      hintText: 'Select city',
                    ),
                    validator: (v) => _city == null ? 'Select city' : null,
                    controller: TextEditingController(text: _city),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
                onSaved: (v) => _description = v,
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                onSaved: (v) => _phone = v,
              ),
              SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _save,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text('Save', style: TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Search Restaurant Screen
class SearchRestaurantScreen extends StatelessWidget {
  const SearchRestaurantScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Restaurant'),
              ),
      body: Center(
        child: Text(
          'Search functionality coming soon!',
          style: TextStyle(fontSize: 22, color: Colors.grey),
        ),
      ),
    );
  }
}
