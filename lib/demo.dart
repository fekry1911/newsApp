import 'package:flutter/material.dart';



class WeatherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Top Background with Weather Info
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipPath(
              clipper: WaveClipper(),
              child: Container(
                height: 400,
                decoration: BoxDecoration(
                  color: Colors.blue.shade800,
                  image: DecorationImage(
                    image: AssetImage('assets/background.png'), // Add your background image
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(Icons.menu, color: Colors.white),
                          onPressed: () {},
                        ),
                        Text(
                          "DELHI",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.settings, color: Colors.white),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "18°",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Cloudy",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("26°", style: TextStyle(color: Colors.white)),
                        Icon(Icons.arrow_drop_up, color: Colors.white),
                        const SizedBox(width: 10),
                        Text("15°", style: TextStyle(color: Colors.white)),
                        Icon(Icons.arrow_drop_down, color: Colors.white),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Weather Forecast List
          Positioned(
            top: 350,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      _buildWeatherRow("Monday", "23°", Icons.wb_sunny),
                      _buildWeatherRow("Tuesday", "18°", Icons.wb_sunny),
                      _buildWeatherRow("Wednesday", "21°", Icons.wb_sunny),
                      _buildWeatherRow("Thursday", "20°", Icons.cloud),
                      _buildWeatherRow("Friday", "18°", Icons.cloud),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Floating Button
          Positioned(
            right: 30,
            top: 330,
            child: FloatingActionButton(
              onPressed: () {},
              backgroundColor: Colors.white,
              elevation: 4,
              child: Icon(Icons.add, color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherRow(String day, String temp, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            day,
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
          Row(
            children: [
              Text(
                temp,
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
              const SizedBox(width: 10),
              Icon(icon, color: Colors.blue),
            ],
          ),
        ],
      ),
    );
  }
}

// Custom Clipper for the Curved Design
class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 50);

    path.quadraticBezierTo(
      size.width / 2, size.height + 30, // Control and end point
      size.width, size.height - 50,
    );

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
