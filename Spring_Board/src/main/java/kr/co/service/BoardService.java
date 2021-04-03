package kr.co.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.co.vo.BoardVO;
import kr.co.vo.Criteria;

public interface BoardService {

	// 게시글 작성
	public BoardVO write(BoardVO boardVO, MultipartHttpServletRequest mpRequest) throws Exception;
	
	// 게시글 목록 
	public List<BoardVO> list(Criteria cri) throws Exception;
			
	// 게시물 총 갯수
	public int listCount() throws Exception;
	
	// 게시물 목록 조회
	public BoardVO read(int bno) throws Exception;
	
	// 게시물 수정
	public BoardVO update(BoardVO boardVO, String[] files, String[] fileNames, MultipartHttpServletRequest mpRequest) throws Exception;
	
	// 게시물 삭제
	public BoardVO delete(BoardVO boardVO) throws Exception;
	
	// 답글 작성
	public BoardVO replyWrite(BoardVO boardVO, MultipartHttpServletRequest mpRequest) throws Exception;
	
	// 첨부파일 조회
	public List<Map<String, Object>> selectFileList(int bno) throws Exception;
	
	// 첨부파일 다운
	public Map<String, Object> selectFileInfo(Map<String, Object> map) throws Exception;
}
