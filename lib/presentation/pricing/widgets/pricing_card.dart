import 'package:flutter/material.dart';
import 'package:other_screens/common/constants.dart';

class PremiumPackageCard extends StatelessWidget {
  const PremiumPackageCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: mediaWidth(context) * 0.74,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: pricingCardback, // Green background
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        children: [
          // Top-right star decoration
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset("assets/icons/pricing/top-star.png"),
          ),
          // Bottom-left star decoration
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset("assets/icons/pricing/top-star.png"),
          ),
          // Main content
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: const [
                  Text(
                    'Nerala',
                    style: TextStyle(
                      color: white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 5),
                  Icon(
                    Icons.add,
                    color: white,
                    size: 24,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _buildFeatureRow('Premium Content Access'),
              _buildFeatureRow('Ads free experience!'),
              _buildFeatureRow('AI-powered language learning tools'),
              _buildFeatureRow('Seamless & fun Learning'),
              _buildFeatureRow('And much more...'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureRow(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              color: Colors.amber,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.emoji_events,
              color: white,
              size: 16,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: white,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
