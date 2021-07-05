package com.spring.bookduck.classify.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathFactory;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

import com.spring.bookduck.classify.biz.SearchBiz;
import com.spring.bookduck.model.dto.MemberDto;

@Controller
public class ClassifySearchController {
	
	private Logger logger = LoggerFactory.getLogger(ClassifySearchController.class);
			
	@Autowired
	private SearchBiz biz;	
	
	@RequestMapping("classifysearch.do")
	public String SearchPage() {
		
		logger.info("[ClassifySearchController] : classifysearch.do");
		
		return "classify/classifysearch";
	}
	
	@RequestMapping("classifyidajax.do")
	@ResponseBody
	public Map<String, List<MemberDto>> idsearch(String member_id) {
		logger.info("[ClassifySearchController]/classifyidajax.do : member_id = "+member_id);
				
		Map<String, List<MemberDto>> map = new HashMap<String, List<MemberDto>>();
		
		map.put("list", biz.idsearch(member_id));
		
		return map;
	}
	
	@RequestMapping("classifybookajax.do")
	@ResponseBody
	public Map<String, List<String>> booksearch(String search) throws Exception{
		
		logger.info("[ClassifySearchController] : classifybookajax.do");
		
		String key = "0061C990735847032625E99195E343C959D09BD0C9ED0B84A528F56247B727BB";		
		String query = URLEncoder.encode(search, "UTF-8");
		String path = "http://book.interpark.com/api/search.api?key="+key+"&query="+query+"&inputEncoding=utf-8";
		
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		DocumentBuilder builder = factory.newDocumentBuilder();
		Document doc = builder.parse(path);
		
		doc.getDocumentElement().normalize();
		
		NodeList nList = doc.getElementsByTagName("item");
		
		List<String> list = new ArrayList<String>();
		
		for(int temp = 0; temp < nList.getLength(); temp++){		
			Node nNode = nList.item(temp);
			if(nNode.getNodeType() == Node.ELEMENT_NODE){							
				Element eElement = (Element) nNode;				
				NodeList nodelist = eElement.getElementsByTagName("title").item(0).getChildNodes();
				Node nval = (Node) nodelist.item(0);
				list.add(nval.getNodeValue());
				// System.out.println(nval.getNodeValue());				
			}	
		}	
				
		/*
		Node item = itemList.item(0);		
		String title = xpath.compile("title").evaluate(item);
		System.out.println(title);
		*/
		
		/*
        for (int i = 0; i < itemList.getLength(); i++) {
            NodeList child = itemList.item(i).getChildNodes();
            System.out.println(child.item(0).getTextContent());
            Node item = (Node) xpath.compile(String.format("/channel/item[%s]", i)).evaluate(doc, XPathConstants.NODE);
            String title = xpath.compile("title").evaluate(item);
			System.out.println(title);
			list.add(title);
           
        }
		*/
		/*
		 * 
		 *  
            for (int j = 0; j < child.getLength(); j++) {
                Node node = child.item(j);
                System.out.println("현재 노드 이름 : " + node.getNodeName());
                System.out.println("현재 노드 타입 : " + node.getNodeType());
                System.out.println("현재 노드 값 : " + node.getTextContent());
                System.out.println("현재 노드 네임스페이스 : " + node.getPrefix());
                System.out.println("현재 노드의 다음 노드 : " + node.getNextSibling());
                System.out.println("");		
            }
		 * 
		 * 
		 * 
		
		for (int a = 1; a <= itemList.getLength(); a++) {
			Node item = (Node) xpath.compile(String.format("/channel/item[%s]", a)).evaluate(doc, XPathConstants.NODE);
			String coverLargeUrl = xpath.compile("coverLargeUrl").evaluate(item);
			String title = xpath.compile("title").evaluate(item);
			System.out.println(title);
			list.add(title);
			String author = xpath.compile("author").evaluate(item);
			String publisher = xpath.compile("publisher").evaluate(item);
			String priceStandard = xpath.compile("priceStandard").evaluate(item);
			String description = xpath.compile("description").evaluate(item);
			String pubDate = xpath.compile("pubDate").evaluate(item);
			String isbn = xpath.compile("isbn").evaluate(item);
			String link = xpath.compile("link").evaluate(item);
			String categoryId = xpath.compile("categoryId").evaluate(item);
			String categoryName = xpath.compile("categoryName").evaluate(item);
			//System.out.println(description);

		}
		*/		
		/*
		URL url = new URL(path);
		URLConnection urlcon = url.openConnection();
		
		BufferedReader br = new BufferedReader(new InputStreamReader(urlcon.getInputStream()));
		
		String line = "";
		while((line=br.readLine()) != null){
			System.out.println(line);
		}
		*/
				

		Map<String, List<String>> map = new HashMap<String, List<String>>();
		map.put("list", list);
		
		
		return map;
	}
	
	
	
	
	

}
