package org.codehows.task;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import org.codehows.domain.BoardAttachVO;
import org.codehows.mapper.BoardAttachMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Component
public class FileCheckTask {
	
	@Setter(onMethod_ = { @Autowired })
	private BoardAttachMapper attachMapper;
	
	private String getFolderYesterDay() {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Calendar cal = Calendar.getInstance();
		
		cal.add(Calendar.DATE, -1);
		
		String str = sdf.format(cal.getTime());
		
		return str.replace("-", File.separator);
		
	}
	
	@Scheduled(cron="0 0 2 * * *") // corn 뒤에 오는 0 0 2 * * * (*) 는 초, 분, 시간, 일, 월, 주, (년) 을 의미한다. 해당 시간이 될때마다 실행한다. 지금은 새벽 2시에 실행된다.
	public void checkFiles() throws Exception {
		
		log.warn("File Check Task run..................");
		
		log.warn(new Date());
		
		// file list in database
		List<BoardAttachVO> fileList = attachMapper.getOldFiles();
		
		// ready for check file in directory with database file list
		List<Path> fileListPaths = fileList.stream()
			.map(vo -> Paths.get("C:\\upload", vo.getUploadPath(), vo.getUuid() + "_" + vo.getFileName()))
			.collect(Collectors.toList());
		
		// image file has thumnail file
		fileList.stream().filter(vo -> vo.isFileType() == true)
			.map(vo -> Paths.get("C:\\upload", vo.getUploadPath(), "s_" + vo.getUuid() + "_" + vo.getFileName()))
			.forEach(p -> fileListPaths.add(p));
		
		log.warn("================================================");
		
		fileListPaths.forEach(p -> log.warn(p));
		
		// file in yesterday directory
		File targetDir = Paths.get("C:\\upload", getFolderYesterDay()).toFile();
		
		File[] removeFiles = targetDir.listFiles(file -> fileListPaths.contains(file.toPath()) == false);
		
		log.warn("------------------------------------------------");
		for (File file : removeFiles) {
			
			log.warn(file.getAbsolutePath());
			
			file.delete();
			
		}
		
	}

}








































