import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truckappp/provider/google_map_provider.dart';
import 'package:truckappp/utils/app_images_strings.dart';
import 'package:truckappp/utils/app_string.dart';
import 'package:truckappp/views/home_view/bottom_menu.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<GoogleMapProvider>(context, listen: false)
          .getcureentuser(context);
    });

    Navigate();
  }

  // ignore: non_constant_identifier_names
  Navigate() {
    Future.delayed(const Duration(seconds: 6)).then((value) {
      Navigator.pushAndRemoveUntil<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => const BottomScreen(),
        ),
        (route) => false, //if you want to disable back feature set to false
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 21 * MediaQuery.of(context).size.height / 100,
                child: Column(children: [
                  Image.asset(
                    AppImageStrings.splashLogo,
                        fit: BoxFit.cover,
                    height: 120,
                  ),
                 const  SizedBox(height: 10,),
                 const Text(AppStrings.app__main___name, textScaleFactor: 1.5,
                    style:  TextStyle(fontWeight: FontWeight.w800),)
                ],)


              ),
            ],
          ),
        ),
      ),
    );
  }
}
