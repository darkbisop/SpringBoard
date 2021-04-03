package kr.co.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import kr.co.vo.ReplyVO;

@Repository
public class ReplyDAOImpl implements ReplyDAO {

	@Inject
	SqlSession sql;
	
	// 댓글 조회
	@Override
	public List<ReplyVO> readReply(int bno) throws Exception {
		return sql.selectList("replyMapper.readReply", bno);
	}
	
	// 댓글 작성
	@Override
	public int writeReply(ReplyVO vo) throws Exception {
		return sql.insert("replyMapper.writeReply", vo);
	}
	
	// 댓글 수정
	@Override
	public int updateReply(ReplyVO replyVO) throws Exception {
		return sql.update("replyMapper.updateReply", replyVO);
	}
	
	// 댓글 삭제
	@Override
	public void deleteReply(int rno) throws Exception {
		sql.delete("replyMapper.deleteReply", rno);
	}
	
	// 댓글의 답글
	@Override
	public int replyReply(ReplyVO replyVO) throws Exception {
		return sql.insert("replyMapper.replyReply", replyVO);
	}

	
	// 상세 조회
	@Override
	public ReplyVO selectReply(int rno) throws Exception {
		return sql.selectOne("replyMapper.selectReply", rno);
	}
}
