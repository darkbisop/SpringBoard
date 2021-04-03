package kr.co.service;

import java.util.List;

import kr.co.vo.ReplyVO;

public interface ReplyService {

	// 댓글 조회
	public List<ReplyVO> readReply(int bno) throws Exception;
	
	// 댓글 작성
	public ReplyVO writeReply(ReplyVO vo) throws Exception; 
	
	// 댓글 수정
	public ReplyVO updateReply(ReplyVO replyVO) throws Exception;
		
	// 댓글 삭제
	public void deleteReply(int rno) throws Exception;
		
	// 상세 조회
	public ReplyVO selectReply(int rno) throws Exception;
	
	// 댓글의 답글
	public ReplyVO replyReply(ReplyVO replyVO) throws Exception;
}
