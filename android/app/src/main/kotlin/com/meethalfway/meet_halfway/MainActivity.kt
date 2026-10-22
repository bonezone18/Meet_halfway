package com.meethalfway.meet_halfway

import android.content.pm.PackageManager
import android.content.pm.Signature
import android.os.Build
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.security.MessageDigest

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "signingCertSha1" -> result.success(signingCertSha1())
                    else -> result.notImplemented()
                }
            }
    }

    /**
     * SHA-1 of this app's signing certificate as uppercase hex without
     * colons. Google APIs need it (as `X-Android-Cert`) to accept REST calls
     * made with an API key restricted to Android apps.
     */
    private fun signingCertSha1(): String? {
        return try {
            val signature = currentSignature() ?: return null
            MessageDigest.getInstance("SHA-1")
                .digest(signature.toByteArray())
                .joinToString("") { byte -> "%02X".format(byte) }
        } catch (e: Exception) {
            null
        }
    }

    @Suppress("DEPRECATION")
    private fun currentSignature(): Signature? {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
            val info = packageManager.getPackageInfo(
                packageName,
                PackageManager.GET_SIGNING_CERTIFICATES,
            )
            val signingInfo = info.signingInfo ?: return null
            return if (signingInfo.hasMultipleSigners()) {
                signingInfo.apkContentsSigners?.firstOrNull()
            } else {
                signingInfo.signingCertificateHistory?.lastOrNull()
            }
        }
        return packageManager
            .getPackageInfo(packageName, PackageManager.GET_SIGNATURES)
            .signatures
            ?.firstOrNull()
    }

    private companion object {
        const val CHANNEL = "meet_halfway/app_identity"
    }
}
