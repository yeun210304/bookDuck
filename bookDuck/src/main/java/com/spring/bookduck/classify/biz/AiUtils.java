package com.spring.bookduck.classify.biz;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.spring.bookduck.classify.dto.AiUtilDto;

import weka.classifiers.Classifier;
import weka.clusterers.ClusterEvaluation;
import weka.clusterers.Clusterer;
import weka.core.Instances;
import weka.core.converters.CSVLoader;
import weka.core.converters.ConverterUtils.DataSource;

public class AiUtils {
	
	private Logger logger = LoggerFactory.getLogger(AiUtils.class);
	
	public String makeWekaData(String id, String age_mw, String book_category, int score, String path) {
		
		String result = "실패";
		
		try {
			String[] age_mw_list = {"10s_man", "10s_woman", "20s_man", "20s_woman", "30s_man", "30s_woman", 
					"40s_man", "40s_woman", "50s_man", "50s_woman", "60s_over_man", "60s_over_woman"};
			
			String[] book_category_list = {"101", "102", "103", "104", "105", "107", "108", "109", "110",
					   "111", "112", "113", "114", "115", "116", "117", "118", "119",
					   "120", "122", "123", "124", "125", "126", "128", "129"};
			
			int age_mw_num = 0;
			int book_category_num = 0;
			
			for(int i = 0; i < age_mw_list.length; i++) {
				if(age_mw_list[i].equals(age_mw)) {
					age_mw_num = i;
				}			
			}
			
			for(int j = 0; j < book_category_list.length; j++) {
				if(book_category_list[j].contains(book_category)) {
					book_category_num = j;
				}
			}
			
			String tpath = path+"resources/testdata/";
			String tpath01 = path+"resources/testdata/"+id+"01.csv";
			
			File file_dir = new File(tpath);
			File file01 = new File(tpath01);
			
			if(!file_dir.exists()) {
				file_dir.mkdir();
			}
			if(file01.exists()) {
				file01.delete();
			}
			if(file01.createNewFile()) {
				logger.info("[AiUtils] : file01 생성 성공");
			} else {
				logger.info("[AiUtils] : file01 생성 실패");
			}
			
			BufferedWriter fw01 = new BufferedWriter(new FileWriter(file01, false));
			
			fw01.write("age_mw,book_category_list,score");
			fw01.newLine();
			fw01.write(age_mw_num+","+book_category_num+","+score);
			fw01.close();		
			
			Clusterer loadModel = (Clusterer) weka.core.SerializationHelper.read(path+"WEB-INF/views/classify/model/cluster.model");
					
			CSVLoader loader = new CSVLoader();
			loader.setSource(new File(tpath01));
			Instances csvdata = loader.getDataSet();
									
			ClusterEvaluation clsEval = new ClusterEvaluation();
			
			clsEval.setClusterer(loadModel);
			clsEval.evaluateClusterer(csvdata);
			
			String[] cluster = clsEval.clusterResultsToString().split("\n");			
			
			String cluster_num = "c"+cluster[cluster.length-1].charAt(1);		
			
			// 위가 첫번째 모델 테스트 파일 만들기 아래가 두번째 모델 테스트 파일 만들기.
			
			String tpath02 = path+"resources/testdata/"+id+"02.arff";
			
			File file02 = new File(tpath02);
			
			if(!file_dir.exists()) {
				file_dir.mkdir();
			}
			if(file02.exists()) {
				file02.delete();
			}
			if(file02.createNewFile()) {
				logger.info("[AiUtils] : file02 생성 성공");
			} else {
				logger.info("[AiUtils] : file02 생성 실패");
			}
			
			BufferedWriter fw02= new BufferedWriter(new FileWriter(file02, false));
			
			fw02.write("@relation test"+id+"01.csv");
			fw02.newLine();
			fw02.newLine();
			fw02.write("@attribute age_mw {10s_man, 10s_woman, 20s_man, 20s_woman, 30s_man, 30s_woman, "
					 +"40s_man, 40s_woman, 50s_man, 50s_woman, 60s_over_man, 60s_over_woman}");
			fw02.newLine();
			fw02.write("@attribute book_category_list {b101, b102, b103, b104, b105, b107, b108, b109, b110, "
					+"b111, b112, b113, b114, b115, b116, b117, b118, b119, b120, b122, b123, b124, b125, b126, b128, b129}");
			fw02.newLine();
			fw02.write("@attribute cluster {c0, c1, c2, c3, c4, c5, c6, c7, c8, c9}");
			fw02.newLine();
			fw02.write("@attribute score {s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10}");
			fw02.newLine();
			fw02.newLine();
			fw02.write("@data");
			fw02.newLine();
			
			for(int i =0; i< book_category_list.length; i++) {
				fw02.write(age_mw+","+"b"+book_category_list[i]+","+cluster_num+","+"s"+(int)(score/10));
				fw02.newLine();			
			}
			
			fw02.close();
			
			if(file02.exists()) {
				result = "성공";
			} else {
				result = "실패";
			}			
			
		} catch (Exception e) {
			e.printStackTrace();
		}		
		return result;		
	}
	
	
	public List<AiUtilDto> predict(String id, String path) {
		
		List<AiUtilDto> list = new ArrayList<AiUtilDto>();
		
		try {
			
			String file_path = path+"resources/testdata/"+id+"02.arff";
			
			DataSource datasource = new DataSource(file_path);
			Instances data = datasource.getDataSet();
			data.setClassIndex(data.numAttributes() -1);
			
			Classifier loadModel = (Classifier) weka.core.SerializationHelper.read(path+"WEB-INF/views/classify/model/classifier.model");
			
			String[] book_category_list = {"101", "102", "103", "104", "105", "107", "108", "109", "110",
					   "111", "112", "113", "114", "115", "116", "117", "118", "119",
					   "120", "122", "123", "124", "125", "126", "128", "129"};
			
			double predModel = 0.0;
			String predString = "";
			
			for(int i = 0; i <book_category_list.length; i++) {
				predModel = loadModel.classifyInstance(data.instance(i));
				predString = data.classAttribute().value((int) predModel);		
				
				AiUtilDto dto = new AiUtilDto();
				dto.setCategory(book_category_list[i]);
				dto.setScore(predString.substring(1));

				list.add(dto);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}		
		
		return list;
	}
	
	
	
	
	
	

}
