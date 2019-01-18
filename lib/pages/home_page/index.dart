import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import './grid_navigation.dart';
import '../../widgets/commodity_info_card.dart';
import '../../models/home_page_model.dart';
import '../../blocs/home_page/home_page_bloc.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  HomePageBloc bloc;
  int pageIndex = 0;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    bloc = HomePageBloc();
    bloc.getCommonList();
    bloc.getCommodityInfo();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        pageIndex = pageIndex++;
        bloc.getCommodityInfo(pageIndex: pageIndex);
      }
    });
  }

  @override
  void dispose() {
    bloc?.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  /// 重写 wantKeepAlive 保持页面当前状态
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        physics: ScrollPhysics(),
        slivers: <Widget>[
          /// 轮播图
          SliverToBoxAdapter(
            child: StreamBuilder(
              stream: bloc.homePageCommonMap,
              builder: (BuildContext context, AsyncSnapshot<HomePageCommonModel> snapshot){
                if (snapshot.data != null) {
                  return Container(
                    height: 240,
                    child: Swiper(
                      itemBuilder: (BuildContext context, int index) {
                        return Image.network(
                          snapshot.data.carouselList[index].imageSrc,
                          fit: BoxFit.fill,
                        );
                      },
                      itemCount: snapshot.data.carouselList.length,
                      autoplay: true,
                      pagination: new SwiperPagination(),
                      onTap: (int index) {
                        // print("$index");
                      },
                    ),
                  );
                } else {
                  return Text('轮播数据加载中...');
                }
              },
            ),
          ),
          /// 广告条
          SliverToBoxAdapter(
            child: InkWell(
                onTap: () {},
                child: Container(
                  alignment: Alignment.center,
                  // padding: const EdgeInsets.all(5.0),
                  color: Colors.white70,
                  margin: const EdgeInsets.only(top: 10),
                  width: MediaQuery.of(context).size.width,
                  // height: MediaQuery.of(context).size.width * 180 / 740,
                  child: Image.network("https://taoke-prod.oss-cn-hangzhou.aliyuncs.com/home/new-course.png"),
                )),
          ),
          /// 宫格导航
          SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.only(bottom: 20.0),
                child: StreamBuilder(
                  stream: bloc.homePageCommonMap,
                  builder: (BuildContext context, AsyncSnapshot<HomePageCommonModel> snapshot) {
                    List<Widget> _gridNavigation = [];
                    if (snapshot.data != null) {
                      snapshot.data.gridNavigationList.forEach((item){
                        _gridNavigation.add(GridNavigation(item));
                      });
                      return Wrap(
                          spacing: 32.0, // 主轴(水平)方向间距
                          runSpacing: 26.0, // 纵轴（垂直）方向间距
                          alignment: WrapAlignment.center, //沿主轴方向居中
                          children: _gridNavigation);
                    } else {
                      return Text('宫格导航数据数据加载中...');
                    }
                  },
                ),
              )
          ),
          /// 商品信息列表
          Container(
            child: StreamBuilder(
              stream: bloc.commodityInfoList,
              builder: (BuildContext context, AsyncSnapshot<List<CommodityInfoModel>> snapshot) {
                if (snapshot.data != null) {
                  return SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 0,
                      childAspectRatio: 4 / 5,
                    ),
                    // SliverChildBuilderDelegate
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return CommodityInfoCard(snapshot.data[index]);
                    }, childCount: snapshot.data.length),
                  );
                } else {
                  return SliverToBoxAdapter(
                      child: Text('列表数据加载中...')
                  );
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: buildFloatingActionButton(),
    );
  }

  /// 返回顶部
  Widget buildFloatingActionButton() {
//    if (_scrollController == null || _scrollController.offset < 600) {
//      return null;
//    }
    return new FloatingActionButton(
      backgroundColor: Theme.of(context).primaryColor,
      child: Icon(
        Icons.keyboard_arrow_up,
      ),
      mini: true,
      onPressed: () {
        _scrollController.animateTo(0.0, duration: new Duration(milliseconds: 300), curve: Curves.linear);
      },
    );
  }
}
