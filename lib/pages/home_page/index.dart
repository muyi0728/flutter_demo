import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import './grid_navigation.dart';
import '../../widgets/commodity_info_card.dart';
import '../../widgets/return_top.dart';
import '../../models/home_page_model.dart';
import '../../blocs/home_page/home_page_bloc.dart';
import '../../blocs/common_bloc/return_top_bloc.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  HomePageBloc homePageBloc;
  ReturnTopBloc returnTopBloc;
  int pageIndex = 0;
  bool scrollCheckSwitch = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    homePageBloc = HomePageBloc();
    returnTopBloc = ReturnTopBloc();
    homePageBloc.getCommonList();
    homePageBloc.getCommodityInfo();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        pageIndex = pageIndex++;
        homePageBloc.getCommodityInfo(pageIndex: pageIndex);
      }
    });
    _scrollController.addListener(() {
      if (_scrollController.offset < 600 && scrollCheckSwitch) {
        scrollCheckSwitch = false;
        returnTopBloc.setReturnTopStatus(isShowReturnTopBtn: true);
      } else if (_scrollController.offset > 600 && !scrollCheckSwitch) {
        scrollCheckSwitch = true;
        returnTopBloc.setReturnTopStatus(isShowReturnTopBtn: false);
      }
    });
  }

  @override
  void dispose() {
    homePageBloc?.dispose();
    returnTopBloc?.dispose();
    _scrollController.dispose();
    super.dispose();
    print('首页销毁了...');
  }

  /// 重写 wantKeepAlive 保持页面当前状态
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('首页'),
      ),
      body: CustomScrollView(
        controller: _scrollController,
        physics: ScrollPhysics(),
        slivers: <Widget>[
          /// 轮播图
          SliverToBoxAdapter(
            child: StreamBuilder(
              stream: homePageBloc.homePageCommonMap,
              builder: (BuildContext context, AsyncSnapshot<HomePageCommonModel> snapshot){
                if (snapshot.data != null) {
                  return Container(
                    height: 200,
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
                  stream: homePageBloc.homePageCommonMap,
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
              stream: homePageBloc.commodityInfoList,
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
      /// 返回顶部
      floatingActionButton: StreamBuilder(
        stream: returnTopBloc.returnTopController,
        initialData: true,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          return new ReturnTop(status: snapshot.data, onPressed: () {
              _scrollController.animateTo(0.0, duration: new Duration(milliseconds: 300), curve: Curves.linear);
            },
          );
        },
      ),
    );
  }
}
