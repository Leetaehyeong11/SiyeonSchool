<%@page import="com.kh.common.model.vo.Attachment"%>
<%@page import="com.kh.mail.model.vo.MailReceiver"%>
<%@page import="com.kh.mail.model.vo.MailWriteSearchResult"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="../common/common.jsp" %>

<%
	MailWriteSearchResult teacher = (MailWriteSearchResult)request.getAttribute("teacher");
	// 선생님 - 사용자번호, 사용자이름, 사용자아이디

	ArrayList<MailWriteSearchResult> studentList = (ArrayList<MailWriteSearchResult>)request.getAttribute("studentList");
	// 학생목록 - 사용자번호, 사용자이름, 사용자아이디
	
	ArrayList<MailWriteSearchResult> contactsList = (ArrayList<MailWriteSearchResult>)request.getAttribute("contactsList");
	// 모든주소록(공유+개인) - 주소록번호, 주소록이름
	
	// 검색결과 리스트
	ArrayList<MailWriteSearchResult> searchResultList = new ArrayList<MailWriteSearchResult>();
	searchResultList.addAll(studentList);
	searchResultList.addAll(contactsList);
	
	// ===================== 답장 관련 =====================
	// 메일답장시 - 원본 메일의 정보를 화면에 미리 넣어주기

	// ------------- 정보 초기화 -------------
	Mail m = null;
	String mailNo = "";
	String mailTitle = "";
	String mailContent = "";
	int senderNo = 0;
	String senderName = "";
	String senderId = "";
	ArrayList<MailReceiver> mrListR = new ArrayList<MailReceiver>(); // 수신인 리스트
	ArrayList<MailReceiver> mrListC = new ArrayList<MailReceiver>(); // 참조인 리스트
	ArrayList<Attachment> attList = null; // 첨부파일 리스트
	String replyType = "";
	

	// ------------- 메일을 컨트롤러로부터 전달받았다면... -------------
	if(request.getAttribute("m") != null) {
		m = (Mail)request.getAttribute("m"); // 메일정보

		replyType = (String)request.getAttribute("replyType"); // 답장 타입 (s:single-답장, a:all-전체답장, f:forawd-전달, u:update-수정(임시저장했다가 실제로 보내기 위해 수정하는경우))
		
		if(replyType.equals("u")) { // 메일을 수정하는 경우
			attList = (ArrayList<Attachment>)request.getAttribute("attList");

		} else if(replyType.equals("f")) { // 메일을 전달하는 경우
			mailTitle = "Fw: " + m.getMailTitle(); // Fw: 전달
			attList = (ArrayList<Attachment>)request.getAttribute("attList");

		} else { // 메일 답장/전체답장의 경우
			mailTitle = "Re: " + m.getMailTitle(); // Re: 답장/전체답장
		}
		
		mailNo = m.getMailNo();
		senderNo = m.getUserNo();
		senderName = m.getUserName();
		senderId = m.getUserId();
		
		if(request.getAttribute("mrListR") != null){ // 수신인리스트를 컨트롤러로부터 받았다면
			mrListR.addAll((ArrayList<MailReceiver>)request.getAttribute("mrListR"));
		}
		if(request.getAttribute("mrListC") != null){ // 참조인리스트를 컨트롤러로부터 받았다면
			mrListC.addAll((ArrayList<MailReceiver>)request.getAttribute("mrListC"));
		}

		// ===================== 메일을 수정하는 경우 -> 기존 정보만 가지고 감. =====================
		if(replyType.equals("u")) {
			mailTitle = m.getMailTitle();
			mailContent = m.getMailContent();

		// ===================== 답장, 전체답장, 전달인 경우 -> 기존정보 앞에 원본메일 정보를 붙임=====================
		} else {

			// ------------- 수신인리스트 -------------
			// '이름(아이디)' 형식으로 하나의 문자열로 합침
			String mrListR_str = "";
			StringBuilder sb2 = new StringBuilder();
			for(int i=0; i<mrListR.size(); i++) {
				if(i != 0) {
					sb2.append(", ");
				}
				sb2.append(mrListR.get(i).getReceiverName() + "(" + mrListR.get(i).getReceiverId() + ")");
			}
			mrListR_str = sb2.toString();

			// ------------- 참조인리스트 -------------
			// '이름(아이디)' 형식으로 하나의 문자열로 합침
			String mrListC_str = "";
			StringBuilder sb3 = new StringBuilder();
			for(int i=0; i<mrListC.size(); i++) {
				if(i != 0) {
					sb3.append(", ");
				}
				sb3.append(mrListC.get(i).getReceiverName() + "(" + mrListC.get(i).getReceiverId() + ")");
			}
			mrListC_str = sb3.toString();

			// ------------- 원본메일정보 html만들기 -------------
			StringBuilder sb = new StringBuilder();
			sb.append("<br><br><div id='originalMsg'>");
			sb.append("--------------- Original Message ---------------<br>");
			sb.append("<b>From:</b> " + senderName + " (" + senderId + ")<br>");
			sb.append("<b>To:</b> " + mrListR_str + "<br>");
			sb.append("<b>Cc:</b> " + mrListC_str + "<br>");
			sb.append("<b>Sent:</b> " + m.getSendDate() + "<br>");
			sb.append("<b>Subject:</b> " + m.getMailTitle());
			sb.append("</div><br>");
			sb.append(m.getMailContent()); // 원본내용 합치기
			mailContent = sb.toString(); // 에디터 본문에 넣을 최종 텍스트

			// ------------- 메일제목 -------------
			if(mailTitle.length() > 100) { // 메일 제목이 db에 들어가기에 너무 길 경우, 뒷부분을 잘라줌.
				mailTitle = mailTitle.subSequence(0, 96) + "...";
			}
		}
	};
	
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">

	<!-- 네이버 스마트에디터(SmartEditor) -->
	<script type="text/javascript" src="<%= contextPath %>/resources/SE2/js/HuskyEZCreator.js" charset="utf-8"></script>
	<script type="text/javascript">
		var oEditors = [];
		$(function(){
			nhn.husky.EZCreator.createInIFrame({
				oAppRef: oEditors,
				elPlaceHolder: "ir1", //textarea에서 지정한 id와 일치해야 합니다. 
				//SmartEditor2Skin.html 파일이 존재하는 경로
				sSkinURI: "<%= contextPath %>/resources/SE2/SmartEditor2Skin.html",
				htParams : {
					bUseToolbar : true, // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
					bUseVerticalResizer : true, // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
					bUseModeChanger : true, // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
					fOnBeforeUnload : function(){}
				}, 
				fOnAppLoad : function(){
				    //기존 저장된 내용의 text 내용을 에디터상에 뿌려주고자 할때 사용
				    oEditors.getById["ir1"].exec("PASTE_HTML", [`<%= mailContent %>`]);
				},
				fCreator: "createSEditor2"
			});
		      
			//메일 보내기 버튼 클릭시 form 전송
			$("#send").click(function(){
			    oEditors.getById["ir1"].exec("UPDATE_CONTENTS_FIELD", []);
				if(validateMailtitle() && validateMailReceiver()){
					setReceiverCheckboxesChecked();
					$("#frm").submit();
				};
			});

			//메일 임시저장 버튼 클릭시 form 전송
			$("#tempSave").click(function(){
			    oEditors.getById["ir1"].exec("UPDATE_CONTENTS_FIELD", []);
				if(validateMailtitle()){
					setReceiverCheckboxesChecked();
					changeIsSentToT();
					$("#frm").submit();
				};
			});
		});
	</script>

