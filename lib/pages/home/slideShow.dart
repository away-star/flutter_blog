import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class SlideShow extends StatefulWidget {
  const SlideShow({Key? key}) : super(key: key);

  @override
  State<SlideShow> createState() => _SlideShowState();
}

class _SlideShowState extends State<SlideShow> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.only(top: 10.0),
        height: 200.0,
        decoration: BoxDecoration(
          // 容器的装饰器
          boxShadow: [
            // 容器阴影的数组
            BoxShadow(
              // 定义一个阴影
              color: Colors.grey.withOpacity(0.2), // 阴影的颜色，带上透明度
              spreadRadius: 2, // 阴影的扩散半径
              blurRadius: 5, // 阴影的模糊半径
              offset: Offset(0, 3), // 阴影的偏移量，(0, 3) 表示阴影在容器正下方
            ),
          ],
        ),
        // 使用 CarouselSlider.builder 构建一个图片轮播组件
        child: CarouselSlider.builder(
          // 图片数量
          itemCount: 5,
          // 轮播配置选项
          options: CarouselOptions(
            height: 200.0,
            // 轮播高度
            viewportFraction: 0.75,
            // 每张图片在视窗中的占比
            aspectRatio: 1.5,
            // 图片宽高比
            autoPlay: true,
            // 自动轮播
            autoPlayInterval: Duration(seconds: 2),
            // 轮播间隔
            enlargeCenterPage: true,
            // 中间图片是否放大
            onPageChanged: (index, reason) {
              // 监听当前页码变化
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          // 构建图片列表
          itemBuilder: (BuildContext context, int index, int? _) {
            return CachedNetworkImage(
              // 图片 URL
              imageUrl: 'https://picsum.photos/seed/${index + 1}/600/400',
              // 图片构建器
              imageBuilder: (context, imageProvider) => Container(
                // 图片容器样式
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
                // 底部小圆点组件
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      5,
                      (i) => Container(
                        width: 6.0,
                        height: 6.0,
                        margin: EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 2.0,
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          // 当前页码对应小圆点样式
                          color: _currentIndex == i
                              ? Color.fromRGBO(255, 255, 255, 0.9)
                              : Color.fromRGBO(255, 255, 255, 0.4),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // 图片加载时的占位图
              placeholder: (context, url) => Center(
                child: CircularProgressIndicator(),
              ),
              // 图片加载失败时的图标
              errorWidget: (context, url, error) => Icon(Icons.error),
            );
          },
        ),
      ),
    );
  }
}
