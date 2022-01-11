import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mygate_app/src/modules/send_notification/modals/visitor_update.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeDataBloc extends Bloc<HomeDataEvent, HomeDataState> {
  HomeDataBloc() : super(HomeDataInitial());

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  VisitorDetailsModel visitorDetailsModel = VisitorDetailsModel();
  var data;
  @override
  Stream<HomeDataState> mapEventToState(
    HomeDataEvent event,
  ) async* {
    //auto login bloc
    if (event is HomeNotificationData) {
      try {
        yield HomeLoading();
        List<VisitorDetailsModel> data = await fatchHomeData();
        print(data);
        yield HomeDataSuccess(data2: data);
      } catch (e) {
        throw Exception("failed");
      }
    }
  }

  Future<List<VisitorDetailsModel>> fatchHomeData() async {
    try {
      await FirebaseFirestore.instance
          .collection('VisitorDetails')
          .get()
          .then((QuerySnapshot querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          data = querySnapshot.docs
              .map((doc) => VisitorDetailsModel.fromSnapshot(doc))
              .toList();
          // doc.data()).toList();
          print(data);
          return data;
        }
      });
      return data;
    } catch (e) {
      throw Exception("no data found");
    }
  }
}
