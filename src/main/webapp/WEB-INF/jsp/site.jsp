<%--
  Created by IntelliJ IDEA.
  User: DiamondJ
  Date: 2019/7/9
  Time: 17:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>站点详情</title>
    <link rel="stylesheet" type="text/css" href="/css/mi.css">
</head>
<body>
<div class="danpin center">

    <div class="biaoti center">${site.site_name}&emsp;
        当前站点总箱数:${site.box_num}&emsp;可借用箱数:${can}&emsp;可归还箱数:${cannot}
        <a href="/init/index" style="position: relative;left: 200px;color: #007bff">返回地图</a>
    <a href="/user/order" style="position: relative;left: 250px;color: #007bff">个人中心</a>
    </div>
    <c:forEach items="${box}" var="box" varStatus="status">
        <c:if test="${status.count % 5 == 1}">
            <div class="main center mb20">
        </c:if>
            <div class="mingxing fl mb20" style="border:2px solid #fff;width:230px;cursor:pointer;" onmouseout="this.style.border='2px solid #fff'" onmousemove="this.style.border='2px solid red'">
                <div class="sub_mingxing"><a><img src="/images/hellobike.jpg" alt=""></a></div>
                <div class="pinpai"><a style="font-size: 18px;">编号:${box.box_number}</a></div>
                <div class="youhui" style="font-size: 16px;">状态:<c:choose>
                    <c:when test="${box.box_state == 0}">可出租</c:when>
                    <c:when test="${box.box_state == 1}">已借出</c:when>
                    <c:when test="${box.box_state == 2}">充电中</c:when>
                    <c:when test="${box.box_state == 3}">故障</c:when>
                </c:choose></div>
                <div class="jiage"><c:if test="${box.box_state == 0}">
                <a href="/order/borrow/${box.box_id}" style="color: deepskyblue;font-size: 18px;">我要借用</a>
            </c:if>
                <c:if test="${box.box_state == 1}">
                    <c:if test="${sessionScope.user.isDoing == 0}">
                        <a style="color: gold;font-size: 18px;">此箱为空,您无电池可还</a>
                    </c:if>
                    <c:if test="${sessionScope.user.isDoing == 1}">
                        <a href="/order/return/${box.box_id}"  style="color: #5cff2c;font-size: 18px;">此箱为空,我要归还</a>
                    </c:if>
                </c:if>
                <c:if test="${box.box_state == 2 || box.box_state == 3}">
                    <a style="color: red;font-size: 18px;">暂不可用</a>
                </c:if> </div>
            </div>
        <c:if test="${status.count % 5 == 0} ">
            <div class="clear"></div>
            </div>
        </c:if>
    </c:forEach>

</div>

</body>
</html>
