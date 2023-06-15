package com.aloe.server.routes

import com.aloe.server.models.HttpBean
import com.aloe.server.models.banners
import io.ktor.server.application.call
import io.ktor.server.response.respond
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

        }
    }
}