</head>
<body>

	<%@ include file="../common/menubar.jsp" %>
	<%@ include file="mailSidebar.jsp" %>

	
	<!-- ======================================== 메인 ======================================== -->
	
	<script>
		
		// 메일 답장의 경우에 사용됨.
		const senderNo = Number('<%= senderNo %>');
		const senderName = '<%= senderName %>';
		const senderId = '<%= senderId %>';
		const replyType = '<%= replyType %>'; // 답장 타입 (s:single-답장, a:all-전체답장, f:forward-전달, u:update-수정(임시저장했다가 실제로 보내기 위해 수정하는경우)
		
		$(document).ready(function(){
			if (senderNo !== 0){ // 보낸사람이 있는경우
				// console.log("replyType:" + replyType);
				switch(replyType) {
					case "s": addSenderToRList(senderNo, senderName, senderId); break; // 답장 - 보낸사람을 수신인리스트에 추가
					case "u": // 수정 - 기존 수신인들을 수신인리스트에 추가
					case "a": addOriginalReceiversToRList('<%= mailNo %>'); break; // 전체답장 - 기존 수신인들을 수신인리스트에 추가
				}
			}
		})

	</script>

	<main class="mail-write">

		<form id="frm" action="<%= contextPath %>/mail.insert" method="post" enctype="multipart/form-data">

			<div class="mail-write-header">

				<% if(replyType.equals("u")) { // 임시보관메일이었던 경우, 기존메일 삭제를 위해 메일번호를 전달함. %>
					<input type="hidden" name="mailNo" value="<%= mailNo %>">
				<% } %>

				<div class="title">
					<% if(!currentMailbox.equals("wm")) { %>
						<h2>메일쓰기</h2>
					<% } else { %>
						<h2>내게쓰기</h2>
					<% } %>
					<div class="email-btns">
						<input type="button" class="btn" id="send" value="보내기"/>
						<input type="button" class="btn" id="tempSave" value="임시저장">
						<input type="hidden" id="isSent" name="isSent" value="S"><!-- 보내기:S, 임시저장:T (js로 필요시 value 바꿈) -->
						<input type="button" class="btn" value="취소" onclick="cancelWritingMail()"/>
					</div>
				</div>

				<table>

					<tr class="mailtitle">
						<td class="td-left">제목</td>
						<td class="td-right">
							<input type="text" id="title" name="title" placeholder="제목을 입력해주세요." maxlength="100" value="<%= mailTitle %>" required/>
						</td>
					</tr>

					<% if(!currentMailbox.equals("wm")) { %> <!-- 내게쓰기가 아닐경우 -->
						<tr class="receiver">
							<td class="td-left">받는사람</td>
							<td class="td-right">

								<div class="search">
									<input id="searchReceiver" class="search-input" type="text" name="keyword" placeholder="검색어를 입력해주세요.">
									<span class="icon material-symbols-outlined icon">search</span>

									<div id="receiverType">
										<input type="radio" id="rTypeR" name="receiverType" value="r" checked>
										<label for="rTypeR">수신</label>
										
										<input type="radio" id="rTypeC" name="receiverType" value="c">
										<label for="rTypeC">참조</label>
										
										<input type="radio" id="rTypeS" name="receiverType" value="s">
										<label for="rTypeS">비밀</label>
									</div>
								</div>

								<div id="searchResult">
									<ul>
										<li class="searchResult-data">
											<input type="hidden" class="pkNo" value="allUsers">
											<span class="name">* 모든 사용자</span>
											<input type="hidden" class="isUser" value="false">
										</li>

										<li class="searchResult-data">
											<input type="hidden" class="pkNo" value="allStudents">
											<span class="name">* 모든 학생</span>
											<input type="hidden" class="isUser" value="false">
										</li>

										<li class="searchResult-data">
											<input type="hidden" class="pkNo" value="teacher">
											<span class="name">* 선생님 - <%= teacher.getName() %> </span>
											<input type="hidden" class="isUser" value="true">
											<span class="userId">(<%= teacher.getUserId() %>)</span>
										</li>

										<% for(MailWriteSearchResult sr : searchResultList) { %>
											<li class="searchResult-data">
												<input type="hidden" class="pkNo" value="<%= sr.getPkNo() %>">
												<span class="name"><%= sr.getName() %></span>
												<input type="hidden" class="isUser" value="<%= sr.isUser() %>">
												<% if(sr.isUser()) { %>
													<span class="userId">(<%= sr.getUserId() %>)</span>
												<% } %>
											</li>
										<% } %>
									</ul>
								</div>

								<ul class="list-header">
									<li>
										<div class="rUserName">받는사람</div>
										<div class="rType">수신구분</div>
										<div class="rDelete">
											<span class="icon material-symbols-rounded">close</span>
										</div>
									</li>
								</ul>

								<!-- 수신인 동적으로 추가될 공간 -->
								<ul class="list-contents"></ul>

								<div class="listSummary">
									<p>총 <span class="total">0</span>명</p>
									<p class="detailCount">( 수신 <span class="r">0</span>, 참조 <span class="c">0</span>, 비밀 <span class="s">0</span> )</p>
								</div>

							</td>
						</tr>
					<% } else { %>
						<!-- 내게쓰기 -->
						<input type="hidden" name="userNo" value="<%= loginUser.getUserNo() %>">
						<input type="hidden" name="rType" value="r">
					<% } %>
						

					<tr class="attachment">
						<td class="td-left">첨부파일</td>
						<td class="td-right">
							<% if(attList != null) { %>
								<% for(Attachment at : attList) { %>
									<a class="file" download="<%= at.getOriginName() %>" href="<%= contextPath %>/<%= at.getFilePath() + at.getChangeName() %>">
										<span class="icon material-icons">file_download</span>
									</a>
									<a href="<%= contextPath %>/<%= at.getFilePath() + at.getChangeName() %>" target="_blank">
										<span class="fileName"><%= at.getOriginName() %></span>
									</a>
									<input type="hidden" name="originFileName" value="<%= at.getOriginName() %>">
								<% } %>
							<% } %>
							<div class="uploadInput">
								<input type="file" name="upfile">
							</div>
						</td>
					</tr>
					
				</table>

			</div>

			<div class="mail-write-content">
				<textarea id="ir1" name="content" style="width:100%; height:500px;"></textarea>
			</div>

		</form>
		
		<div class="btn" id="btnToGoUp">
			<span class="icon material-icons-round">arrow_upward</span>
		</div>
	</main>
	
</body>
</html>