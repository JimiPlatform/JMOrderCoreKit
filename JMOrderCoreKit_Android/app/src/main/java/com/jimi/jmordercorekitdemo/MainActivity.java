package com.jimi.jmordercorekitdemo;

import androidx.annotation.UiThread;
import androidx.appcompat.app.AppCompatActivity;

import android.Manifest;
import android.app.Activity;
import android.app.ActivityManager;
import android.content.Context;
import android.content.SharedPreferences;
import android.graphics.Bitmap;
import android.os.Bundle;
import android.os.Environment;
import android.os.Handler;
import android.os.Looper;
import android.text.Editable;
import android.text.TextUtils;
import android.text.TextWatcher;
import android.util.Log;
import android.view.KeyEvent;
import android.view.SurfaceView;
import android.view.View;
import android.view.inputmethod.InputMethodManager;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import com.eafy.zjlog.ZJLog;
import com.jimi.jmordercorekit.JMOrderCamera;
import com.jimi.jmordercorekit.JMOrderCameraRecvCmdListener;
import com.jimi.jmordercorekit.JMOrderCoreKit;
import com.jimi.jmordercorekit.JMOrderCoreKitServerListener;
import com.jimi.jmordercorekit.Listener.OnPlayStatusListener;
import com.jimi.jmordercorekit.Listener.OnPlaybackListener;
import com.jimi.jmordercorekit.Listener.OnPlaybackQueryListListener;
import com.jimi.jmordercorekit.Listener.OnRecordListener;
import com.jimi.jmordercorekit.Listener.OnSwitchCameraListener;
import com.jimi.jmordercorekit.Listener.OnTalkStatusListener;
import com.jimi.jmordercorekit.Listener.OnVersionListener;
import com.jimi.jmordercorekitdemo.utils.PermissionFragment;
import com.jimi.jmordercorekitdemo.utils.PermissionListener;
import com.jimi.jmordercorekitdemo.utils.PermissionUtil;
import com.jimi.jmsmartutils.device.JMDevice;
import com.jimi.jmsmartutils.system.JMError;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.File;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.List;
import java.util.TimeZone;

import static com.jimi.jmsmartmediaplayer.Talker.JMMediaNetworkTalkerListener.JM_MEDIA_TALK_STATUS_FAILED;
import static com.jimi.jmsmartmediaplayer.Talker.JMMediaNetworkTalkerListener.JM_MEDIA_TALK_STATUS_STOP;
import static com.jimi.jmsmartmediaplayer.Video.JMMediaNetworkPlayerListener.JM_MEDIA_PLAY_STATUS_FAILED;
import static com.jimi.jmsmartmediaplayer.Video.JMMediaNetworkPlayerListener.JM_MEDIA_RECORD_STATUS_FAILED;

public class MainActivity extends AppCompatActivity implements View.OnClickListener {

    private SurfaceView displaySurfaceView1;
    private SurfaceView displaySurfaceView2;
    private EditText accountEditText;
    private EditText passwordEditText;
    private EditText keyEditText;
    private EditText secretEditText;
    private EditText imeiEditText;
    private EditText serverEditText;
    private EditText playbackEditText;
    private EditText instructEditText;

    private JMOrderCoreKit mJMOrderCoreKit = null;
    private JMOrderCamera mJMOrderCamera1 = null;
    private JMOrderCamera mJMOrderCamera2 = null;
    private JMError mJMError;
    private boolean mCameraMute = false;
    private boolean mSupportMulCamera = false;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        initView();
        loadConfigData();
        initPermission();

        ZJLog.config.setSaveEnable(true);

