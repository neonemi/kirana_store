import 'package:flutter/material.dart';

import '../../core/core.dart';
import '../ui.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AppCoreCubit, AppCoreState>(
      bloc: context.read<AppCoreCubit>()..checkUser(),
      listener: (context, state) {
        if (state is AppCoreNavigateToLoginPage) {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
            builder: (context) {
              return const HomeContainer();
            },
          ), (e) => false);
        }
      },
      child: Scaffold(
        backgroundColor: AppTheme.appYellow,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppLogo(),
              Text('Kirana App',
                  style: TextStyle(
                    fontSize: 32,
                    color: AppTheme.appWhite,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Montserrat',
                  ),
              textAlign: TextAlign.center,)
            ],
          ),
        ),
      ),
    );
  }
}
