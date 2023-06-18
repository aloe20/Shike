package com.aloe.server.routes

import com.aloe.server.models.HttpBean
import com.aloe.server.models.banners
import io.ktor.http.HttpStatusCode
import io.ktor.server.application.call
import io.ktor.server.response.respond
import io.ktor.server.response.respondText
import io.ktor.server.routing.Route
import io.ktor.server.routing.get
import io.ktor.server.routing.route

fun Route.androidRouting() {
    route("banner/json") {
        get {
            call.respond(
                HttpBean(
                    data = banners
                )
            )
        }
    }
    route("article/top/json"){
        get {
            call.respondText(text ="""
                {"data":[{"adminAdd":false,"apkLink":"","audit":1,"author":"xiaoyang","canEdit":false,"chapterId":440,"chapterName":"官方","collect":false,"courseId":13,"desc":"<p>更近遇到一类反馈，更终排查定位到是存储在应用私有cache目录（data/data/包名/cache）的一些文件被删除了（这里是文件夹内，部分文件被删除）；</p>\r\n<p>问题来了：</p>\r\n<p>系统对于cache目录的清理策略是怎么样的？在高版本上有什么策略调整吗？</p>","descMd":"","envelopePic":"","fresh":false,"host":"","id":26673,"isAdminAdd":false,"link":"https://wanandroid.com/wenda/show/26673","niceDate":"2天前","niceShareDate":"2天前","origin":"","prefix":"","projectLink":"","publishTime":1686712973000,"realSuperChapterId":439,"selfVisible":0,"shareDate":1686712956000,"shareUser":"","superChapterId":440,"superChapterName":"问答","tags":[{"name":"本站发布","url":"/article/list/0?cid=440"},{"name":"问答","url":"/wenda"}],"title":"每日一问 | 系统会随意删除App的缓存文件？","type":1,"userId":2,"visible":1,"zan":0},{"adminAdd":false,"apkLink":"","audit":1,"author":"xiaoyang","canEdit":false,"chapterId":440,"chapterName":"官方","collect":false,"courseId":13,"desc":"<p>在framework的代码中，经常看到如下的权限检测的代码：</p>\r\n<p><img src=\"https://wanandroid.com/blogimgs/af042353-c7c6-4f29-a988-3ad9b369964d.png\" alt=\"q1.png\" /></p>\r\n<p><img src=\"https://wanandroid.com/blogimgs/01fdb9cf-6f44-48bf-aa48-0cd527bfebd0.png\" alt=\"q2.png\" /></p>\r\n<p>Binder.getCallingUid()字面理解是获取调用方的uid，但是这个代码是目标进程调用的，如何通过一个静态方法调用，就拿到调用方的uid呢？</p>","descMd":"","envelopePic":"","fresh":false,"host":"","id":26624,"isAdminAdd":false,"link":"https://wanandroid.com/wenda/show/26624","niceDate":"2023-06-07 21:01","niceShareDate":"2023-06-07 21:01","origin":"","prefix":"","projectLink":"","publishTime":1686142904000,"realSuperChapterId":439,"selfVisible":0,"shareDate":1686142876000,"shareUser":"","superChapterId":440,"superChapterName":"问答","tags":[{"name":"本站发布","url":"/article/list/0?cid=440"},{"name":"问答","url":"/wenda"}],"title":"每日一问 | Binder是如何做到跨进程权限控制的？","type":1,"userId":2,"visible":1,"zan":1},{"adminAdd":false,"apkLink":"","audit":1,"author":"xiaoyang","canEdit":false,"chapterId":440,"chapterName":"官方","collect":false,"courseId":13,"desc":"<pre><code>package org.example;\r\n\r\npublic class ParentJava {\r\n    public String name;\r\n}\r\n\r\n import org.example.ParentJava\r\n\r\nclass Child(val name: String): ParentJava()\r\n\r\nfun main() {\r\n    Child(&quot;&quot;).name\r\n}\r\n</code></pre><p>如上代码，运行闪退。</p>\r\n<p>问：为什么？</p>\r\n<p>问题来源于<a href=\"https://www.wanandroid.com/wenda/show/8857?fid=225&amp;date=2023_05_31_17_12_04&amp;message=package%20or#msg_id2773\">xujiafeng</a></p>","descMd":"","envelopePic":"","fresh":false,"host":"","id":26578,"isAdminAdd":false,"link":"https://www.wanandroid.com/wenda/show/26578","niceDate":"2023-05-31 21:20","niceShareDate":"2023-05-31 21:19","origin":"","prefix":"","projectLink":"","publishTime":1685539214000,"realSuperChapterId":439,"selfVisible":0,"shareDate":1685539198000,"shareUser":"","superChapterId":440,"superChapterName":"问答","tags":[{"name":"本站发布","url":"/article/list/0?cid=440"},{"name":"问答","url":"/wenda"}],"title":"每日一问 | Java 系列，奇怪的闪退？","type":1,"userId":2,"visible":1,"zan":0},{"adminAdd":false,"apkLink":"","audit":1,"author":"xiaoyang","canEdit":false,"chapterId":440,"chapterName":"官方","collect":false,"courseId":13,"desc":"<p>当我们递归调用Java方法时，很可能会出现StackOverflowError，我们会认为此时栈内存溢出了，那么这个栈内存溢出虚拟机是如何检测的呢？</p>\r\n<p>是累加分配的内存与栈大小进行比较，还是有更好的方式呢？</p>","descMd":"","envelopePic":"","fresh":false,"host":"","id":26503,"isAdminAdd":false,"link":"https://wanandroid.com/wenda/show/26503","niceDate":"2023-05-24 17:35","niceShareDate":"2023-05-24 17:30","origin":"","prefix":"","projectLink":"","publishTime":1684920924000,"realSuperChapterId":439,"selfVisible":0,"shareDate":1684920617000,"shareUser":"","superChapterId":440,"superChapterName":"问答","tags":[{"name":"本站发布","url":"/article/list/0?cid=440"},{"name":"问答","url":"/wenda"}],"title":"每日一问  | Java线程栈的栈溢出（StackOverflowError）是如何检测的？","type":1,"userId":2,"visible":1,"zan":3}],"errorCode":0,"errorMsg":""}
            """.trimIndent(), status = HttpStatusCode.OK)
        }
    }
}