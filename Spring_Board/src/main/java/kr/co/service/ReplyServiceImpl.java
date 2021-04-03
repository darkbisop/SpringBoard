package kr.co.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.co.dao.ReplyDAO;
import kr.co.vo.ReplyVO;

@Service
public class ReplyServiceImpl implements ReplyService {

	@Inject
	ReplyDAO dao;
	
	// 댓글 조회
	@Override
	public List<ReplyVO> readReply(int bno) throws Exception {
		return dao.readReply(bno);
	}
	
	// 댓글 작성
	@Override
	public ReplyVO writeReply(ReplyVO replyVO) throws Exception {
		int cnt = dao.writeReply(replyVO);
		
		if (cnt > 0) {
			replyVO.setResult("SUCCESS");
		} else {
			replyVO.setResult("FAIL");
		}
		
		return replyVO;
	}
	
	// 댓글 수정
	@Override
	public ReplyVO updateReply(ReplyVO replyVO) throws Exception {
		int cnt = dao.updateReply(replyVO);
		
		if (cnt > 0) {
			replyVO.setResult("SUCCESS");
		} else {
			replyVO.setResult("FAIL");
		}
		
		return replyVO;
	}
			
	// 댓글 삭제
	@Override
	public void deleteReply(int rno) throws Exception {
		dao.deleteReply(rno);
	}
	
	// 댓글의 답글
	public ReplyVO replyReply(ReplyVO replyVO) throws Exception {
		int cnt = dao.replyReply(replyVO);
		
		if (cnt > 0) {
			replyVO.setResult("SUCCESS");
		} else {
			replyVO.setResult("FAIL");
		}
		
		return replyVO;
	}
			
	// 상세 조회
	public ReplyVO selectReply(int rno) throws Exception {
		return dao.selectReply(rno);
	}
}
