package com.jimi.jmordercorekitdemo.utils;

import android.Manifest;
import android.content.Context;
import android.content.pm.PackageManager;

import androidx.core.content.ContextCompat;
import androidx.fragment.app.FragmentActivity;
import androidx.fragment.app.FragmentManager;

public class PermissionUtil {

    private static final String TAG = PermissionUtil.class.getSimpleName();

    public PermissionUtil() {

    }

    private PermissionFragment getRxPermissionsFragment(FragmentActivity activity) {

        PermissionFragment fragment = (PermissionFragment) activity.getSupportFragmentManager().findFragmentByTag(TAG);
        boolean isNewInstance = fragment == null;
        if (isNewInstance) {
            fragment = new PermissionFragment();
            FragmentManager fragmentManager = activity.getSupportFragmentManager();
            fragmentManager
                    .beginTransaction()
                    .add(fragment, TAG)
                    .commit();
            fragmentManager.executePendingTransactions();
        }

        return fragment;
    }

    /**
     * 外部使用 申请权限
     * @param permissions 申请授权的权限
     * @param listener 授权回调的监听
     */
    public void requestPermissions(FragmentActivity activity ,String[] permissions, PermissionListener listener) {
        PermissionFragment fragment = getRxPermissionsFragment(activity);
        fragment.setListener(listener);
        fragment.requestPermissions(permissions);
    }

    /*是否有读取手机状态的权限*/
    public static boolean isReadPhontState(Context context) {
        return ContextCompat.checkSelfPermission(context, Manifest.permission.READ_PHONE_STATE)
                == PackageManager.PERMISSION_GRANTED;
    }

    /*是否有读取存储卡的权限*/
    public static boolean isReadExternalStorage(Context context) {
        return ContextCompat.checkSelfPermission(context, Manifest.permission.READ_EXTERNAL_STORAGE)
                == PackageManager.PERMISSION_GRANTED;
    }

    /*是否有写入存储卡的权限*/
    public static boolean isWriteExternalStorage(Context context) {
        return ContextCompat.checkSelfPermission(context, Manifest.permission.WRITE_EXTERNAL_STORAGE)
                == PackageManager.PERMISSION_GRANTED;
    }

    /*是否有麦克风权限的权限*/
    public static boolean isRecordAudio(Context context) {
        return ContextCompat.checkSelfPermission(context, Manifest.permission.RECORD_AUDIO)
                == PackageManager.PERMISSION_GRANTED;
    }


}
