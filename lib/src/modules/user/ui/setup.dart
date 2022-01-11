import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mygate_app/src/modules/homepage_manager/homepage_manager.dart';
import 'package:mygate_app/src/modules/user/bloc/user_bloc.dart';
import 'package:mygate_app/src/modules/user/ui/login.dart';
// import 'package:app/src/Globals.dart' as ;

class SetupPage extends StatefulWidget {
  const SetupPage({Key? key}) : super(key: key);

  @override
  _SetupPageState createState() => new _SetupPageState();
}

class _SetupPageState extends State<SetupPage> {
  // ignore: unused_field
  UserBloc bloc = UserBloc();

  @override
  void initState() {
    super.initState();
    bloc.add(AutoLogin());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Stack(alignment: Alignment.center, children: [
            BlocBuilder(
                bloc: bloc,
                builder: (BuildContext context, UserState state) {
                  if (state is UserInitial || state is Loading) {
                    return Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/R.jpg'),
                            fit: BoxFit.cover),
                      ),
                    );

                    // Container(
                    //   color: Theme.of(context).backgroundColor,

                    //   // return Container(
                    //   //     decoration: BoxDecoration(
                    //   //   image: DecorationImage(
                    //   //       image: AssetImage('assets/R.jpg'), fit: BoxFit.cover),
                    // );
                    // Center(
                    //     child:
                    //         Image.asset('assets/R.jpg', fit: BoxFit.cover));
                  }
                  return Container(
                    height: 0,
                  );
                }),
            BlocListener<UserBloc, UserState>(
              bloc: bloc,
              listener: (context, state) async {
                if (state is AutoLoginSucess) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              HomePageManager()));
                }
                if (state is ErrorReceived) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => LoginPage()));
                }
              },
              child: Container(
                height: 0,
              ),
            ),
          ]),
        ));
  }
}
