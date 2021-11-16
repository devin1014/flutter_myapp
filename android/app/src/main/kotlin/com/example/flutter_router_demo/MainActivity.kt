package com.example.flutter_router_demo

import com.example.flutter_router_demo.Pigeon.Book
import com.example.flutter_router_demo.Pigeon.BookApi
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        BookApi.setup(flutterEngine.dartExecutor.binaryMessenger, object : BookApi {
            override fun search(key: String?): MutableList<Book> {
                val list = mutableListOf<Book>()
                (0..10).forEach { index ->
                    list.add(Book().apply {
                        title = "ABC_$index"
                        author = "lw"
                    })
                }
                return list
            }
        })
    }
}