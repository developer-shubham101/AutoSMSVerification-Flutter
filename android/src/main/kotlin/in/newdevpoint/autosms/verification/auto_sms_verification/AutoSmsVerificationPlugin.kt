package `in`.newdevpoint.autosms.verification.auto_sms_verification

import android.content.Context
import android.content.IntentFilter
import android.util.Log
import androidx.annotation.NonNull
import com.google.android.gms.auth.api.phone.SmsRetriever

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** AutoSmsVerificationPlugin */
class AutoSmsVerificationPlugin : FlutterPlugin, MethodCallHandler, MySmsListener {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel

    private var mResult: Result? = null
    private var receiver: SmsBroadcastReceiver? = null
    private var alreadyCalledSmsRetrieve = false
    private lateinit var context: Context

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "auto_sms_verification")
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "appSignature" -> {
                val signature = AppSignatureHelper(this.context).getAppSignatures()[0]
                result.success(signature)
            }
            "startListening" -> {
                this.mResult = result
                receiver = SmsBroadcastReceiver()
                startListening()

            }
            "stopListening" -> {
                alreadyCalledSmsRetrieve = false
                unregister()
            }
            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    private fun startListening() {
        val client = SmsRetriever.getClient(this.context /* context */)
        val task = client.startSmsRetriever()
        task.addOnSuccessListener {
            // Successfully started retriever, expect broadcast intent
            Log.e(javaClass::getSimpleName.name, "task started")
            receiver?.setSmsListener(this)
            this.context.registerReceiver(
                receiver,
                IntentFilter(SmsRetriever.SMS_RETRIEVED_ACTION)
            )
        }
    }

    private fun unregister() {
        this.context.unregisterReceiver(receiver)
    }

    override fun onOtpReceived(message: String?) {

        message?.let {
            if (!alreadyCalledSmsRetrieve) {
                mResult?.success(it)
                alreadyCalledSmsRetrieve = true
            }
        }

    }

    override fun onOtpTimeout() {

    }
}
