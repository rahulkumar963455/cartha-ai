import 'dart:ui';
import 'package:flutter/material.dart';
class Message {
  final String text;
  final bool isSent;

  Message({required this.text, required this.isSent});
}

class CarthaChatPage extends StatelessWidget {
  final List<Message> messages = [
    Message(
      text: "Burnout can manifest in various ways, such as physical and emotional exhaustion, reduced performance, and feelings of detachment. It’s essential to identify the signs early on to address them effectively.",
      isSent: false,
    ),
    Message(
      text: "Burnout can manifest in various ways, such as physical and emotional exhaustion, reduced performance, and feelings of detachment. It’s essential to identify the signs early on to address them effectively.",
      isSent: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isMobile = screenWidth < 800; // you can adjust the breakpoint

    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
    children: [
    // Left Section (Header + Chat)
      Expanded(
        flex: isMobile ? 1 : 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16),
              child: Card(
                elevation: 2,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Image.asset('assets/images/app_icon.png', height: 30),
                        const SizedBox(width: 10),
                        const Text("Cartha AI",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF003366))),
                        const SizedBox(width: 30),
                        _headerButton("Home"),
                        _headerButton("Cartha for Web", active: true),
                        _headerButton("Cartha for Orgs"),
                        _headerButton("Safety"),
                        _headerButton("FAQ"),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Chat Section
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 16 : 40,
                  vertical: 10,
                ),
                child: ListView.builder(
                  itemCount: (messages.length / 2).ceil(),
                  itemBuilder: (context, index) {
                    // Pair-wise messages: sent then received
                    final sentMsg = messages[index * 2];
                    final recvMsg = (index * 2 + 1) < messages.length
                        ? messages[index * 2 + 1]
                        : null;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Sent Message
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            margin: const EdgeInsets.only(top: 12, bottom: 6),
                            padding: const EdgeInsets.all(16),
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.345,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFDFF5E3), // Light green
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 8,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Text(
                              sentMsg.text,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ),

                        if (recvMsg != null)
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              margin: const EdgeInsets.only(top: 10, bottom: 50),
                              constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width * 0.345,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 8,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    'assets/images/app_icon.png',
                                    height: 36,
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Understanding Burnout",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          recvMsg.text,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(right:  10, bottom: 10),
                                          child: Align(
                                              alignment: Alignment.bottomRight,
                                              child: Icon(Icons.record_voice_over_outlined,size: 12,)),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ),
            ),

