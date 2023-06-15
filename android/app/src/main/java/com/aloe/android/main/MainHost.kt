package com.aloe.android.main

import android.app.Activity
import android.util.Log
import androidx.compose.runtime.Composable
import androidx.compose.runtime.CompositionLocalProvider
import androidx.compose.runtime.compositionLocalOf
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.platform.LocalView
import androidx.navigation.NavHostController
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import androidx.navigation.navArgument
import com.aloe.android.flutter.FlutterLayout
import com.aloe.android.web.WebLayout

val LocalNav = compositionLocalOf<NavHostController> { error("no provider value") }

@Composable
fun MainHost() {
    val nav = rememberNavController()
    (LocalContext.current as Activity).window.decorView.setTag(androidx.navigation.R.id.nav_controller_view_tag, nav)
    CompositionLocalProvider(LocalNav provides nav) {
        NavHost(
            navController = LocalNav.current,
            startDestination = "flutter",
        ) {
            composable("flutter") { FlutterLayout() }
            composable(
                "web?url={url}",
                arguments = listOf(navArgument("url") { defaultValue = "" }),
            ) {
                WebLayout(url = it.arguments?.getString("url") ?: "")
            }
        }
    }
}