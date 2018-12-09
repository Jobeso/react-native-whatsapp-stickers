
package com.jobeso.RNWhatsAppStickers;

import android.app.Activity;
import android.content.Intent;
import android.content.ActivityNotFoundException;
import android.content.Context;
import android.content.pm.ResolveInfo;
import android.util.Log;

import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.BaseActivityEventListener;
import com.facebook.react.bridge.ActivityEventListener;
import com.facebook.react.bridge.ReactMethod;

import java.lang.reflect.Field;
import java.util.HashMap;
import java.util.Map;

public class RNWhatsAppStickersModule extends ReactContextBaseJavaModule {
    public static final String EXTRA_STICKER_PACK_ID = "sticker_pack_id";
    public static final String EXTRA_STICKER_PACK_AUTHORITY = "sticker_pack_authority";
    public static final String EXTRA_STICKER_PACK_NAME = "sticker_pack_name";

    public static final int ADD_PACK = 200;

    private static final String E_ACTIVITY_DOES_NOT_EXIST = "E_ACTIVITY_DOES_NOT_EXIST";
    private static final String E_FAILED_TO_START_ACTIVITY = "E_ACTIVITY_DOES_NOT_EXIST";
    private static final String E_FAILED_ACTIVITY = "E_ACTIVITY_FAILED";
    private static final String E_RESULT_CANCELED = "E_RESULT_CANCELED";
    private static final String E_ADDING_STICKER_PACK = "E_ADDING_STICKER_PACK";

    private Promise RNWAPromise;

    private final ReactApplicationContext reactContext;
    private final ActivityEventListener mActivityEventListener = new BaseActivityEventListener() {
        @Override
        public void onActivityResult(Activity activity, int requestCode, int resultCode, Intent intent) {
            if (requestCode == ADD_PACK) {
                if (resultCode == Activity.RESULT_OK) {
                    RNWAPromise.resolve("RESULT_OK");
                    RNWAPromise = null;
                }

                if (resultCode == Activity.RESULT_FIRST_USER) {
                    RNWAPromise.resolve("RESULT_OK");
                    RNWAPromise = null;
                }

                if (resultCode == Activity.RESULT_CANCELED) {
                    RNWAPromise.reject(E_RESULT_CANCELED);
                    RNWAPromise = null;
                }
            }
        }
    };

    public RNWhatsAppStickersModule(ReactApplicationContext reactContext) {
        super(reactContext);

        // Add the listener for `onActivityResult`
        this.reactContext = reactContext;
        this.reactContext.addActivityEventListener(mActivityEventListener);
    }

    @Override
    public String getName() {
        return "RNWhatsAppStickers";
    }

    @ReactMethod
    public void test(Promise promise) {
        promise.resolve("");
    }

    public static String getContentProviderAuthority(Context context) {
        return context.getPackageName() + ".stickercontentprovider";
    }

    @ReactMethod
    public void send(String identifier, String stickerPackName, final Promise promise) {
        Activity currentActivity = getCurrentActivity();

        if (currentActivity == null) {
            promise.reject(E_ACTIVITY_DOES_NOT_EXIST, "Activity doesn't exist");
            return;
        }

        // Store the promise to resolve/reject when picker returns data
        RNWAPromise = promise;

        Intent intent = new Intent();
        intent.setAction("com.whatsapp.intent.action.ENABLE_STICKER_PACK");
        intent.putExtra(EXTRA_STICKER_PACK_ID, identifier);
        intent.putExtra(EXTRA_STICKER_PACK_AUTHORITY, getContentProviderAuthority(reactContext));
        intent.putExtra(EXTRA_STICKER_PACK_NAME, stickerPackName);

        try {
            currentActivity.startActivityForResult(intent, ADD_PACK);
        } catch (ActivityNotFoundException e) {
            RNWAPromise.reject(E_FAILED_TO_START_ACTIVITY, e);
            RNWAPromise = null;
        } catch (Exception e) {
            RNWAPromise.reject(E_FAILED_ACTIVITY, e);
            RNWAPromise = null;
        }
    }
}
