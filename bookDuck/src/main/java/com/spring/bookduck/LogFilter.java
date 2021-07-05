package com.spring.bookduck;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Servlet Filter implementation class LogFilter
 */
public class LogFilter implements Filter {

	private Logger logger = LoggerFactory.getLogger(LogFilter.class);
    /**
     * Default constructor. 
     */
    public LogFilter() {
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
	}

	
	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		
		HttpServletRequest req = (HttpServletRequest) request;
		
		String remoteAddr = req.getRemoteAddr();
		String uri = req.getRequestURI();
		String url = req.getRequestURL().toString();
		String queryString = req.getQueryString();
		
		String referer = req.getHeader("referer");
		String agent = req.getHeader("User-Agent");
		
		StringBuffer sb = new StringBuffer();
		sb.append("\n* remoteAddr : " + remoteAddr)			// ip 주소
		  .append("\n* uri : " + uri)						// http 요청 url 중에 queryString까지 반환. (context path)
		  .append("\n* url : " + url)						// protocol + servername + portnumber + serverpath
		  .append("\n* queryString : " + queryString)		// key=value 형태로 데이터 전달
		  .append("\n* referer : " + referer)				// 이전 페이지의 url (getHeader : 지정한 요청 헤더값을 문자열로 반환)
		  .append("\n* agent : " + agent)					// 사용자 정보 (browser version, os 등)
		  .append("\n");



		logger.info("\nLOG Filter" + sb);
		
		chain.doFilter(req, response);
		

		// pass the request along the filter chain
		// chain.doFilter(request, response);

	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
	}

}































