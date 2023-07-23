package com.tech.blog.helper;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;

public class Helper {

    public static boolean deleteFile(String path) {
        boolean isFileDeleted = false;

        try {
            File file = new File(path);

            isFileDeleted = file.delete();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return isFileDeleted;
    }

    public static boolean saveFile(InputStream is, String path) {
        boolean isFileSaved = false;

        try {
            byte b[] = new byte[is.available()];
            is.read(b);

            FileOutputStream fos = new FileOutputStream(path);
            fos.write(b);
            fos.flush();
            fos.close();

            isFileSaved = true;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return isFileSaved;
    }
}
