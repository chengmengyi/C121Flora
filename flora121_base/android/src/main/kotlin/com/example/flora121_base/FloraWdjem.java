package com.example.flora121_base;

import android.webkit.WebResourceRequest;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import androidx.annotation.Keep;
import android.util.Log;

@Keep
public class FloraWdjem extends WebViewClient {
    @Keep
    @Override
    public void onPageStarted(WebView view, String url, android.graphics.Bitmap favicon) {
        super.onPageStarted(view, url, favicon);
        Log.e("qwer","kk===="+url);
    }
    @Keep
    @Override
    public void onPageFinished(WebView view, String url) {
        super.onPageFinished(view, url);
    }
}
