import 'package:flutter/material.dart';
import 'package:other_screens/common/constants.dart';
import 'package:other_screens/presentation/pricing/widgets/pay_button.dart';
import 'package:other_screens/presentation/pricing/widgets/pricing_card.dart';

// Main Premium Page
class PremiumPage extends StatefulWidget {
  const PremiumPage({super.key});

  @override
  State<PremiumPage> createState() => _PremiumPageState();
}

class _PremiumPageState extends State<PremiumPage> {
  bool isYearlySelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBgColor,
      body: SafeArea(
        child: Padding(
          padding: allPadding,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildHeader(),
                const SizedBox(height: 5),
                _buildHeroSection(),
                const SizedBox(height: 9),
                _buildQuote(),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SubscriptionToggle(
                    isYearlySelected: isYearlySelected,
                    onToggle: (value) =>
                        setState(() => isYearlySelected = value),
                  ),
                ),
                const SizedBox(height: 6),
                PremiumPackageCard(),
                SizedBox(height: mediaWidth(context) * 0.095),
                AnimatedPriceButton(
                  isEnabled: true,
                  price: isYearlySelected ? yearlyPrice : monthlyPrice,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.close, size: 28),
          onPressed: () => Navigator.pop(context),
        ),
        Container(
          padding: allPadding,
          decoration: const BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle,
          ),
          child: Image.asset("assets/icons/pricing/crown.png"),
        ),
      ],
    );
  }

  Widget _buildHeroSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: pricingCardback,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Upgrade to Nerala+',
                  style: TextStyle(
                    color: white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'and unlock amazing features',
                  style: TextStyle(
                    color: white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Image.asset("assets/icons/pricing/new-nerala-logo.png"),
        ],
      ),
    );
  }

  Widget _buildQuote() {
    return const Text(
      'A good thing sells itself, but it is not given for free.',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 18,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.w300,
      ),
    );
  }
}

// Subscription Toggle Widget
class SubscriptionToggle extends StatelessWidget {
  final bool isYearlySelected;
  final ValueChanged<bool> onToggle;

  const SubscriptionToggle({
    super.key,
    required this.isYearlySelected,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          _buildOption('Year', isYearlySelected, true),
          _buildOption('Month', !isYearlySelected, false),
        ],
      ),
    );
  }

  Widget _buildOption(String text, bool isSelected, bool isYearly) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onToggle(isYearly),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? pricingCardback : Colors.transparent,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? white : Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
