<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../includes/header.jsp"%>

<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Board Read</h1>
	</div>
</div>

<!-- 본문 페이지 -->

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">

			<div class="panel-heading">Board Read Page</div>
			<div class="panel-body">

				<div class="form-gruop">
					<label>Bno</label> <input class="form-control" name='bno'
						value='<c:out value="${board.bno }"/>' readonly="readonly">
				</div>

				<div class="form-gruop">
					<label>Title</label> <input class="form-control" name='title'
						value='<c:out value="${board.title }"/>' readonly="readonly">
				</div>

				<div class="form-gruop">
					<label>Text area</label>
					<textarea class="form-control" rows="3" name='content'
						readonly="readonly"><c:out value="${board.content }" /></textarea>
				</div>

				<div class="form-gruop">
					<label>Writer</label> <input class="form-control" name='writer'
						value='<c:out value="${board.writer }"/>' readonly="readonly">
				</div>

				<br>
				<button data-oper='modify' class="btn btn-default"
					onclick="location.href='/board/modify?bno=<c:out value="${board.bno }"/>'">Modify</button>
				<button data-oper='list' class="btn btn-info"
					onclick="location.href='/board/list'">List</button>

				<form id='operForm' action="/board/modify" method="get">
					<input type='hidden' id='bno' name='bno'
						value='<c:out value="${board.bno}"/>'> <input
						type='hidden' name='pageNum'
						value='<c:out value="${cri.pageNum}"/>'> <input
						type='hidden' name='amount' value='<c:out value="${cri.amount}"/>'>
					<input type='hidden' name='type'
						value='<c:out value="${cri.type}"/>'> <input type='hidden'
						name='keyword' value='<c:out value="${cri.keyword}"/>'>
				</form>

			</div>

		</div>

	</div>

</div>

<!-- 댓글 페이지 -->

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				<i class="fa fa-comments fa-fw"></i> Reply
			</div>
			
			<div class="panel-body">
				<ul class="chat">
					<li class="left clearfix" data-rno='12'>
						<div>
							<div class="header">
								<strong class="primary-font">user00</strong>
								<small class="pull-right text-muted">2018-01-01 13:13 </small>
							</div>
							<p>Good job!</p>
						</div>
					</li>
				</ul>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript" src="/resources/js/reply.js"></script>

<!-- <script>

	console.log("===============");
	console.log("JS TEST");
	
	var bnoValue = '<c:out value="${board.bno}"/>';
	
	// 댓글 리스트 테스트
	/* replyService.getList({bno:bnoValue, page:1}, function(list){
		
		for(var i = 0, len = list.length||0; i < len; i++) {
			console.log(list[i]);
		}
	}); */
	
	// 댓글 삭제 테스트
	/* replyService.remove(34, function(count){
		
		console.log(count);
		
		if(count === "success"){
			alert("REMOVED");
		}
	}, function(err){
		alert('ERROR...');
	}); */
	
	// 댓글 수정 테스트
	/* replyService.update({
		rno : 34,
		bno : bnoValue,
		reply : "나다 10shakes...."
	}, function(result){
		alert("수정 완료...");
		
	}); */
	
	// 댓글 번호 테스트
	/* replyService.get(37, function(data){
		console.log(data);
	}); */

</script> -->

<script type="text/javascript">
	$(document).ready(function() {

		var operForm = $("#operForm");

		$("button[data-oper='modify']").on("click", function(e) {

			operForm.attr("action", "/board/modify").submit();

		});

		$("button[data-oper='list']").on("click", function(e) {

			operForm.find("#bno").remove();
			operForm.attr("action", "/board/list")
			operForm.submit();

		});
	});
</script>

<!-- 댓글 script -->

<script>

$(document).ready(function(){
	
	var bnoValue = '<c:out value="${board.bno}"/>';
	var replyUL = $(".chat");
	
		showList(1);
		
		function showList(page){
			
			replyService.getList({bno:bnoValue, page: page|| 1}, function(list){
				
				var str="";
				
				if(list == null || list.length == 0){
					
					replyUL.html("");
					
					return;
				}
				for(var i = 0, len = list.length || 0; i < len; i++){
					str +="<li class='left clearfix' data-rno='"+list[i].rno+"'>";
					str +="	<div><div class='header'><strong class='primary-font'>"+list[i].replyer+"</strong>";
					str +="	  <small class='pull-right text-muted'>"+list[i].replyDate+"</small></div>";
					str +="		<p>"+list[i].reply+"</p></div></li>";
				}
				
				replyUL.html(str);
				
			}); // end function
			
		} // end showList
});

</script>

<%@ include file="../includes/footer.jsp"%>





























