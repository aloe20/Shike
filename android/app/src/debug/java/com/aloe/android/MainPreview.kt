package com.aloe.android

import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.tooling.preview.Preview

@Preview(showBackground = true)
@Composable
fun GreetingPreview() {
    AndroidTheme {
        Text(text = "Android")
    }
}