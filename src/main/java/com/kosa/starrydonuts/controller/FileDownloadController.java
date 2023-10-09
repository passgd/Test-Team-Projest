package com.kosa.starrydonuts.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kosa.starrydonuts.domain.AttacheFileDTO;
import com.kosa.starrydonuts.service.AttacheFileService;

@Controller
public class FileDownloadController {
	private static String CURR_IMAGE_REPO_PATH = "C:\\file_repo";
	
	@Autowired
	AttacheFileService attacheFileService;
	

	@RequestMapping("/attacheFile/displayImg.do")
	protected void download(@RequestParam("fileNo") String fileNo,
			                 HttpServletResponse response) throws Exception {
		
		OutputStream out = response.getOutputStream();
		AttacheFileDTO attacheFile = attacheFileService.getAttacheFile(fileNo); 
		
		if (attacheFile != null) {
			String filePath = CURR_IMAGE_REPO_PATH + attacheFile.getFileNameReal();  
			File image = new File(filePath);
			
			int lastIndex = fileNo.lastIndexOf(".");
			String fileName = fileNo.substring(0, lastIndex);
			
			File thumbnail = new File(CURR_IMAGE_REPO_PATH+"\\"+"thumbnail"+"\\"+fileName+".png");
			
			FileInputStream in = new FileInputStream(thumbnail);
			
			byte[] buffer = new byte[1024 * 8];
			while (true) {
				int count = in.read(buffer); 
				if (count == -1) 
					break;
				out.write(buffer, 0, count);
			}
			in.close();
			
		}
		out.close();
	}
	
}
