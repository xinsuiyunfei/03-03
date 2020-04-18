<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>�Զ����</title>
		<style type="text/css">
.mouseOver {
	background: #708090;
	color: #FFFAFA;
}

.mouseOut {
	background: #FFFAFA;
	color: #000000;
}
</style>
		<script type="text/javascript">
     	var xmlHttp;
     	var inputField;
     	var popupDiv;
     	var popupBody;
     	//����XMLHttpRequest����
     	function createXMLHttpRequest(){
     		if(window.XMLHttpRequest){
     			xmlHttp = new XMLHttpRequest();
     		}
     		else if(window.ActiveXObject){
     			try{
     				xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
     			}catch(e){
     				try{
     				xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
     				}catch(e){}
     			}
     		}
     	}
     	//����ƥ��������
     	function findModels(){
     		inputField = document.getElementById("model");
     		popupDiv = document.getElementById("popup");
     		popupBody = document.getElementById("popupBody");
     		
     		if(inputField.value==""){
     			clearModels();
     			return;
     		}
     		
     		createXMLHttpRequest();
     		var url = "AutoComplete";
     		var queryStr = "model="+inputField.value;
     		xmlHttp.open("post",url,true);
     		xmlHttp.onreadystatechange = handleResponse;
     		xmlHttp.setRequestHeader("Content-Type"
                          ,"application/x-www-form-urlencoded");
     		xmlHttp.send(queryStr);
     	}
     	//����Զ������
     	function clearModels(){
     		while(popupBody.childNodes.length>0){
     			popupBody.removeChild(popupBody.firstChild);
     		}
     		popupDiv.style.border = "none";
     	}
     	//������Ӧ����
     	function handleResponse(){
     		if(xmlHttp.readyState == 4){
     			if(xmlHttp.status == 200){
     				setModels();
     			}
     		}
     	}
     	//�����Զ������ʾ��
     	function setModels(){
     		clearModels();
     		var models = xmlHttp.responseXML
                                      .getElementsByTagName("model");
     		if(models.length == 0)return;
     		
     		setOffsets();
     		var row,cell,text;
     		for(var i=0;i<models.length;i++){
     			text = document.createTextNode(models[i]
                                              .firstChild.nodeValue);
     			cell = document.createElement("td");
     			row = document.createElement("tr");
     			
     	cell.onmouseover = function(){this.className="mouseOver;"};
     	cell.onmouseout = function(){this.calssName="mouseOut;"};
     	cell.onclick = function(){populateModel(this);};
     			
     			cell.appendChild(text);
     			row.appendChild(cell);
     			popupBody.appendChild(row);
     		}
     	}
     	//д�������
     	function populateModel(cell){
     	inputField.value = cell.firstChild.nodeValue;
     	clearModels();
        }
     	//�����Զ���ʾ�����ʾλ��
     	function setOffsets(){
     		var width = inputField.offsetWidth;
     		var left = getLeft(inputField);
     		var top = getTop(inputField)+inputField.offsetHeight;
     		
     		popupDiv.style.border = "black 1px solid";
     		popupDiv.style.left = left+"px";
     		popupDiv.style.top = top+"px";
     		popupDiv.style.width = width+"px";
     	}
     	//��ȡָ��Ԫ����ҳ���еĿ����ʼλ��
     	function getLeft(elem){
     		var offset = elem.offsetLeft;
     		if(elem.offsetParent!=null)
     			offset += getLeft(elem.offsetParent);
     		return offset;
     	}
   		//��ȡָ��Ԫ����ҳ���еĸ߶���ʼλ��
     	function getTop(elem){
     		var offset = elem.offsetTop;
     		if(elem.offsetParent!=null)
     			offset += getTop(elem.offsetParent);
     		return offset;
     	}	
      </script>
	</head>

	<body>
		<h2>
			Ajax�Զ���ɹ���
		</h2>
		����:
		<input id="model" size="20" style="height: 20;"
			onkeyup="findModels();">
		<input type="button" value="����">

		<div id="popup" style="position: absolute;">
			<table width="100%" bgcolor="#fffafa" cellspacing="0" cellpadding="0">
				<tbody id="popupBody">
				</tbody>
			</table>
		</div>
	</body>
</html>

