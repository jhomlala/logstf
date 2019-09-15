package com.jhomlala.logstf

import android.content.BroadcastReceiver
import android.content.Context
import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.EventChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import android.content.Intent
import android.util.Log
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel


class MainActivity : FlutterActivity() {

    private val linksChannel = "com.jhomlala.logstf.link"


    fun getLogId(logUrl: String): String {
        val splits = logUrl.split("/")
        return splits.last()
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)

        MethodChannel(flutterView, linksChannel).setMethodCallHandler { p0, p1 ->
            if (p0.method == "getIntent") {
                val uri = intent.data
                if (uri != null) {
                    p1.success(getLogId(uri.toString()))
                } else {
                    p1.success("none")
                }
                intent = Intent()

            }
        }
    }
}
