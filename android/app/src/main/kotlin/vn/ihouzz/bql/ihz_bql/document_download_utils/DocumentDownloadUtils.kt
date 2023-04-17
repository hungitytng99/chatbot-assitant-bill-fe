package vn.ihouzz.bql.ihz_bql.document_download_utils

import android.content.ContentValues
import android.content.Context
import android.net.Uri
import android.os.Build
import android.os.Environment
import android.provider.MediaStore
import java.io.BufferedInputStream
import java.io.File
import java.io.FileInputStream

object DocumentDownloadUtils {

    fun getPathFolderDownloads(context: Context): String? {
        return if (Build.VERSION.SDK_INT < Build.VERSION_CODES.Q) {
            val folderDownload =
                Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DOWNLOADS)
            if (!folderDownload.exists()) {
                folderDownload.mkdirs()
            }
            return folderDownload.path

        } else {
            context.getExternalFilesDir(Environment.DIRECTORY_DOWNLOADS)?.path
        }
    }

    fun copyFileToDownloads(context: Context, downloadedFile: File): Uri? {
        try {
            val resolver = context.contentResolver
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                val contentValues = ContentValues().apply {
                    put(
                        MediaStore.MediaColumns.DISPLAY_NAME,
                        downloadedFile.name
                    )
                }
                return resolver.insert(
                    MediaStore.Downloads.EXTERNAL_CONTENT_URI,
                    contentValues
                )?.also { downloadedUri ->
                    resolver.openOutputStream(downloadedUri)
                        .use { outputStream ->
                            val brr = ByteArray(1024)
                            var len: Int
                            val bufferedInputStream =
                                BufferedInputStream(
                                    FileInputStream(
                                        downloadedFile.absoluteFile
                                    )
                                )
                            while ((bufferedInputStream.read(brr, 0, brr.size)
                                    .also { len = it }) != -1
                            ) {
                                outputStream?.write(brr, 0, len)
                            }
                            outputStream?.flush()
                            bufferedInputStream.close()
                        }
                }
            }
        } catch (e: Exception) {

        }
        return null
    }

    fun deleteFileWhenCopySuccess(file: File): Boolean {
        if (!file.exists()) {
            return false;
        }
        return file.delete();
    }

}