package controller.mypage;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dto.CartDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lecture.LectureDTO;
import member.MemberDAO;
import member.MemberDTO;

@WebServlet("/mypage/mypage.do")
public class MypageController extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		HttpSession session = req.getSession(true);
		String id = (String)session.getAttribute("userId");
		List<HashMap<String, Object>> param = new ArrayList<HashMap<String,Object>>();
		MemberDAO dao = new MemberDAO();
		
		List<String> emailList = new ArrayList<String>();
		List<String> nameList = new ArrayList<String>();
		List<String> titleList = new ArrayList<String>();
		List<String> teacherList = new ArrayList<String>();
		List<Date> strdateList = new ArrayList<Date>();
		List<Date> enddateList = new ArrayList<Date>();
		List<Integer> idxList = new ArrayList<Integer>();
		param = dao.getCartInfo(id);
		for(int i = 0; i<param.size(); i++) {
			MemberDTO memdto = new MemberDTO();
			LectureDTO lecdto = new LectureDTO();
			CartDTO cartdto = new CartDTO();
			
			memdto = (MemberDTO)param.get(i).get(i+"memdto");
			lecdto = (LectureDTO)param.get(i).get(i+"lecdto");
			cartdto = (CartDTO)param.get(i).get(i+"cartdto");
			System.out.println(cartdto.getLecture_title());
			emailList.add(memdto.getMember_email());
			nameList.add(memdto.getMember_name());
			titleList.add(cartdto.getLecture_title());
			teacherList.add(cartdto.getLecture_teacher());
			strdateList.add(lecdto.getLecture_start_date());
			enddateList.add(lecdto.getLecture_end_date());
			idxList.add(lecdto.getLecture_idx());
			
		}
		
		Map<String, Object> params = new HashMap<String,Object>();
		
		
		
		params.put("emailList", emailList);
		params.put("nameList", nameList);
		params.put("id", id);
		params.put("titleList", titleList);
		params.put("teacherList", teacherList);
		params.put("strdateList", strdateList);
		params.put("enddateList", enddateList);
		params.put("idxList", idxList);
		
		req.setAttribute("params", params);
		dao.close();
		req.getRequestDispatcher("/mypage/mypage.jsp").forward(req, resp);
	}
	
}