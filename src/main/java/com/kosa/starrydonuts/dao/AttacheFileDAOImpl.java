package com.kosa.starrydonuts.dao;


import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kosa.starrydonuts.domain.AttacheFileDTO;
import com.kosa.starrydonuts.domain.BoardDTO;

@Repository("attacheFileDAO")
public class AttacheFileDAOImpl implements AttacheFileDAO {
	@Autowired
	private  SqlSession sqlSession;

	
	//1. 첨부파일 목록
	@Override
	public List<AttacheFileDTO> getList(BoardDTO board) throws Exception {
		return sqlSession.selectList("mapper.attache_file.getList", board);
	}


	@Override
	public AttacheFileDTO getAttacheFile(String fileNo) {
		return sqlSession.selectOne("mapper.attache_file.getAttacheFile", fileNo);
	}


	@Override
	public void insert(AttacheFileDTO attacheFile) {
		System.out.println(attacheFile);
		sqlSession.insert("mapper.attache_file.insert", attacheFile);
	}


	@Override
	public List<BoardDTO> boardId(BoardDTO board) throws Exception {
		return sqlSession.selectList("mapper.board.boardId", board);
	}
	

} // end class