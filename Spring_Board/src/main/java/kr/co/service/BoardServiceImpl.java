package kr.co.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.co.dao.BoardDAO;
import kr.co.util.FileUtils;
import kr.co.vo.BoardVO;
import kr.co.vo.Criteria;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardDAO dao;
	
	@Resource(name="fileUtils")
	private FileUtils fileUtils;
	
	// 게시글 작성
	@Override
	public BoardVO write(BoardVO boardVO, MultipartHttpServletRequest mpRequest) throws Exception {
		int Cnt = dao.write(boardVO);

		if (Cnt > 0) {
			boardVO.setResult("SUCCESS");
		} else {
			boardVO.setResult("FAIL");
		}
		
		List<Map<String,Object>> list = fileUtils.parseInsertFileInfo(boardVO, mpRequest); 
		int size = list.size();
		for(int i=0; i<size; i++){ 
			dao.insertFile(list.get(i)); 
		}
		
		return boardVO;
	}
	
	// 게시물 목록
	@Override
	public List<BoardVO> list(Criteria cri) throws Exception {
		return dao.list(cri);
	}
	
	// 게시물 총 갯수
	public int listCount() throws Exception {
		return dao.listCount();
	}
	
	// 게시물 목록 조회
	public BoardVO read(int bno) throws Exception {
		return dao.read(bno);
	}
	
	// 게시물 수정
	@Override
	public BoardVO update(BoardVO boardVO, String[] files, String[] fileNames, MultipartHttpServletRequest mpRequest) throws Exception {
		int Cnt = dao.update(boardVO);
		
		if (Cnt > 0) {
			boardVO.setResult("SUCCESS");
		} else {
			boardVO.setResult("FAIL");
		}
		
		List<Map<String, Object>> list = fileUtils.parseUpdateFileInfo(boardVO, files, fileNames, mpRequest);
		Map<String, Object> tempMap = null;
		int size = list.size();
		for (int i = 0; i < size; i++) {
			tempMap = list.get(i);
			
			if (tempMap.get("IS_NEW").equals("Y")) {
				dao.insertFile(tempMap);
			} else {
				dao.updateFile(tempMap);
			}
		}
		
		return boardVO;
	}

	// 게시글 삭제
	@Override
	public BoardVO delete(BoardVO boardVO) throws Exception {
		int Cnt = dao.delete(boardVO);
		
		if (Cnt > 0) {
			boardVO.setResult("SUCCESS");
		} else {
			boardVO.setResult("FAIL");
		}
		
		return boardVO;
	}
	
	// 답글 작성
	@Override
	public BoardVO replyWrite(BoardVO boardVO, MultipartHttpServletRequest mpRequest) throws Exception {
		int Cnt = dao.replyWrite(boardVO);
		
		if (Cnt > 0) {
			boardVO.setResult("SUCCESS");
		} else {
			boardVO.setResult("FAIL");
		}
		
		List<Map<String,Object>> list = fileUtils.parseInsertFileInfo(boardVO, mpRequest); 
		int size = list.size();
		for(int i=0; i<size; i++){ 
			dao.insertFile(list.get(i)); 
		}
		
		return boardVO;
	}
	
	// 첨부파일 조회
	@Override
	public List<Map<String, Object>> selectFileList(int bno) throws Exception {
		return dao.selectFileList(bno);
	}
	
	// 첨부파일 다운
	@Override
	public Map<String, Object> selectFileInfo(Map<String, Object> map) throws Exception {
		return dao.selectFileInfo(map);
	}
}
