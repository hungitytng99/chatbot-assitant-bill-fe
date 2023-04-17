package vn.ihouzz.bql.ihz_bql

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import vn.ihouzz.bql.ihz_bql.document_download_utils.DocumentDownloadUtils
import java.io.File

class MainActivity : FlutterActivity() {

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "path_folder_download_plugin_flutter"
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "getPathFolderDownload" ->
                    result.success(DocumentDownloadUtils.getPathFolderDownloads(context))
                "copyFileToDownload" -> {
                    val path = call.argument<String>("documentPath")
                    path?.let {
                        DocumentDownloadUtils.copyFileToDownloads(context, File(path))?.let {
                            result.success(
                                DocumentDownloadUtils.deleteFileWhenCopySuccess(File(path))
                            )
                        }
                    }
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }

}
