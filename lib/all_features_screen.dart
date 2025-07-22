import 'package:flutter/material.dart';
import 'main.dart';

class AllFeaturesScreen extends StatelessWidget {
  const AllFeaturesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Features'),
        backgroundColor: Color(0xFF2563EB),
      ),
      body: ListView(
        padding: EdgeInsets.all(24),
        children: [
          _buildFeatureTile(context, Icons.explore, 'Weather', WeatherWidget()),
          _buildFeatureTile(context, Icons.movie, 'Movies', MovieManagerScreen()),
          _buildFeatureTile(context, Icons.shopping_bag, 'Marketplace', MarketplaceScreen()),
          _buildFeatureTile(context, Icons.restaurant, 'Food Delivery', FoodDeliveryScreen()),
          _buildFeatureTile(context, Icons.event, 'Events', BookingScreen()),
        ],
      ),
    );
  }

  Widget _buildFeatureTile(BuildContext context, IconData icon, String title, Widget screen) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: Icon(icon, size: 32, color: Color(0xFF2563EB)),
        title: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        trailing: Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey[400]),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => screen),
          );
        },
      ),
    );
  }
}
