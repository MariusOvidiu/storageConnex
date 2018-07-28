package com.pulse.webtool.servlet;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;

import org.apache.log4j.Logger;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

public class DataController {
	private static Logger log = Logger.getLogger(DataController.class);

	public static void main(String[] args) {
		Gson gson = new GsonBuilder().create();

	}

	public static String[] readFromFile() {
		String tempFolderPath = "webapps\\Webtool\\temp\\";
		String metaDataName = "metaData.txt";
		String dataName = "data.txt";
		String[] tableData = {"",""};
		// This will reference one line at a time
		String line = null;

		try {
			// FileReader reads text files in the default encoding.
			FileReader fileReader = new FileReader(tempFolderPath + metaDataName);

			// Always wrap FileReader in BufferedReader.
			BufferedReader bufferedReader = new BufferedReader(fileReader);

			while ((line = bufferedReader.readLine()) != null) {
				tableData[0] = tableData[0] + line;
			}

			// Always close files.
			bufferedReader.close();
			fileReader.close();

			fileReader = new FileReader(tempFolderPath + dataName);

			// Always wrap FileReader in BufferedReader.
			bufferedReader = new BufferedReader(fileReader);

			while ((line = bufferedReader.readLine()) != null) {
				tableData[1] = tableData[1] + line;
			}
			// Always close files.
			bufferedReader.close();
			fileReader.close();

			return tableData;

		} catch (Exception e) {
			log.error("readFromFile Exception", e);
			// Or we could just do this:
			// ex.printStackTrace();

		}
		return null;
	}

	public static void saveToFile(String metaData, String data) {

		// The name of the file to open.
		String tempFolderPath = "webapps\\Webtool\\temp\\";
		String metaDataName = "metaData.txt";
		String dataName = "data.txt";

		try {
			// Assume default encoding.
			FileWriter fileWriter = new FileWriter(tempFolderPath + metaDataName);

			// Always wrap FileWriter in BufferedWriter.
			BufferedWriter bufferedWriter = new BufferedWriter(fileWriter);

			// Note that write() does not automatically
			// append a newline character.
			bufferedWriter.write(metaData);

			// Always close files.
			bufferedWriter.close();
			fileWriter.close();

			fileWriter = new FileWriter(tempFolderPath + dataName);

			// Always wrap FileWriter in BufferedWriter.
			bufferedWriter = new BufferedWriter(fileWriter);
			bufferedWriter.write(data);

			// Always close files.
			bufferedWriter.close();
			fileWriter.close();

		} catch (Exception e) {
			log.error("saveToFile Exception", e);
			// Or we could just do this:
			// ex.printStackTrace();

		}
	}
}