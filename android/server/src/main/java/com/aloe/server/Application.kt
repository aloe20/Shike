package com.aloe.server

import com.aloe.server.plugins.configureCors
import com.aloe.server.plugins.configureRouting
import com.aloe.server.plugins.configureSerialization
import com.aloe.server.plugins.configureSockets
import com.aloe.server.plugins.configureTemplating
import io.ktor.server.application.Application
import io.ktor.server.netty.EngineMain

fun main(args: Array<String>): Unit = EngineMain.main(args)

fun Application.module() {
    configureCors()
    configureRouting()
    configureSockets()
    configureTemplating()
    configureSerialization()
}
