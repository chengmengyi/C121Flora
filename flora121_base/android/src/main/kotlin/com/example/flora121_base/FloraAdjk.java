package com.example.flora121_base;

import android.os.Handler;
import android.os.Message;
import androidx.annotation.Keep;

@Keep
public class FloraAdjk extends Handler {
    @Keep
    public FloraAdjk() {

    }
    @Keep
    @Override
    public void handleMessage(Message message) {
        int r0 = message.what;
        FloraMkfei.FloraCmfjr(r0);
    }
}

