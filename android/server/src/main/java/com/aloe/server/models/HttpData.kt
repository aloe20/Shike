package com.aloe.server.models

import kotlinx.serialization.Serializable

@Serializable
data class HttpBean<T>(val errorCode: Int = 0, val errorMsg: String = "", val data: T? = null)

@Serializable
data class BannerBean(val id: Int, val title: String, val imagePath: String, val url: String, val desc: String? = null)

@Serializable
data class TopBean(
    val id: Int,
    val superChapterId: Int,
    val realSuperChapterId: Int,
    val author: String,
    val chapterName: String,
    val title:String,
    val desc: String,
    val link: String,
    val niceDate: String,
    val niceShareDate: String,
    val superChapterName: String,
    val tags:List<TagBean>
)

@Serializable
data class TagBean(val name: String, val url: String)

val banners = mutableListOf(
    BannerBean(
        30,
        "我们支持订阅啦~",
        "https://www.wanandroid.com/blogimgs/42da12d8-de56-4439-b40c-eab66c227a4b.png",
        "https://www.wanandroid.com/blog/show/3352",
        "我们支持订阅啦~"
    ),
    BannerBean(
        6,
        "我们新增了一个常用导航Tab~",
        "https://www.wanandroid.com/blogimgs/62c1bd68-b5f3-4a3c-a649-7ca8c7dfabe6.png",
        "https://www.wanandroid.com/navi"
    ),
    BannerBean(
        10,
        "一起来做个App吧",
        "https://www.wanandroid.com/blogimgs/50c115c2-cf6c-4802-aa7b-a4334de444cd.png",
        "https://www.wanandroid.com/blog/show/2",
        "一起来做个App吧"
    )
)