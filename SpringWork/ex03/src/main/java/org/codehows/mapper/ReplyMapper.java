package org.codehows.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.codehows.domain.Criteria;
import org.codehows.domain.ReplyVO;

public interface ReplyMapper {
	
	public int insert(ReplyVO vo); // 댓글 등록
	
	public ReplyVO read(Long rno); // 특정 댓글 읽기
	
	public int delete(Long rno); // 특정 댓글 삭제
	
	public int update(ReplyVO reply); // 댓글 수정
	
	public List<ReplyVO> getListWithPaging( // 댓글 목록과 페이징 처리
			@Param("cri") Criteria cri,
			@Param("bno") Long bno);

}