        initOrderCoreKit();
    }

    private void initView() {
        displaySurfaceView1 = findViewById(R.id.displaySurfaceView1);
        displaySurfaceView2 = findViewById(R.id.displaySurfaceView2);
        accountEditText = findViewById(R.id.accountEditText);
        passwordEditText = findViewById(R.id.passwordEditText);
        keyEditText = findViewById(R.id.keyEditText);
        secretEditText = findViewById(R.id.secretEditText);
        imeiEditText = findViewById(R.id.imeiEditText);
        serverEditText = findViewById(R.id.serverEditText);
        playbackEditText = findViewById(R.id.playbackEditText);
        instructEditText = findViewById(R.id.instructEditText);

        accountEditText.addTextChangedListener(textWatcher);
        passwordEditText.addTextChangedListener(textWatcher);
        keyEditText.addTextChangedListener(textWatcher);
        secretEditText.addTextChangedListener(textWatcher);
        imeiEditText.addTextChangedListener(textWatcher);
        serverEditText.addTextChangedListener(textWatcher);

        findViewById(R.id.unmuteButton).setOnClickListener(this);
        findViewById(R.id.switchBtn).setOnClickListener(this);
        findViewById(R.id.startPlay1Btn).setOnClickListener(this);
        findViewById(R.id.stopPlay1Btn).setOnClickListener(this);
        findViewById(R.id.record1Btn).setOnClickListener(this);
        findViewById(R.id.snapshot1Btn).setOnClickListener(this);
        findViewById(R.id.startPlay2Btn).setOnClickListener(this);
        findViewById(R.id.stopPlay2Btn).setOnClickListener(this);
        findViewById(R.id.talkBtn).setOnClickListener(this);
        findViewById(R.id.unInitBtn).setOnClickListener(this);
        findViewById(R.id.playbackBtn).setOnClickListener(this);
        findViewById(R.id.queryBtn).setOnClickListener(this);
        findViewById(R.id.sendInstruct).setOnClickListener(this);
    }

    private void initPermission() {
        PermissionUtil permissionUtil = new PermissionUtil();
        permissionUtil.requestPermissions(this, new String[]{Manifest.permission.READ_PHONE_STATE, Manifest.permission.READ_EXTERNAL_STORAGE, Manifest.permission.WRITE_EXTERNAL_STORAGE, Manifest.permission.RECORD_AUDIO},
                new PermissionListener() {
                    @Override
                    public void onGranted() {
                    }

                    @Override
                    public void onDenied(List<String> deniedPermission) {
                    }

                    @Override
                    public void onShouldShowRationale(List<String> deniedPermission) {
                    }
                });
    }

    private void saveConfigData() {
        SharedPreferences sp = getSharedPreferences("kOrderCoreKitSettingDemoInfo", Context.MODE_PRIVATE);
        SharedPreferences.Editor editor = sp.edit();
        editor.putString("account", accountEditText.getText().toString());
        editor.putString("password", passwordEditText.getText().toString());
        editor.putString("key", keyEditText.getText().toString());
        editor.putString("secret", secretEditText.getText().toString());
        editor.putString("imei", imeiEditText.getText().toString());
        editor.putString("serverAdr", serverEditText.getText().toString());
        editor.commit();
    }


    private void loadConfigData() {
    }

    boolean bHint = true;
    private TextWatcher textWatcher = new TextWatcher() {

        @Override
        public void onTextChanged(CharSequence s, int start, int before, int count) {
        }

        @Override
        public void beforeTextChanged(CharSequence s, int start, int count, int after) {
        }

        @Override
        public void afterTextChanged(Editable s) {
        }
    };


    @Override
    public void onClick(View view) {
        hintKeyboard();
        switch (view.getId()) {
            case R.id.unmuteButton:
                if (hintInit(mJMOrderCamera1)) return;
                mCameraMute = !mCameraMute;
                ((Button) view).setText(mCameraMute ? "Mute" : "UnMute");
                mJMOrderCamera1.setMute(mCameraMute);
                break;
            case R.id.switchBtn:
                if (hintInit(mJMOrderCamera1)) return;
                mJMOrderCamera1.switchCamera(new OnSwitchCameraListener() {
                    @Override
                    public void onResult(boolean success, JMError error) {
                        mJMError = error;
                        if (!success) hintError();
                    }
                });
//                deinitOrderClientKit();
//                initOrderCoreKit();
                break;
            case R.id.startPlay1Btn:
                if (hintInit(mJMOrderCamera1)) return;
                mJMOrderCamera1.startPlay(new OnPlayStatusListener() {
                    @Override
                    public void onStatus(boolean success, JMError error) {
                        mJMError = error;
                        ZJLog.d("startPlay---->success:" + success + " errorCode:" + error.errCode + " errorMsg:" + error.errMsg);
                        if (!success) {
                            hintError();
                        }
                    }
                });
                break;
            case R.id.stopPlay1Btn:
                if (hintInit(mJMOrderCamera1)) return;
                mJMOrderCamera1.stopPlay();
                break;
            case R.id.record1Btn:
                if (hintInit(mJMOrderCamera1)) return;
                if (mJMOrderCamera1.isRecording()) {
                    ((Button) view).setText("Record");
                    mJMOrderCamera1.stopRecord();
                } else {
                    ((Button) view).setText("StopRecord");
                    String filePath = Environment.getExternalStorageDirectory().getAbsolutePath() + "/JMVideo";
                    File file = new File(filePath);
                    if (!file.exists()) {
                        file.mkdirs();
                    }
                    long time = System.currentTimeMillis() / 1000;
                    String savePath = filePath + "/video_" + time + ".mp4";
                    mJMOrderCamera1.startRecord(savePath, new OnRecordListener() {
                        @Override
                        public void onStatus(int status, String fileName, JMError error) {
                            if (status == JM_MEDIA_RECORD_STATUS_FAILED) hintError();
                        }
                    });
                }
                break;
            case R.id.snapshot1Btn:
                if (hintInit(mJMOrderCamera1)) return;
                String imagePath = null;
                Bitmap bitmap = mJMOrderCamera1.snapshot();
                if (bitmap != null) {
                    imagePath = saveBitmap(bitmap);
                }
                Toast.makeText(this, !TextUtils.isEmpty(imagePath) ? "图片保存成功" : "图片保存失败", Toast.LENGTH_SHORT).show();

                break;
            case R.id.startPlay2Btn:
                if (hintInit(mJMOrderCamera2)) return;
                mJMOrderCamera2.startPlay(new OnPlayStatusListener() {
                    @Override
                    public void onStatus(boolean success, JMError error) {

                    }
                });
                break;
            case R.id.stopPlay2Btn:
                if (hintInit(mJMOrderCamera1)) return;
                mJMOrderCamera1.switchCamera(new OnSwitchCameraListener() {
                    @Override
                    public void onResult(boolean success, JMError error) {
                        mJMError = error;
                        if (!success) hintError();
                    }
                });
                break;
            case R.id.talkBtn:
                if (hintInit(mJMOrderCamera1)) return;
                if (mJMOrderCamera1.isTalking()) {
                    mJMOrderCamera1.stopTalk();
                    ((Button) view).setText("Talk");
                } else {
                    ((Button) view).setText("Talking");
                    mJMOrderCamera1.startTalk(new OnTalkStatusListener() {
                        @Override
                        public void onStatus(int status, JMError error) {
                            mJMError = error;
                            ZJLog.d("StartTalk status:" + status + " Error:" + error.errCode + " errStr:" + error.errMsg);
                            if (status == JM_MEDIA_TALK_STATUS_FAILED || status == JM_MEDIA_TALK_STATUS_STOP) {
                                new Handler(Looper.getMainLooper()).post(new Runnable() {
                                    @Override
                                    public void run() {
                                        ((Button) findViewById(R.id.talkBtn)).setText("Talk");
                                        if (mJMError != null)
                                            Toast.makeText(getApplicationContext(), "Failed to talking[" + mJMError.errCode + "]:" + mJMError.errMsg, Toast.LENGTH_SHORT).show();
                                    }
                                });
                            }
                        }
                    });
                }
                break;
            case R.id.unInitBtn:
                if (JMOrderCoreKit.getSingleton().getServerListener() != null) {
                    ((Button) view).setText("Init");
                    deinitOrderClientKit();
                } else {
                    ((Button) view).setText("UnInit");
                    initOrderCoreKit();
                }
                break;

            case R.id.queryBtn:
                if (hintInit(mJMOrderCamera1)) return;
                Calendar cal = Calendar.getInstance();
                TimeZone tz = TimeZone.getTimeZone("GMT");
                cal.setTimeZone(tz);
                long time = cal.getTimeInMillis() / 1000;
                mJMOrderCamera1.playbackQueryList(time - 3600 * 4, time, new OnPlaybackQueryListListener() {
                    @Override
                    public void onStatus(boolean success, String fileListStr, JMError error) {
                        ZJLog.d("playbackQueryList:" + success + ",fileListStr:" + fileListStr);
                        if (success) {
                            JSONArray lists = null;
                            try {
                                lists = new JSONArray(fileListStr);
                            } catch (JSONException e) {
                                e.printStackTrace();
                            }
                            String str = "";
                            for (int i = 0; i < lists.length(); i++) {
                                str += lists.optString(i);
                                if (i != lists.length() - 1) {
                                    str += ",";
                                }
                            }
                            playbackEditText.setText(str);
                        }
                    }
                });
                break;

            case R.id.playbackBtn:
                if (hintInit(mJMOrderCamera1)) return;
                ArrayList<String> list = null;
                if (!playbackEditText.getText().toString().isEmpty()) {
                    String[] listStr = playbackEditText.getText().toString().split(",");
                    list = new ArrayList<>(Arrays.asList(listStr));
                } else {
                    list = new ArrayList();
                    list.add("2020_04_03_16_35_08_01.mp4");
                    list.add("2020_04_03_16_36_08_01.mp4");
                    list.add("2020_04_03_16_37_09_01.mp4");
                    list.add("2020_04_03_16_38_09_01.mp4");
                    list.add("2020_04_03_16_39_09_01.mp4");
                    list.add("2020_04_03_16_40_10_01.mp4");
                }

                mJMOrderCamera1.playback(list, true, new OnPlaybackListener() {
                    @Override
                    public void onStatus(boolean success, long statusCode, String fileName, JMError error) {
                        ZJLog.d("Playback success:" + success + " statusCode:" + statusCode + " fileName:" + fileName);
                        if (!success) {
                            hintError();
                        }
                    }
                });
                break;
            case R.id.sendInstruct:
//                JMOrderCoreKit.configUserInfo("A" + JMDevice.getIMEI(ActivityUtils.getTopActivity()));
//                JMOrderCoreKit.configTCPServer(NetworkUtils.getServerAddressByWifi(), 21100);
                JMOrderCoreKit.getSingleton().sendTrackCmdData(instructEditText.getText().toString().trim());
                break;
            default:
                break;
        }
    }

    public String saveBitmap(Bitmap bitmap) {
        if (bitmap != null) {
            String imageDir = Environment.getExternalStorageDirectory().getAbsolutePath() + "/JMPIC";
            File file = new File(imageDir);
            if (!file.exists()) {
                file.mkdirs();
            }
            long time = System.currentTimeMillis() / 1000;
            String savePath = imageDir + "/pic_" + time + ".jpg";
            File imageFile = new File(savePath);
            try {
                FileOutputStream fos = new FileOutputStream(imageFile);
                bitmap.compress(Bitmap.CompressFormat.JPEG, 100, fos);
                fos.flush();
                fos.close();
                return imageFile.getAbsolutePath();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return null;
    }

    private void hintError() {
        new Handler(Looper.getMainLooper()).post(new Runnable() {
            @Override
            public void run() {
                if (mJMError != null) {
                    Toast.makeText(getApplicationContext(), "Failed to operation[" + mJMError.errCode + "]:" + mJMError.errMsg, Toast.LENGTH_SHORT).show();
                } else {
                    ZJLog.e("This JMError is null !!!");
                }
            }
        });
    }

    private boolean hintInit(JMOrderCamera camera) {
        if (camera == null) {
            Toast.makeText(getApplicationContext(), "Please initialize first", Toast.LENGTH_SHORT).show();
            return true;
        }
        return false;
    }

    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {
        if (keyCode == KeyEvent.KEYCODE_BACK) {

            finish();
        }
        return false;
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        killAppProcess();
    }

    public void killAppProcess()
    {
        ActivityManager mActivityManager = (ActivityManager) getSystemService(Context.ACTIVITY_SERVICE);
        List<ActivityManager.RunningAppProcessInfo> mList = mActivityManager.getRunningAppProcesses();
        for (ActivityManager.RunningAppProcessInfo runningAppProcessInfo : mList)
        {
            if (runningAppProcessInfo.pid != android.os.Process.myPid())
            {
                android.os.Process.killProcess(runningAppProcessInfo.pid);
            }
        }
        android.os.Process.killProcess(android.os.Process.myPid());
        System.exit(0);
    }

    private void initOrderCoreKit() {
        if (JMOrderCoreKit.initialize() == 0) {

            JMOrderCoreKit.configDeveloper(keyEditText.getText().toString(), secretEditText.getText().toString(), accountEditText.getText().toString());
            if (!serverEditText.getText().toString().isEmpty()) {
//                JMOrderCoreKit.configTCPServer(NetworkUtils.getServerAddressByWifi(), 21100);
//                JMOrderCoreKit.configTCPServer(serverEditText.getText().toString(), 21100);
                JMOrderCoreKit.configServer(serverEditText.getText().toString());
            }

            JMOrderCoreKit.configUserInfo("A" + JMDevice.getIMEI(this));
            JMOrderCoreKit.getSingleton().setServerListener(mJMOrderCoreKitServerListener);
            JMOrderCoreKit.getSingleton().connect();

            if (mJMOrderCamera1 == null) {
                mJMOrderCamera1 = new JMOrderCamera(getApplicationContext(), imeiEditText.getText().toString(), 0);
                mJMOrderCamera1.setSslEnable(true);
                mJMOrderCamera1.attachGLMonitor(displaySurfaceView1);
            }
            if (mJMOrderCamera2 == null) {
                mJMOrderCamera2 = new JMOrderCamera(getApplicationContext(), imeiEditText.getText().toString(), 1);
                mJMOrderCamera2.attachGLMonitor(displaySurfaceView2);
                mJMOrderCamera2.setMute(true);
            }
        }
    }

    private void deinitOrderClientKit() {
        if (JMOrderCoreKit.deInitialize(getApplicationContext()) == 0) {
            if (mJMOrderCamera1 != null) {
                mJMOrderCamera1.release();
                mJMOrderCamera1.deattachMonitor();
                mJMOrderCamera1 = null;
            }
            if (mJMOrderCamera2 != null) {
                mJMOrderCamera2.release();
                mJMOrderCamera2.deattachMonitor();
                mJMOrderCamera2 = null;
            }
        }

        new Handler(Looper.getMainLooper()).post(new Runnable() {
            @Override
            public void run() {
                ((Button) findViewById(R.id.unInitBtn)).setText("Init");
            }
        });
    }


    private JMOrderCoreKitServerListener mJMOrderCoreKitServerListener = new JMOrderCoreKitServerListener() {

        @Override
        public void didJMOrderCoreKitWithError(JMError error) {
            ZJLog.d("didJMOrderCoreKitWithError->errorCode:" + error.errCode + " ,errStr:" + error.errMsg);
            mJMError = error;
            if (error.errCode != 0) {
                new Handler(Looper.getMainLooper()).post(new Runnable() {
                    @Override
                    public void run() {
                        Toast.makeText(getApplicationContext(), mJMError.errMsg, Toast.LENGTH_SHORT).show();
                    }
                });
            }
        }

        @Override
        public void didJMOrderCoreKitConnectWithStatus(int state) {
            ZJLog.d("didJMOrderCoreKitConnectWithStatus->state:" + state);
            if (state == JM_SERVER_CONNET_STATE_CONNECTED) {
                bHint = false;
                new Handler(Looper.getMainLooper()).post(new Runnable() {
                    @Override
                    public void run() {
                        Toast.makeText(getApplicationContext(), "Server connected successfully", Toast.LENGTH_SHORT).show();
                    }
                });
                JMOrderCoreKit.getSingleton().getVersion(imeiEditText.getText().toString(), new OnVersionListener() {
                    @Override
                    public void onResult(String imei, boolean success, String version, boolean supportMulCamera) {
                        if (success) {
                            mSupportMulCamera = supportMulCamera;
                            new Handler(Looper.getMainLooper()).post(new Runnable() {
                                @Override
                                public void run() {
                                    if (mSupportMulCamera) {    //设备支持多Camera同时播放
                                        displaySurfaceView2.bringToFront();
                                        if (mJMOrderCamera2 == null) {
                                            mJMOrderCamera2 = new JMOrderCamera(getApplicationContext(), imeiEditText.getText().toString(), 1);
                                            mJMOrderCamera2.attachGLMonitor(displaySurfaceView2);
                                            mJMOrderCamera2.setMute(true);
                                        }
                                    } else {
                                        displaySurfaceView2.setVisibility(View.GONE);
                                    }
                                }
                            });
                        }
                    }
                });
            } else if (state >= JM_SERVER_CONNET_STATE_FAILED) {
                new Handler(Looper.getMainLooper()).post(new Runnable() {
                    @Override
                    public void run() {
                        Toast.makeText(getApplicationContext(), "Failed to connect server!", Toast.LENGTH_SHORT).show();
                    }
                });
            }
        }

        @Override
        public void didJMOrderCoreKitReceiveDeviceData(int mode,String imei,final String data) {
            runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    Toast.makeText(MainActivity.this,data,Toast.LENGTH_SHORT).show();
                }
            });
            ZJLog.e("didJMOrderCoreKitReceiveDeviceData->data:" + data + "，imei : " + imei +
                    "，mode : " + mode);
        }
    };

    private void hintKeyboard() {
        InputMethodManager imm = (InputMethodManager) getSystemService(Context.INPUT_METHOD_SERVICE);
        if (imm.isActive() && getCurrentFocus() != null) {
            if (getCurrentFocus().getWindowToken() != null) {
                imm.hideSoftInputFromWindow(getCurrentFocus().getWindowToken(), InputMethodManager.HIDE_NOT_ALWAYS);
            }
        }
    }
}
