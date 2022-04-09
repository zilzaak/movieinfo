<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false"  %>
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="<c:url value="/static/theme/bootstrap.min.css" /> " rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css
" rel="stylesheet">
<script src="<c:url value="/static/theme/jquery340.js" />" > </script> 
<script src="<c:url value="/static/theme/popper114.js" />" > </script>
<script src="<c:url value="/static/theme/angular1.8.2.js" />" > </script>
<script src="<c:url value="/static/theme/bootstrap.min.js" />" > </script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.5.3/jspdf.min.js"></script>
<script type="text/javascript" src="https://html2canvas.hertzen.com/dist/html2canvas.js"></script>
<style>
*{
box-sizing:border-box;
}


</style>

<script type="text/javascript">
function createit() {
  var HTML_Width = $(".html-content").width()-10;
    var HTML_Height = $(".html-content").height();
    var top_left_margin = 15;
    var PDF_Width = HTML_Width + (top_left_margin * 2);
    var PDF_Height = (PDF_Width * 1.5) + (top_left_margin * 2);
    var canvas_image_width = HTML_Width;
    var canvas_image_height = HTML_Height;

    var totalPDFPages = Math.ceil(HTML_Height / PDF_Height) - 1;

    html2canvas($(".html-content")[0]).then(function (canvas) {
        var imgData = canvas.toDataURL("image/jpeg", 1.0);
        var pdf = new jsPDF('p', 'pt', [PDF_Width, PDF_Height]);
        pdf.addImage(imgData, 'JPG', top_left_margin, top_left_margin, canvas_image_width, canvas_image_height);
        for (var i = 1; i <= totalPDFPages; i++) { 
            pdf.addPage(PDF_Width, PDF_Height);
            pdf.addImage(imgData, 'JPG', top_left_margin, -(PDF_Height*i)+(top_left_margin*4),canvas_image_width,canvas_image_height);
        }
        var pi= $("#prid").val();
        var r= pi+"animalsellrecord"+".pdf"; 
       pdf.save(r);
        $(".html-content").hide();
    });
}
</script>
</head>
<body>
<button class="btn btn-success" onclick="createit();" style="margin-left:20%;">download</button>
<input type="text"  style="display:none;" id="prid" value="${todays}"/>
<div  class="html-content" style="margin-left:20%;margin-right:8%;
margin-top:15px;text-align:center;
margin-bottom:15px;background-color:floralwhite;border:2px solid black;">
<h4>animal selling records</h4>
<b style="color:maroon;">total record::${tr}         present date::${todays}</b> <br/>
<b style="color:maroon;">total price(tk)::${tp}        total due::${td}</b> <br/>
<div style="font-size:.80em;background-color:aliceblue;margin-left:20%;">
<table class="table table-borderless table-sm table-responsive" border="1" >
<c:forEach items="${cowsellrecord}" var="mr" varStatus="loop">
<tr>
<c:if test="${loop.index==0}">
<td>animal id</td>
<td> price</td>
<td>buyer name</td>
<td>due</td>
<td>buyer phone</td>
<td>selling date</td>
</c:if>
</tr>
</c:forEach>
<c:forEach items="${cowsellrecord}"  var="drug">
<tr>
<td><b>${drug.anid}</b></td>
<td>
<b>type::${drug.sellprice}</b> 
</td>
<td>
<b>gender::${drug.buyername}</b> 
</td>
<td>
<b>species::${drug.due}</b> 
</td>
<td>
<b>gender::${drug.buyercontact}</b> 
</td>
<td>
<b>age (month)::${drug.stringselldate}</b>
</td>
</tr>
</c:forEach>

</table>
</div>

</div>

</body>
</html>