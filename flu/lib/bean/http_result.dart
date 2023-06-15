import 'package:json_annotation/json_annotation.dart';

part 'http_result.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class HttpResult<T> {
  int errorCode;
  String errorMsg;
  T data;

  HttpResult(this.errorCode, this.errorMsg, this.data);

  factory HttpResult.fromJson(
          Map<String, dynamic> json, T Function(dynamic json) fromJson) =>
      _$HttpResultFromJson(json, fromJson);

  Map<String, dynamic> toJson(Object? Function(T value) toJson) =>
      _$HttpResultToJson(this, toJson);
}

@JsonSerializable()
class BannerBean {
  int id;
  String title;
  String? desc;
  String imagePath;
  String url;

  BannerBean(this.id, this.title, this.desc, this.imagePath, this.url);

  factory BannerBean.fromJson(Map<String, dynamic> json) =>
      _$BannerBeanFromJson(json);

  Map<String, dynamic> toJson() => _$BannerBeanToJson(this);
}

@JsonSerializable()
class ArticleBean {
  int id;
  int superChapterId;
  int realSuperChapterId;
  String author;
  String chapterName;
  String title;
  String desc;
  String link;
  String niceDate;
  String niceShareDate;
  String superChapterName;
  List<TagBean> tags;

  ArticleBean(
      this.id,
      this.superChapterId,
      this.realSuperChapterId,
      this.author,
      this.chapterName,
      this.title,
      this.desc,
      this.link,
      this.niceDate,
      this.niceShareDate,
      this.superChapterName,
      this.tags);

  factory ArticleBean.fromJson(Map<String, dynamic> json) =>
      _$ArticleBeanFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleBeanToJson(this);
}

@JsonSerializable()
class TagBean {
  String name;
  String url;

  TagBean(this.name, this.url);

  factory TagBean.fromJson(Map<String, dynamic> json) =>
      _$TagBeanFromJson(json);

  Map<String, dynamic> toJson() => _$TagBeanToJson(this);
}
