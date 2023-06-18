import 'package:flu/api/http_impl.dart';
import 'package:flu/bean/http_result.dart';

abstract class IHttp {
  static IHttp _instance = HttpImpl();

  static set instance(IHttp instance) {
    _instance = instance;
  }

  static IHttp get instance => _instance;

  Future<List<BannerBean>> getBanner();

  Future<List<ArticleBean>> getTop();

  Future<List<ArticleBean>> getHomeList(int index);
}
