import 'package:flutter/material.dart';
import 'package:app_demo/screens/BaseScreen.dart';
import 'package:app_demo/blocs/CategoryBloc.dart';
import 'package:app_demo/api/Repsonse.dart';
import 'package:app_demo/models/Categories.dart';

class CategoriesScreens extends BaseScreens{
  @override
  _GetChuckyState createState() => _GetChuckyState();
}

class _GetChuckyState extends State<CategoriesScreens> {
  CategoryBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = CategoryBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: false,
        title: Text('List Categories',
            style: TextStyle(color: Colors.white, fontSize: 20)),
        backgroundColor: Color(0xFF3366ff),
      ),
      backgroundColor: Color(0xFFFFFFFF),
      body: RefreshIndicator(
        onRefresh: () => _bloc.fetchCategories(),
        child: StreamBuilder<Response<Categories>>(
          stream: _bloc.chuckListStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data.status) {
                case Status.LOADING:
                  return Loading(loadingMessage: snapshot.data.message);
                  break;
                case Status.COMPLETED:
                  return CategoryList(categoryList: snapshot.data.data);
                  break;
                case Status.ERROR:
                  return Error(
                    errorMessage: snapshot.data.message,
                    onRetryPressed: () => _bloc.fetchCategories(),
                  );
                  break;
              }
            }
            return Container();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}

class CategoryList extends StatelessWidget {
  final Categories categoryList;

  const CategoryList({Key key, this.categoryList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color(0xFF202020),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 0.0,
                vertical: 0.2,
              ),
              child: InkWell(
                  onTap: () {
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (context) =>
                    //         CategoryDetail(categoryList.categories[index])));
                  },
                  child: SizedBox(
                    height: 65,
                    child: Container(
                      color: Color(0xFFFFFFFF),
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: Text(
                          categoryList.categories[index],
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w100,
                              fontFamily: 'Roboto'),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  )));
        },
        itemCount: categoryList.categories.length,
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
      ),
    );
  }
}