            // Input Bar
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 100),
                width: screenWidth * 0.90,
                height: screenHeight * 0.13,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: buildInputBar(context),
              ),
            ),
          ],
        ),
      ),


      Container(
        width: isMobile ? screenWidth : screenWidth * 0.25,
        child: Column(
          children: [
            // Top Row
            Row(
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text("Authorize", style: TextStyle(color: Colors.blue)),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.keyboard_arrow_down, size: 25),
                ),
              ],
            ),

            // Main Content and ListTiles Section
            Expanded(
              child: Stack(
                children: [
                  // Background Image
                  Positioned.fill(
                    child: Image.asset(
                      'assets/images/background.png',
                      fit: BoxFit.cover,
                    ),
                  ),

                  // Gradient Overlay
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.white.withOpacity(0.8),
                            Colors.white.withOpacity(0.5),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),

                  // Content
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        // Scrollable Content
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Join Cartha", style: TextStyle(fontSize: screenWidth * 0.015, fontWeight: FontWeight.bold, color: Color(0xFF003366))),
                                Text("For Full Experience", style: TextStyle(fontSize: screenWidth * 0.012, color: Colors.black87)),
                                SizedBox(height: screenHeight * 0.02),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("You will get:", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey,fontSize: screenWidth*0.01)),
                                ),
                                SizedBox(height: screenHeight * 0.01),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: TextButton.icon(
                                    onPressed: null, // Disable click effect
                                    icon: Icon(Icons.check, color:Color(0xFF092E51), size: screenWidth * 0.015),
                                    label: Text(
                                      "Upgraded Intelligent Therapy",
                                      style: TextStyle(
                                        color: Color(0xFF092E51),
                                        fontSize: screenWidth * 0.01,
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: TextButton.icon(
                                    onPressed: null,
                                    icon: Icon(Icons.check, color:  Color(0xFF092E51), size: screenWidth * 0.015),
                                    label: Text(
                                      "No Message Limits",
                                      style: TextStyle(
                                        color: Color(0xFF092E51),
                                        fontSize: screenWidth * 0.01,
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: TextButton.icon(
                                    onPressed: null,
                                    icon: Icon(Icons.check, color:  Color(0xFF092E51), size: screenWidth * 0.015),
                                    label: Text(
                                      "Cartha Remembers Conversations",
                                      style: TextStyle(
                                        color:Color(0xFF092E51),
                                        fontSize: screenWidth * 0.01,
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: TextButton.icon(
                                    onPressed: null,
                                    icon: Icon(Icons.check, color:Color(0xFF092E51), size: screenWidth * 0.015),
                                    label: Text(
                                      "Personalized Wellness Analytics",
                                      style: TextStyle(
                                        color: Color(0xFF092E51),
                                        fontSize: screenWidth * 0.01,
                                      ),
                                    ),
                                  ),
                                ), // leave space for bottom button
                              ],
                            ),
                          ),
                        ),

                        // Sign Up Button at Bottom Center
                        // At the end of your main Column (inside Padding)
                        Padding(
                          padding: EdgeInsets.only(bottom: screenHeight * 0.02),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Sign Up Button
                              Center(
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    foregroundColor: Colors.white,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: screenWidth * 0.05,
                                      vertical: screenHeight * 0.015,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Text(
                                    "Sign Up",
                                    style: TextStyle(fontSize: screenWidth * 0.015),
                                  ),
                                ),
                              ),

                              SizedBox(height: screenHeight * 0.01),

                              // Already have an account? Login
                              Center(
                                child: Text.rich(
                                  TextSpan(
                                    text: "Already have an account? ",
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.7),
                                      fontSize: screenWidth * 0.0095,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "Login",
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.w600,
                                          fontSize: screenWidth * 0.0095,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Optional: Bottom ListTiles
            Container(
              decoration: BoxDecoration(
                color: Colors.blue.shade50
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        // Go Premium action
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text("Go Premium", style: TextStyle(fontSize: 14)),
                          Icon(Icons.arrow_forward_ios, size: 14),
                        ],
                      ),
                    ),
                    SizedBox(height:screenHeight*0.02 ,),
                    InkWell(
                      onTap: () {
                        // Get App action
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text("Get App", style: TextStyle(fontSize: 14)),
                          Icon(Icons.arrow_forward_ios, size: 14),
                        ],
                      ),
                    ),
                    SizedBox(height:screenHeight*0.01 ,),
                  ],
                ),
              ),
            )
              ],
        ),
      ),

    ],
    ),

    );

  }
  Widget buildInputBar(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.02,
        color: Colors.blue.shade50,
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.008,),
        child: Container(
          padding:  EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.blue.shade100,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Type here",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.blue.shade100,
                    hintStyle: const TextStyle(color: Colors.black54),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.005,),
              buildGlassIcon(Icons.mic),
              SizedBox(width: MediaQuery.of(context).size.width * 0.005),
              buildGlassIcon(Icons.image),
              SizedBox(width:  MediaQuery.of(context).size.width * 0.008),
              Container(
                width: 80,
                height: 35,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.send, size: 9),
                  label: Text("Send",style: TextStyle(
                    fontSize: 10
                  ),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }


  Widget buildGlassIcon(IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.4),
        shape: BoxShape.circle,
      ),
      padding: const EdgeInsets.all(6),
      child: Icon(icon, size: 18, color: Colors.blue),
    );
  }


  Widget _headerButton(String text, {bool active = false}) {
    return TextButton(
      onPressed: () {},
      child: Text(
        text,
        style: TextStyle(color: active ? Colors.blue : Colors.grey),
      ),
    );
  }
}
