package com.aloe.android.flutter

import android.annotation.SuppressLint
import android.app.Activity
import android.content.Context
import android.content.Intent
import androidx.compose.runtime.Composable
import androidx.compose.ui.viewinterop.AndroidView
import androidx.lifecycle.DefaultLifecycleObserver
import androidx.lifecycle.LifecycleOwner
import androidx.lifecycle.findViewTreeLifecycleOwner
import androidx.navigation.NavHostController
import io.flutter.embedding.android.ExclusiveAppComponent
import io.flutter.embedding.android.FlutterView
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.FlutterEngineGroup
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.plugin.platform.PlatformPlugin

@Composable
fun FlutterLayout(route: String? = null) {
    AndroidView(factory = { FluLayout(it) }) { view ->
        view.loadPage(route)
    }
}

@SuppressLint("VisibleForTests")
class FluLayout(context: Context) : FlutterView(context) {
    private var platformPlugin: PlatformPlugin? = null

    private val observer = object : DefaultLifecycleObserver {

        override fun onResume(owner: LifecycleOwner) {
            attachedFlutterEngine?.lifecycleChannel?.appIsResumed()
            platformPlugin?.updateSystemUiOverlays()
        }

        override fun onPause(owner: LifecycleOwner) {
            attachedFlutterEngine?.lifecycleChannel?.appIsInactive()
        }

        override fun onStop(owner: LifecycleOwner) {
            attachedFlutterEngine?.lifecycleChannel?.appIsPaused()
        }

        override fun onDestroy(owner: LifecycleOwner) {
            attachedFlutterEngine?.lifecycleChannel?.appIsDetached()
        }
    }

    override fun onAttachedToWindow() {
        super.onAttachedToWindow()
        attachedFlutterEngine?.also { engine ->
            engine.plugins.add(AppPlugin {
                when (it.method) {
                    "navigation" -> {
                        when(it.argument<String>("pageName")){
                            "web"->{
                                val url = it.argument<String>("url")
                                val nav = (context as Activity).window.decorView.getTag(androidx.navigation.R.id.nav_controller_view_tag) as NavHostController
                                nav.navigate("web?url=$url")
                            }
                        }
                    }
                }
            })
            platformPlugin = PlatformPlugin(context as Activity, engine.platformChannel)
            findViewTreeLifecycleOwner()?.also { owner ->
                engine.activityControlSurface.attachToActivity(object :
                    ExclusiveAppComponent<Activity> {
                    override fun detachFromFlutterEngine() {
                        this@FluLayout.detachFromFlutterEngine()
                    }

                    override fun getAppComponent(): Activity = context as Activity
                }, owner.lifecycle)
                owner.lifecycle.addObserver(observer)
            }
        }
    }

    override fun onDetachedFromWindow() {
        super.onDetachedFromWindow()
        findViewTreeLifecycleOwner()?.also {
            attachedFlutterEngine?.also { engine->
                engine.plugins.remove(AppPlugin::class.java)
                engine.activityControlSurface.detachFromActivity()
                engine.lifecycleChannel.appIsDetached()
            }
            it.lifecycle.removeObserver(observer)
            platformPlugin?.destroy()
            platformPlugin = null
            detachFromFlutterEngine()
        }
    }

    fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray
    ) {
        attachedFlutterEngine?.activityControlSurface?.onRequestPermissionsResult(
            requestCode,
            permissions,
            grantResults
        )
    }

    fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        attachedFlutterEngine?.activityControlSurface?.onActivityResult(
            requestCode,
            resultCode,
            data
        )
    }

    fun onUserLeaveHint() {
        attachedFlutterEngine?.activityControlSurface?.onUserLeaveHint()
    }

    fun loadPage(route: String? = null) {
        attachToFlutterEngine(
            getEngine(context, "main", route)
        )
    }

    companion object {
        private lateinit var group: FlutterEngineGroup
        fun initFlutter(context: Context) {
            group = FlutterEngineGroup(context)
        }

        fun getEngine(ctx: Context, engineId: String, route: String? = null): FlutterEngine =
            FlutterEngineCache.getInstance().get(engineId) ?: group.createAndRunEngine(
                ctx,
                DartExecutor.DartEntrypoint.createDefault(),
                route
            ).also {
                FlutterEngineCache.getInstance().put(engineId, it)
            }
    }
}