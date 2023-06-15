/*
 * Copyright 2023 The Android Open Source Project
 *
 *   Licensed under the Apache License, Version 2.0 (the "License");
 *   you may not use this file except in compliance with the License.
 *   You may obtain a copy of the License at
 *
 *       https://www.apache.org/licenses/LICENSE-2.0
 *
 *   Unless required by applicable law or agreed to in writing, software
 *   distributed under the License is distributed on an "AS IS" BASIS,
 *   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *   See the License for the specific language governing permissions and
 *   limitations under the License.
 */

package com.aloe.android.web

import android.annotation.SuppressLint
import android.os.Build
import android.util.Log
import android.webkit.WebView
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.wrapContentSize
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.material3.TopAppBar
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.viewinterop.AndroidView
import androidx.core.view.postDelayed
import androidx.webkit.WebViewCompat
import androidx.webkit.WebViewFeature
import com.aloe.android.R
import com.aloe.android.main.LocalNav

@OptIn(ExperimentalMaterial3Api::class)
@SuppressLint("SetJavaScriptEnabled")
@Composable
fun WebLayout(url: String) {
    val controller = LocalNav.current
    Scaffold(topBar = {
        TopAppBar(title = { Text(text = "浏览网页") }, navigationIcon = {
            IconButton(onClick = { controller.popBackStack() }) {
                Icon(
                    painter = painterResource(id = R.drawable.ic_back),
                    contentDescription = ""
                )
            }
        })
    }) {
        Box(modifier = Modifier.padding(it)) {
            AndroidView(factory = { WebView(it) }, modifier = Modifier.fillMaxSize()) {
                with(it) {
                    settings.javaScriptEnabled = true
                    settings.userAgentString =
                        "Mozilla/5.0 (Linux; Android ${Build.VERSION.RELEASE}; ${Build.BRAND} Build/${Build.BOARD})"
                    if (WebViewFeature.isFeatureSupported(WebViewFeature.WEB_MESSAGE_LISTENER)) {
                        // 接收H5消息并回调结果给H5
                        WebViewCompat.addWebMessageListener(
                            this,
                            "bridge",
                            mutableSetOf("file://", "http://192.168.137.1:5173")
                        ) { _, message, _, _, replyProxy ->
                            Log.d("aloe", "收到H5发送的消息：${message.data}")
                            replyProxy.postMessage("I`m Android")
                        }
                    }
                    if (WebViewFeature.isFeatureSupported(WebViewFeature.POST_WEB_MESSAGE) && "http://192.168.137.1:5173" == url) {
                        postDelayed(1000L) {
                            val params = "12345"
                            // 发送消息给H5并接收H5回调结果
                            evaluateJavascript("javascript:receiveAndroidCallback($params)") { value ->
                                Log.d("aloe", "收到H5回调：$value")
                            }
                        }
                    }
                }
                it.takeUnless { url.isEmpty() }?.loadUrl(url)
            }
        }
    }

}
