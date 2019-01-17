import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import './grid_navigation.dart';
import '../../widgets/commodity_info_card.dart';
import '../../models/home_page_model.dart';
import '../../blocs/home_page/home_page_bloc.dart';
import '../../bloc_widgets/bloc_state_builder.dart';
import '../../blocs/home_page/commodity_info_bloc.dart';
import '../../blocs/home_page/commodity_info_event.dart';
import '../../blocs/home_page/commodity_info_state.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  HomePageBloc bloc;
  CommodityInfoBloc commodityInfoBloc;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    bloc = HomePageBloc();
    commodityInfoBloc = CommodityInfoBloc();
    bloc.getGridNavigationList();
    bloc.getCarouselList();
//    bloc.getCommodityInfo();
    commodityInfoBloc.emitEvent(CommodityInfoEvent());
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        print("loadMore");
        commodityInfoBloc.emitEvent(CommodityInfoEvent(
          type: CommodityInfoEventType.loadMore
        ));
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
              stream: bloc.carouse,
              builder: (BuildContext context, AsyncSnapshot<List<CarouseModel>> snapshot){
                if (snapshot.data != null) {
                  return  Container(
                    height: 240,
                    child: Swiper(
                      itemBuilder: (BuildContext context, int index) {
                        return Image.network(
                          snapshot.data[index].imageSrc,
                          fit: BoxFit.fill,
                        );
                      },
                      itemCount: snapshot.data == null ? 0 : snapshot.data.length,
                      autoplay: true,
                      pagination: SwiperPagination(),
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
                  stream: bloc.gridNavigationList,
                  builder: (BuildContext context, AsyncSnapshot<List<GridNavigationModel>> snapshot) {
                    List<Widget> _gridNavigation = [];
                    if (snapshot.data != null) {
                      snapshot.data.forEach((item){
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
            child: BlocEventStateBuilder<CommodityInfoState>(
              bloc: commodityInfoBloc,
              builder: (BuildContext context, CommodityInfoState state) {
                print(state.isLoading);
                print(state.commodityInfoList);
                if (state.commodityInfoList != null) {
                  return SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 0,
                      childAspectRatio: 3 / 4,
                    ),
                    // SliverChildBuilderDelegate
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return CommodityInfoCard(state.commodityInfoList[index]);
                    }, childCount: state.commodityInfoList == null ? 0 : state.commodityInfoList.length),
                  );
                } else {
                  return SliverToBoxAdapter(
                    child: Text('列表数据加载中...')
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
