package kr.co.dao;

import java.util.List;
import java.util.Map;

import kr.co.vo.BoardVO;
import kr.co.vo.Criteria;

public interface BoardDAO {

	// 게시글 작성
	public int write(BoardVO boardVO) throws Exception;
	
	// 게시글 목록 
	public List<BoardVO> list(Criteria cri) throws Exception;
		
	// 게시물 총 갯수
	public int listCount() throws Exception;

	// 게시물 조회
	public BoardVO read(int bno) throws Exception;
	
	// 게시물 수정
	public int update(BoardVO boardVO) throws Exception;
	
	// 게시물 삭제
	public int delete(BoardVO boardVO) throws Exception;
	
	// 답글 작성
	public int replyWrite(BoardVO boardVO) throws Exception;
	
	// 첨부파일 업로드
	public void insertFile(Map<String, Object> map) throws Exception;
	
	// 첨부파일 조회
	public List<Map<String, Object>> selectFileList(int bno) throws Exception;
	
	// 첨부파일 다운
	public Map<String, Object> selectFileInfo(Map<String, Object> map) throws Exception;
	
	// 첨부파일 수정
	public void updateFile(Map<String, Object> map) throws Exception;
}
