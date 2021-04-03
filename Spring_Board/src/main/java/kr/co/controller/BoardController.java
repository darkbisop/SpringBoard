package kr.co.controller;

import java.io.File;
import java.io.Writer;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.service.BoardService;
import kr.co.service.ReplyService;
import kr.co.vo.BoardVO;
import kr.co.vo.Criteria;
import kr.co.vo.PageMaker;
import kr.co.vo.ReplyVO;

@Controller
@RequestMapping("/board/*")
public class BoardController {

	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@Autowired
	BoardService service;
	
	@Autowired
	ReplyService replyService;
	
	// 게시판 글 작성 화면
	@RequestMapping(value = "/writeView", method = RequestMethod.GET)
	public void writeView() throws Exception{
		logger.info("writeView");
		
	}
	
	// 게시판 글 작성
	@RequestMapping(value = "/write", method = RequestMethod.POST)
	@ResponseBody
	public String write(BoardVO boardVO, MultipartHttpServletRequest mpRequest) throws Exception{
		logger.info("write");
		service.write(boardVO, mpRequest);
		
		return boardVO.getResult();
	}
	
	// 게시판 목록 조회
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(Model model, Criteria cri, BoardVO boardVO) throws Exception{
		logger.info("list");
		model.addAttribute("list",service.list(cri));
		model.addAttribute("read", service.read(boardVO.getBno()));
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(service.listCount());
		model.addAttribute("pageMaker", pageMaker);
		
		return "board/list";
	}
	
	// 게시판 조회
	@RequestMapping(value = "/readView", method = RequestMethod.GET)
	public String read(BoardVO boardVO, Model model, ReplyVO replyVO) throws Exception{
		logger.info("read");
		model.addAttribute("read", service.read(boardVO.getBno()));
		model.addAttribute("replyUpdate", replyService.selectReply(replyVO.getRno()));
		List<ReplyVO> replyList = replyService.readReply(boardVO.getBno());
		model.addAttribute("replyList", replyList);
		
		List<Map<String, Object>> fileList = service.selectFileList(boardVO.getBno());
		model.addAttribute("file", fileList);

		return "board/readView";
	}
	
	// 게시판 수정 화면
	@RequestMapping(value = "/updateView", method = RequestMethod.GET)
	public String updateView(BoardVO boardVO, Model model) throws Exception{
		logger.info("updateView");
		model.addAttribute("update", service.read(boardVO.getBno()));
		
		List<Map<String, Object>> fileList = service.selectFileList(boardVO.getBno());
		model.addAttribute("file", fileList);
		
		return "board/updateView";
	}
	
	// 게시판 수정
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	@ResponseBody
	public String update(BoardVO boardVO, @RequestParam(value="fileNoDel[]") String[] files,
						@RequestParam(value="fileNameDel[]") String[] fileNames,
						MultipartHttpServletRequest mpRequest) throws Exception {
		logger.info("update");
		service.update(boardVO, files, fileNames, mpRequest);
		
		return boardVO.getResult();
	}

	// 게시판 삭제
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	@ResponseBody
	public String delete(BoardVO boardVO) throws Exception{
		logger.info("delete");
		service.delete(boardVO);
		
		return boardVO.getResult();
	}
	
	// 게시판 답글 작성 화면
	@RequestMapping (value = "/replyWriteView", method = RequestMethod.GET)
	public String replyWriteView(BoardVO boardVO, Model model) throws Exception {
		logger.info("writeView");
		model.addAttribute("read", service.read(boardVO.getBno()));
		
		return "board/replyWriteView";
	}
		
	// 게시판 답글 작성
	@RequestMapping (value = "/replyWrite", method = RequestMethod.POST)
	@ResponseBody
	public String replyWrite(BoardVO boardVO, MultipartHttpServletRequest mpRequest) throws Exception {
		logger.info("replyWrite");
		boardVO.setTitle("Re:" + boardVO.getTitle() + "의 답글");
		service.replyWrite(boardVO, mpRequest);
		
		return boardVO.getResult();
	}
	
	// 댓글 작성
	@RequestMapping (value="/writeReply", method = RequestMethod.POST)
	@ResponseBody
	public String replyWrite(ReplyVO replyVO, RedirectAttributes rttr) throws Exception {
		logger.info("writeReply");
		replyService.writeReply(replyVO);
		rttr.addAttribute("bno", replyVO.getBno());
		
		return replyVO.getResult();
	}
	
	// 댓글 수정 GET
	@RequestMapping (value="/replyUpdateView", method = RequestMethod.GET)
	public String replyUpdateView(ReplyVO replyVO, Model model) throws Exception {
		logger.info("reply Update");
		model.addAttribute("replyUpdate", replyService.selectReply(replyVO.getRno()));
		
		return "board/replyUpdateView";
	}
	
	// 댓글 수정
	@RequestMapping (value="/replyUpdate", method= RequestMethod.POST)
	@ResponseBody
	public String replyUpdate(ReplyVO replyVO, Model model) throws Exception {
		logger.info("reply Update");
		replyService.updateReply(replyVO);

		return replyVO.getResult();
	}
	
	// 댓글 삭제
	@RequestMapping (value="/replyDelete", method= {RequestMethod.POST, RequestMethod.GET})
	@ResponseBody
	public String replyDelete(@RequestParam(value = "rno") int rno) throws Exception {
		logger.info("reply delete");
		replyService.deleteReply(rno);

		return "SUCCESS";
	}
	
	// 댓글의 댓글
	@RequestMapping (value="/replyReply", method = {RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public String replyReply(ReplyVO replyVO, RedirectAttributes rttr) throws Exception {
		logger.info("reply Reply");
		replyService.replyReply(replyVO);
		rttr.addAttribute("bno", replyVO.getBno());
		
		return replyVO.getResult();
	}
	
	// 파일 다운
	@RequestMapping(value="/fileDown")
	public void fileDown(@RequestParam Map<String, Object> map, HttpServletResponse response) throws Exception {
		Map<String, Object> resultMap = service.selectFileInfo(map);
		String storedFileName = (String)resultMap.get("STORED_FILE_NAME");
		String origFileName = (String)resultMap.get("ORG_FILE_NAME");
		
		byte fileByte[] = org.apache.commons.io.FileUtils.readFileToByteArray(new File("D:\\SpringBoardTestStorage\\" + storedFileName));
		
		response.setContentType("application/octet-stream");
		response.setContentLength(fileByte.length);
		response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(origFileName, "UTF-8") + "\";");
		response.getOutputStream().write(fileByte);
		response.getOutputStream().flush();
		response.getOutputStream().close();
	}
}