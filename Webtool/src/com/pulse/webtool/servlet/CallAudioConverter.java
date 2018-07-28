package com.pulse.webtool.servlet;

import java.io.File;
import java.nio.file.Paths;

import org.apache.log4j.Logger;

public class CallAudioConverter {
	public static String exePath = "C:\\Data\\soxformat\\sox.exe";
	private Process process;
	private static boolean ifvox = true;
	private static Logger log = Logger.getLogger(GenerateHTML.class);
	
	public CallAudioConverter(String params) {
		// TODO Auto-generated constructor stub

		try {
			// wav
			/*
			 * process = new ProcessBuilder( exePath, arg1,arg1_1, arg2,arg2_1, arg3,arg3_1,
			 * arg4,arg4_1,"-w").start(); //vox
			 */

			// process = new ProcessBuilder(exePath, arg1, arg1_1, arg2, arg2_1,
			// arg3, arg3_1, arg4, arg4_1, "-w").start(); wav
			String[] args = params.split("~");

			process = new ProcessBuilder(args).start(); // vox

		} catch (Exception e) {
			// TODO Auto-generated catch block
			log.error("CallAudioConverter Error", e);
		}
	}

	boolean isRunning() {
		try {
			process.exitValue();
			return false;
		} catch (Exception e) {
			return true;
		}
	}

	public static void convertAudio(String fileName) {

		try {
			log.debug("convertAudio:" + fileName);
			log.debug("currentWD:" + Paths.get(".").toAbsolutePath().normalize().toString());
			// TODO Auto-generated constructor stub
			String fileNameWithouExtention = fileName.split("\\.")[0];
			String tempFolderPath="webapps\\Webtool\\temp\\";
			String source = tempFolderPath+ fileName;

			String dest = tempFolderPath + fileNameWithouExtention + "2.wav";

			String dest2 = tempFolderPath + fileNameWithouExtention + ".vox";

			String params = "-r~8000~-c~1~-e~u-law";
			CallAudioConverter ac = new CallAudioConverter(exePath + "~" + source + "~" + params + "~" + dest);
			while (ac.isRunning()) {

				try {
					Thread.sleep(100);
				} catch (InterruptedException e) {
					// TODO Auto-generated catch block
					log.error("convertAudio Error", e);
				}
			}
			File myFile = new File(dest);
			File myFile2 = new File(dest2);
			boolean b = myFile.renameTo(myFile2);
			if (!b) {
				log.error("rename" + myFile.getName() + " to" + myFile2.getName() + " Error maybe exist");
				if (myFile2.exists()) {
					myFile2.delete();
				}
				myFile.renameTo(myFile2);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			log.error("convertAudio Error", e);
		}
	}

	public static void main(String[] args) {

		String source = "C:\\Program Files\\Apache Software Foundation\\Tomcat 7.0\\webapps\\Webtool\\temp\\"
				+ "myrecordingtest.wav";

		String dest = "C:\\Program Files\\Apache Software Foundation\\Tomcat 7.0\\webapps\\Webtool\\temp\\"
				+ "myrecordingtest2.wav";

		String dest2 = "C:\\Program Files\\Apache Software Foundation\\Tomcat 7.0\\webapps\\Webtool\\temp\\"
				+ "myrecordingtest.vox";

		String params = "-r~8000~-c~1~-e~u-law";
		CallAudioConverter ac = new CallAudioConverter(exePath + "~" + source + "~" + params + "~" + dest);
		while (ac.isRunning()) {

			try {
				Thread.sleep(100);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				log.error("convertAudio Error", e);
			}
		}
		File myFile = new File(dest);
		File myFile2 = new File(dest2);
		myFile.renameTo(myFile2);

	}
}
