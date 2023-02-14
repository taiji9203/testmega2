package com.finalProject.controller;



import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.finalProject.dto.MovieListDTO;
import com.finalProject.service.MovieListService;

@Controller
public class MainController {
	
	
	@Resource
	private MovieListService movieListService;
	
	
	//@RequestMapping(value = "/moviestar/login", method = RequestMethod.GET)
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public ModelAndView main(HttpServletRequest request) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		
		MovieListDTO dto = new MovieListDTO();
		
		//main에서 list형식으로 뿌릴거니 List에 담는다.
		List<MovieListDTO> lists = movieListService.readData();
		
		mav.addObject("lists",lists);
		
		mav.setViewName("main");
		
		//System.out.println(lists);

		return mav;
	}

	/*
	 * @RequestMapping(value = "/booking_1") public ModelAndView booking_1() throws
	 * Exception { ModelAndView mav = new ModelAndView();
	 * 
	 * mav.setViewName("booking_1");
	 * 
	 * return mav; }
	 */
	
	// 메인화면 
		@RequestMapping(value = "/", method = RequestMethod.GET)
		public ModelAndView index(HttpServletRequest request) throws Exception { // index을 서블릿에 연결
			
			ModelAndView mav = new ModelAndView();
			
			MovieListDTO dto = new MovieListDTO();
			
			//main에서 list형식으로 뿌릴거니 List에 담는다.
			List<MovieListDTO> lists = movieListService.readData();
			
			mav.addObject("lists",lists);
			
			mav.setViewName("index"); // /index.jsp 연결
			
			//System.out.println(lists);

			return mav;
		}
	
	// 영화 > 전체영화  
		@RequestMapping(value = "/movie/movie", method = RequestMethod.GET)
		public ModelAndView movie(HttpServletRequest request) throws Exception { // movie을 서블릿에 연결
			
			ModelAndView mav = new ModelAndView();
			
			MovieListDTO dto = new MovieListDTO();
			
			//main에서 list형식으로 뿌릴거니 List에 담는다.
			List<MovieListDTO> lists = movieListService.readData();
			
			mav.addObject("lists",lists);
			
			mav.setViewName("/movie/movie"); // /movie/movie.jsp 연결
			
			//System.out.println(lists);

			return mav;
		}
	
	// 영화 > 큐레이션   
		@RequestMapping(value = "/movie/curation", method = RequestMethod.GET)
		public ModelAndView curation(HttpServletRequest request) throws Exception { // curation을 서블릿에 연결
			
			ModelAndView mav = new ModelAndView();
			
			MovieListDTO dto = new MovieListDTO();
			
			//main에서 list형식으로 뿌릴거니 List에 담는다.
			List<MovieListDTO> lists = movieListService.readData();
			
			mav.addObject("lists",lists);
			
			mav.setViewName("/movie/curation"); // /movie/curation.jsp 연결
			
			//System.out.println(lists);

			return mav;
		}
	
	// 영화 > 무비포스트    
		@RequestMapping(value = "/movie/moviePost", method = RequestMethod.GET)
		public ModelAndView moviePost(HttpServletRequest request) throws Exception { // moviePost을 서블릿에 연결
			
			ModelAndView mav = new ModelAndView();
			
			MovieListDTO dto = new MovieListDTO();
			
			//main에서 list형식으로 뿌릴거니 List에 담는다.
			List<MovieListDTO> lists = movieListService.readData();
			
			mav.addObject("lists",lists);
			
			mav.setViewName("/movie/moviePost"); // /movie/moviePost.jsp 연결
			
			//System.out.println(lists);

			return mav;
		}
	
	
	// 예매 > 빠른예매  
		@RequestMapping(value = "/booking/booking", method = RequestMethod.GET)
		public ModelAndView booking(HttpServletRequest request) throws Exception { // booking을 서블릿에 연결
			
			ModelAndView mav = new ModelAndView();
			
			MovieListDTO dto = new MovieListDTO();
			
			//main에서 list형식으로 뿌릴거니 List에 담는다.
			List<MovieListDTO> lists = movieListService.readData();
			
			mav.addObject("lists",lists);
			
			mav.setViewName("/booking/booking"); // /booking/booking.jsp 연결
			
			//System.out.println(lists);

			return mav;
		}
	
	// 예매 > 상영시간표 
		@RequestMapping(value = "/booking/timeTable", method = RequestMethod.GET)
		public ModelAndView timeTable(HttpServletRequest request) throws Exception { // timeTable을 서블릿에 연결
			
			ModelAndView mav = new ModelAndView();
			
			MovieListDTO dto = new MovieListDTO();
			
			//main에서 list형식으로 뿌릴거니 List에 담는다.
			List<MovieListDTO> lists = movieListService.readData();
			
			mav.addObject("lists",lists);
			
			mav.setViewName("/booking/timeTable"); // /booking/timeTable.jsp 연결
			
			//System.out.println(lists);

			return mav;
		}
	
	// 예매 > 코엑스 더 부티크 프라이빗 대관예매 
		// 예매 > 상영시간표 
				@RequestMapping(value = "/booking/privateBooking", method = RequestMethod.GET)
				public ModelAndView privateBooking(HttpServletRequest request) throws Exception { // timeTable을 서블릿에 연결
					
					ModelAndView mav = new ModelAndView();
					
					MovieListDTO dto = new MovieListDTO();
					
					//main에서 list형식으로 뿌릴거니 List에 담는다.
					List<MovieListDTO> lists = movieListService.readData();
					
					mav.addObject("lists",lists);
					
					mav.setViewName("/booking/privateBooking"); // /booking/timeTable.jsp 연결
					
					//System.out.println(lists);

					return mav;
				}
	
	
	// 극장 > 전체극장 
		@RequestMapping(value = "/theater/allTheater", method = RequestMethod.GET)
		public ModelAndView allTheater(HttpServletRequest request) throws Exception { // allTheater을 서블릿에 연결
			
			ModelAndView mav = new ModelAndView();
			
			MovieListDTO dto = new MovieListDTO();
			
			//main에서 list형식으로 뿌릴거니 List에 담는다.
			List<MovieListDTO> lists = movieListService.readData();
			
			mav.addObject("lists",lists);
			
			mav.setViewName("/theater/allTheater"); // /theater/allTheater.jsp 연결
			
			//System.out.println(lists);

			return mav;
		}
	
	// 극장 > 특별관 
		@RequestMapping(value = "/theater/specialTheater", method = RequestMethod.GET)
		public ModelAndView specialTheater(HttpServletRequest request) throws Exception { // specialTheater을 서블릿에 연결
			
			ModelAndView mav = new ModelAndView();
			
			MovieListDTO dto = new MovieListDTO();
			
			//main에서 list형식으로 뿌릴거니 List에 담는다.
			List<MovieListDTO> lists = movieListService.readData();
			
			mav.addObject("lists",lists);
			
			mav.setViewName("/theater/specialTheater"); // /theater/specialTheater.jsp 연결
			
			//System.out.println(lists);

			return mav;
		}
	
	
	// 이벤트 > 전체 
		@RequestMapping(value = "/event/event", method = RequestMethod.GET)
		public ModelAndView event(HttpServletRequest request) throws Exception { // event을 서블릿에 연결
			
			ModelAndView mav = new ModelAndView();
			
			MovieListDTO dto = new MovieListDTO();
			
			//main에서 list형식으로 뿌릴거니 List에 담는다.
			List<MovieListDTO> lists = movieListService.readData();
			
			mav.addObject("lists",lists);
			
			mav.setViewName("/event/event"); // /event/event.jsp 연결
			
			//System.out.println(lists);

			return mav;
		}
	
	// 이벤트 > 메가Pick 
		@RequestMapping(value = "/event/eventMegabox", method = RequestMethod.GET)
		public ModelAndView eventMegabox(HttpServletRequest request) throws Exception { // eventMegabox을 서블릿에 연결
			
			ModelAndView mav = new ModelAndView();
			
			MovieListDTO dto = new MovieListDTO();
			
			//main에서 list형식으로 뿌릴거니 List에 담는다.
			List<MovieListDTO> lists = movieListService.readData();
			
			mav.addObject("lists",lists);
			
			mav.setViewName("/event/eventMegabox"); // /event/eventMegabox.jsp 연결
			
			//System.out.println(lists);

			return mav;
		}
	
	// 이벤트 > 영화 
		@RequestMapping(value = "/event/eventMovie", method = RequestMethod.GET)
		public ModelAndView eventMovie(HttpServletRequest request) throws Exception { // eventMovie을 서블릿에 연결
			
			ModelAndView mav = new ModelAndView();
			
			MovieListDTO dto = new MovieListDTO();
			
			//main에서 list형식으로 뿌릴거니 List에 담는다.
			List<MovieListDTO> lists = movieListService.readData();
			
			mav.addObject("lists",lists);
			
			mav.setViewName("/event/eventMovie"); // /event/eventMovie.jsp 연결
			
			//System.out.println(lists);

			return mav;
		}
	
	// 이벤트 > 극장  
		@RequestMapping(value = "/event/eventTheater", method = RequestMethod.GET)
		public ModelAndView eventTheater(HttpServletRequest request) throws Exception { // eventTheater을 서블릿에 연결
			
			ModelAndView mav = new ModelAndView();
			
			MovieListDTO dto = new MovieListDTO();
			
			//main에서 list형식으로 뿌릴거니 List에 담는다.
			List<MovieListDTO> lists = movieListService.readData();
			
			mav.addObject("lists",lists);
			
			mav.setViewName("/event/eventTheater"); // /event/eventTheater.jsp 연결
			
			//System.out.println(lists);

			return mav;
		}
	
	// 이벤트 > 제휴/할인   
		@RequestMapping(value = "/event/eventPromotion", method = RequestMethod.GET)
		public ModelAndView eventPromotion(HttpServletRequest request) throws Exception { // eventPromotion을 서블릿에 연결
			
			ModelAndView mav = new ModelAndView();
			
			MovieListDTO dto = new MovieListDTO();
			
			//main에서 list형식으로 뿌릴거니 List에 담는다.
			List<MovieListDTO> lists = movieListService.readData();
			
			mav.addObject("lists",lists);
			
			mav.setViewName("/event/eventPromotion"); // /event/eventPromotion.jsp 연결
			
			//System.out.println(lists);

			return mav;
		}
	
	// 이벤트 > 시사회/무대인사    
		@RequestMapping(value = "/event/eventCurtaincall", method = RequestMethod.GET)
		public ModelAndView eventCurtaincall(HttpServletRequest request) throws Exception { // eventCurtaincall을 서블릿에 연결
			
			ModelAndView mav = new ModelAndView();
			
			MovieListDTO dto = new MovieListDTO();
			
			//main에서 list형식으로 뿌릴거니 List에 담는다.
			List<MovieListDTO> lists = movieListService.readData();
			
			mav.addObject("lists",lists);
			
			mav.setViewName("/event/eventCurtaincall"); // /event/eventCurtaincall.jsp 연결
			
			//System.out.println(lists);

			return mav;
		}
	
	// 스토어
		@RequestMapping(value = "/store", method = RequestMethod.GET)
		public ModelAndView store(HttpServletRequest request) throws Exception { // store을 서블릿에 연결
			
			ModelAndView mav = new ModelAndView();
			
			MovieListDTO dto = new MovieListDTO();
			
			//main에서 list형식으로 뿌릴거니 List에 담는다.
			List<MovieListDTO> lists = movieListService.readData();
			
			mav.addObject("lists",lists);
			
			mav.setViewName("/store/store"); // /view/store/store.jsp 연결
			
			//System.out.println(lists);

			return mav;
		}
	
	// 혜택 > 멤버십링크
	@RequestMapping(value = "/benefits/memberShip", method = RequestMethod.GET)
	public ModelAndView memberShip(HttpServletRequest request) throws Exception { // memberShip을 서블릿에 연결
		
		ModelAndView mav = new ModelAndView();
		
		MovieListDTO dto = new MovieListDTO();
		
		//main에서 list형식으로 뿌릴거니 List에 담는다.
		List<MovieListDTO> lists = movieListService.readData();
		
		mav.addObject("lists",lists);
		
		mav.setViewName("/benefits/memberShip"); // /view/benefits/memberShip.jsp 연결
		
		//System.out.println(lists);

		return mav;
	}
	
	// 혜택 > vip Lounge
		@RequestMapping(value = "/benefits/vipLounge", method = RequestMethod.GET)
		public ModelAndView vipLounge(HttpServletRequest request) throws Exception { // vipLounge을 서블릿에 연결
			
			ModelAndView mav = new ModelAndView();
			
			MovieListDTO dto = new MovieListDTO();
			
			//main에서 list형식으로 뿌릴거니 List에 담는다.
			List<MovieListDTO> lists = movieListService.readData();
			
			mav.addObject("lists",lists);
			
			mav.setViewName("/benefits/vipLounge"); // /view/benefits/vipLounge.jsp 연결
			
			//System.out.println(lists);

			return mav;
		}
	
	// 혜택 > 제휴/할인 
		@RequestMapping(value = "/benefits/disCount", method = RequestMethod.GET)
		public ModelAndView disCount(HttpServletRequest request) throws Exception { // disCount을 서블릿에 연결
			
			ModelAndView mav = new ModelAndView();
			
			MovieListDTO dto = new MovieListDTO();
			
			//main에서 list형식으로 뿌릴거니 List에 담는다.
			List<MovieListDTO> lists = movieListService.readData();
			
			mav.addObject("lists",lists);
			
			mav.setViewName("/benefits/disCount"); // /view/benefits/disCount.jsp 연결
			
			//System.out.println(lists);

			return mav;
		}

	
}
