import 'package:flutter/material.dart';
import 'package:mygate_app/src/globals.dart';
import 'package:mygate_app/src/modules/profile_module/ui/profile.dart';
import 'package:mygate_app/src/modules/user/bloc/user_bloc.dart';

class AppbarPage extends StatefulWidget {
  const AppbarPage({Key? key}) : super(key: key);

  @override
  _AppbarPageState createState() => _AppbarPageState();
}

UserBloc _userBloc = UserBloc();

class _AppbarPageState extends State<AppbarPage> {
  @override
  Widget build(BuildContext context) {
    return
//       elevation: 0,
//       backgroundColor: Colors.white,
//       automaticallyImplyLeading: false,
//       actions: [
//         BlocListener<UserBloc, UserState>(
//             bloc: _userBloc,
//             listener: (context, state) {
//               if (state is LoggedOut) {
//                 Navigator.pushAndRemoveUntil(
//                     context,
//                     MaterialPageRoute(
//                         builder: (BuildContext context) => LoginPage()),
//                     (Route<dynamic> route) => false);
//               }
//             },
//             child: IconButton(
//                 onPressed: () {
//                   _userBloc.add(LogOut());
//                 },
//                 icon: Icon(Icons.logout),
//                 color: Colors.black))
//       ],
//       title: Globals.name.isNotEmpty
//           ? Text(
//               'Hello ${Globals.name}',
//               style: TextStyle(color: Colors.black),
//             )
//           : Text(
//               "Hello",
//               style: TextStyle(color: Colors.black),
//             ),
//     );
//   }
// }
        AppBar(
            elevation: 0,
            leading: Container(
              padding: EdgeInsets.all(9),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
                },
                child: Globals.profileUrl == ''
                    ? CircleAvatar(radius: 16, child: Text(Globals.name[0]))
                    : CircleAvatar(
                        radius: 16,
                        child: CircleAvatar(
                            radius: 16,
                            backgroundImage: NetworkImage(Globals.profileUrl)),
                      ),
              ),
            ));
  }
}
