package com.aloe.server.plugins

import com.aloe.server.models.Article
import com.aloe.server.models.articles
import com.aloe.server.routes.androidRouting
import com.aloe.server.routes.customerRouting
import io.ktor.server.application.Application
import io.ktor.server.application.call
import io.ktor.server.application.install
import io.ktor.server.freemarker.FreeMarkerContent
import io.ktor.server.http.content.staticResources
import io.ktor.server.request.receiveParameters
import io.ktor.server.response.respond
import io.ktor.server.response.respondRedirect
import io.ktor.server.response.respondText
import io.ktor.server.routing.get
import io.ktor.server.routing.post
import io.ktor.server.routing.route
import io.ktor.server.routing.routing
import io.ktor.server.util.getOrFail

fun Application.configureRouting() {
    routing {
        staticResources("/page", "static")
        androidRouting()
        customerRouting()
        route("articles") {
            get {
                call.respond(FreeMarkerContent("articles.ftl", mapOf("articles" to articles)))
            }
        }
        get("/") {
            call.respond(FreeMarkerContent("index.html", model = null))
        }
        get("/articles") {
            call.respondRedirect("articles")
        }
        get("new") {
            call.respond(FreeMarkerContent("new.ftl", model = null))
        }
        post {
            val formParameters = call.receiveParameters()
            val title = formParameters.getOrFail("title")
            val body = formParameters.getOrFail("body")
            val newEntry = Article.newEntry(title, body)
            articles.add(newEntry)
            call.respondRedirect("/articles/${newEntry.id}")
        }
    }
}