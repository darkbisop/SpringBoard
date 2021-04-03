package kr.co.dao;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import kr.co.vo.BoardVO;
import kr.co.vo.Criteria;

@Repository
public class BoardDAOImpl implements BoardDAO {
	
	@Inject
	private SqlSession sqlSession;
	
	// 게시글 작성
	@Override
	public int write(BoardVO boardVO) throws Exception {
		return sqlSession.insert("boardMapper.insert", boardVO);		
	}
	
	// 게시물 목록
	@Override
	public List<BoardVO> list(Criteria cri) throws Exception {
		return sqlSession.selectList("boardMapper.listPage", cri);
	}
	
	public int listCount() throws Exception {
		return sqlSession.selectOne("boardMapper.listCount");
	}
	
	// 게시물 조회
	@Override
	public BoardVO read(int bno) throws Exception {
		return sqlSession.selectOne("boardMapper.read", bno);
	}
	
	// 게시물 수정
	@Override
	public int update(BoardVO boardVO) throws Exception {
		return sqlSession.update("boardMapper.update", boardVO);
	}

	// 게시물 삭제
	@Override
	public int delete(BoardVO boardVO) throws Exception {
		return sqlSession.delete("boardMapper.delete", boardVO);
	}
	
	// 답글 작성
	@Override
	public int replyWrite(BoardVO boardVO) throws Exception {
		sqlSession.update("boardMapper.replyBoardUpdate", boardVO);
		return sqlSession.insert("boardMapper.insertReply", boardVO);
	}
	
	// 첨부파일 업로드
	@Override
	public void insertFile(Map<String, Object> map) throws Exception {
		sqlSession.insert("boardMapper.insertFile", map);
	}
	
	// 첨부파일 조회
	@Override
	public List<Map<String, Object>> selectFileList(int bno) throws Exception {
		return sqlSession.selectList("boardMapper.selectFileList", bno);
	}
	
	// 첨부파일 다운
	@Override
	public Map<String, Object> selectFileInfo(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("boardMapper.selectFileInfo", map);
	}
	
	// 첨부파일 수정
	@Override
	public void updateFile(Map<String, Object> map) throws Exception {
		sqlSession.update("boardMapper.updateFile", map);
	}
}
