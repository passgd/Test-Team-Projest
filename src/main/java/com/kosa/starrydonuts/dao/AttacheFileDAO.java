package com.kosa.starrydonuts.dao;

import java.util.List;

import com.kosa.starrydonuts.domain.AttacheFileDTO;
import com.kosa.starrydonuts.domain.BoardDTO;

public interface AttacheFileDAO {
	
	//1. 첨부파일 목록
	public List<AttacheFileDTO> getList(BoardDTO board) throws Exception;

	public AttacheFileDTO getAttacheFile(String fileNo) throws Exception;

	public void insert(AttacheFileDTO attacheFile) throws Exception;
	
	public List<BoardDTO> boardId(BoardDTO board) throws Exception;
	
} // end class
