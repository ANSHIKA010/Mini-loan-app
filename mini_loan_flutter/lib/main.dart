import 'package:mini_loan_flutter/utils/routes.dart';
import 'package:mini_loan_flutter/viewModels/admin_viewmodel.dart';
import 'package:mini_loan_flutter/viewModels/auth_viewmodel.dart';
import 'package:mini_loan_flutter/viewModels/user_viewmodel.dart';
import 'package:mini_loan_flutter/views/splash_screen.dart';
import 'package:mini_loan_flutter/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //it requires 3 parameters
    //context, orientation, device
    //it always requires, see plugin documentation
    return Sizer(builder: (context, orientation, device) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AdminViewModel()),
          ChangeNotifierProvider(create: (_) => AuthViewModel()),
          ChangeNotifierProvider(create: (_) => UserViewModel()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Mini Loan',
          theme: CustomTheme().baseTheme,
          //initial route is splash screen
          //mean first screen
          initialRoute: SplashScreen.routeName,
          //define the routes file here in order to access the routes any where all over the app
          routes: routes,
        ),
      );
    });
  }
}
