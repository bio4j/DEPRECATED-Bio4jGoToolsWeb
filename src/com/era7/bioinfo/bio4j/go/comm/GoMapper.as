package com.era7.bioinfo.bio4j.go.comm
{
	import com.era7.bioinfo.xml.go.SlimSet;
	import com.era7.communication.interfaces.ServerCallable;
	import com.era7.communication.interfaces.ServerUploadable;
	import com.era7.communication.model.BasicMapper;
	import com.era7.communication.xml.Parameters;
	import com.era7.communication.xml.Request;
	import com.era7.util.debug.Debugger;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLStream;
	import flash.net.URLVariables;
	import flash.net.navigateToURL;
	
	import mx.controls.Alert;
	import mx.controls.DataGrid;
	
	public class GoMapper extends BasicMapper
	{
		
		private var reference:FileReference = null;
		
		public function GoMapper()
		{
			super();
		}
		
		public function downloadGoAnnotation(proteins:XML):void{
			
			var temp:Request = new Request();
			temp.setMethod(RequestList.DOWNLOAD_GO_ANNOTATION_REQUEST);
			
			var params:Parameters = new Parameters();
			params.addParametersContent(proteins);
			params.addParametersContent(<file_name>GoAnnotation</file_name>);
			
			temp.setParameters(params);
			
			var urlRequest:URLRequest = new URLRequest(UrlManager.DOWNLOAD_GO_ANNOTATION_URL);
			
			urlRequest.method = URLRequestMethod.POST;
			var vars:URLVariables = new URLVariables();		
						
			vars.request = temp.toString();
			urlRequest.data = vars; 
			
			navigateToURL(urlRequest,"_self");
			
		}
		
		public function downloadGoSlim(proteins:XML, 
									   slimSet:SlimSet):void{
			
			var temp:Request = new Request();
			temp.setMethod(RequestList.DOWNLOAD_GO_SLIM_REQUEST);
			
			var params:Parameters = new Parameters();
			params.addParametersContent(proteins);
			params.addParametersContent(<file_name>GoSlim</file_name>);
			params.addParametersContent(slimSet.getContent());
			
			temp.setParameters(params);
			
			var urlRequest:URLRequest = new URLRequest(UrlManager.DOWNLOAD_GO_SLIM_URL);
			
			urlRequest.method = URLRequestMethod.POST;
			var vars:URLVariables = new URLVariables();		
			
			//Debugger.appendText(temp.toString(),Debugger.REQUEST_MODE);
			
			vars.request = temp.toString();
			urlRequest.data = vars; 
			
			navigateToURL(urlRequest,"_self");
			
		}
		
		public function getGoAnnotationChartXML(serverUploadable:ServerUploadable):void{
			
			var request:Request = new Request();
			request.setMethod(RequestList.GET_GO_ANNOTATION_CHART_XML_REQUEST);
			
			var parameters:Parameters = new Parameters();
			request.setParameters(parameters);
			
			var fileFilter:FileFilter = new FileFilter("XML files","*.xml");
			
			mainManager.uploadFile(request,serverUploadable,UrlManager.GET_GO_ANNOTATION_CHART_XML_URL,fileFilter);			
			
		}
		
		public function getGoSlimChartXML(serverUploadable:ServerUploadable):void{
			
			var request:Request = new Request();
			request.setMethod(RequestList.GET_GO_SLIM_CHART_XML_REQUEST);
			
			var parameters:Parameters = new Parameters();
			request.setParameters(parameters);
			
			var fileFilter:FileFilter = new FileFilter("XML files","*.xml");
			
			mainManager.uploadFile(request,serverUploadable,UrlManager.GET_GO_SLIM_CHART_XML_URL,fileFilter);
			
		}
		
		public function getGoAnnotationGexf(serverUploadable:ServerUploadable,
											subOntology:String,
											layoutAlgorithm:String,
											layoutAlgorithmTime:String):void{
			
			var request:Request = new Request();
			request.setMethod(RequestList.GET_GO_ANNOTATION_GEXF_REQUEST);
			
			var parameters:Parameters = new Parameters();
			parameters.addParametersContent(<sub_ontology>{subOntology}</sub_ontology>);
			parameters.addParametersContent(<layout_algorithm>{layoutAlgorithm}</layout_algorithm>);
			parameters.addParametersContent(<layout_algorithm_time>{layoutAlgorithmTime}</layout_algorithm_time>);
			request.setParameters(parameters);
			
			var fileFilter:FileFilter = new FileFilter("XML files","*.xml");
			
			mainManager.uploadFile(request,serverUploadable,UrlManager.GET_GO_ANNOTATION_GEXF_URL,fileFilter);			
			
		}
		
		public function getGoAnnotationGexfFromUrl(serverCallable:ServerCallable,
											subOntology:String,
											layoutAlgorithm:String,
											layoutAlgorithmTime:String,
											fileUrl:String):void{
			
			var request:Request = new Request();
			request.setMethod(RequestList.GET_GO_ANNOTATION_GEXF_FROM_URL_REQUEST);
			
			var parameters:Parameters = new Parameters();
			parameters.addParametersContent(<sub_ontology>{subOntology}</sub_ontology>);			
			parameters.addParametersContent(<layout_algorithm>{layoutAlgorithm}</layout_algorithm>);
			parameters.addParametersContent(<layout_algorithm_time>{layoutAlgorithmTime}</layout_algorithm_time>);
			parameters.addParametersContent(<url>{fileUrl}</url>);
			request.setParameters(parameters);
						
			mainManager.loadRequest(request,serverCallable,UrlManager.GET_GO_ANNOTATION_GEXF_FROM_URL_URL);			
			
		}
		
		public function downloadGoAnnotationGexfFromUrl(subOntology:String,
												   layoutAlgorithm:String,
												   layoutAlgorithmTime:String,
												   fileUrl:String):void{
			
			var request:Request = new Request();
			request.setMethod(RequestList.DOWNLOAD_GO_ANNOTATION_GEXF_FROM_URL_REQUEST);
			
			var parameters:Parameters = new Parameters();
			parameters.addParametersContent(<sub_ontology>{subOntology}</sub_ontology>);			
			parameters.addParametersContent(<layout_algorithm>{layoutAlgorithm}</layout_algorithm>);
			parameters.addParametersContent(<layout_algorithm_time>{layoutAlgorithmTime}</layout_algorithm_time>);
			parameters.addParametersContent(<url>{fileUrl}</url>);
			request.setParameters(parameters);						
		
			var urlRequest:URLRequest = new URLRequest(UrlManager.DOWNLOAD_GO_ANNOTATION_GEXF_FROM_URL_URL);
			
			urlRequest.method = URLRequestMethod.POST;
			var vars:URLVariables = new URLVariables();		
			
			vars.request = request.toString();
			urlRequest.data = vars; 
			
			navigateToURL(urlRequest,"_blank");
		}
			
		
	}
}