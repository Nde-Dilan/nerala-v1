import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:other_screens/common/constants.dart';
import 'package:other_screens/common/helpers/navigator/app_navigator.dart';
import 'package:other_screens/domain/auth/usecases/logout.dart';
import 'package:other_screens/presentation/pages/landing_page.dart';
import 'package:other_screens/presentation/settings/pages/settings_page.dart';
import 'package:url_launcher/url_launcher.dart';

Logger _log = Logger('custom_inkwell.dart');

class CustomInkWell extends StatelessWidget {
  final String name;
  final bool? editImage;
  // final ImageSource? gallery;
  final TextStyle style;
  final IconData icon;

  const CustomInkWell({
    required this.style,
    required this.name,
    required this.icon,
    super.key,
    this.editImage,
  });

  @override
  Widget build(BuildContext context) {
    // final User user = context.watch<UserNotifier>().getUser();

    return Builder(builder: (context) {
      return InkWell(
        onTap: () async {
          switch (name.toLowerCase()) {
            case "logout":
              LogoutUseCase z = LogoutUseCase();
              z.call();
              AppNavigator.pushReplacement(context, LandingPage());
              break;
            case "edit personal details":
              // Handle edit personal details
              break;
            
            case "settings":
              AppNavigator.push(context, SettingsPage());
              break;
            case "help":
              break;
            case "about":
              final Uri url = Uri.parse(
                  'https://nerala-production.vercel.app/'); // Replace with your help URL
              try {
                await launchUrl(url, mode: LaunchMode.externalApplication);
              } catch (e) {
                _log.severe('Could not launch help page: $e');
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Could not open about page'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              }
              break;
            default:
              if (editImage != null && editImage == true) {
                return;
              }
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
              color: const Color(0xffDFDDDD).withOpacity(0.2),
              borderRadius: BorderRadius.circular(20)),
          child: Row(
            children: [
              Icon(
                icon,
                size: 24,
                color: seedColor,
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                name,
                style: style,
              ),
              const Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                size: 30,
                color: seedColor,
              ),
            ],
          ),
        ),
      );
    });
  }
}


// Future<void> getImage(ImageSource source) async {
//   final picker = ImagePicker();
//   final image = await picker.pickImage(source: source);

//   if (image != null) {
//     // Handle the picked image (e.g., display, upload)
//     final imageFile = File(image.path);


//     _log.info("Image selected, ${imageFile.path}");
  
//   } else {
//     // Handle canceled pick operation (optional)
//     _log.info('User canceled image selection');
//   }
// }