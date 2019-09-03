<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: DiamondJ
  Date: 2019/8/26
  Time: 10:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>个人中心</title>
    <link rel="stylesheet" type="text/css" href="/css/myStyle.css">
</head>
<body>


<div class="grzxbj">
    <div class="selfinfo center">
        <div class="lfnav fl">
            <div class="ddzx">订单中心</div>
            <div class="subddzx">
                <ul>
                    <li><a style="color:#ff6700;font-weight:bold;">我的订单</a></li>
                </ul>
            </div>
            <div class="ddzx">导航</div>
            <div class="subddzx">
                <ul>
                    <li><a href="/init/index">返回地图</a></li>
                    <li><a href="/user/logout">注销</a></li>
                </ul>
            </div>
        </div>
        <div class="rtcont fr" style="overflow-y:scroll;">
            <div class="ddzxbt">交易订单</div>
            <div class="ddxq">
                <div class="ddbh fl">&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
                    &emsp;&emsp;&emsp;&emsp;订单号</div>
                <div class="ztxx fr">
                    <ul>
                        <li>订单状态</li>
                        <li>电池借出时间</li>
                        <li>电池归还时间</li>
                        <li>金额(不含押金)</li>
                        <div class="clear"></div>
                    </ul>
                </div>
                <div class="clear"></div>
            </div>
            <c:forEach items="${order}" var="order">
                <div class="ddxq">
                    <div class="ddspt fl"><img src="/images/dianping.jpg"></div>
                    <div class="ddbh fl">${order.order_id}</div>
                    <div class="ztxx fr">
                        <ul>
                            <li><c:if test="${order.order_state==0}">
                                创建</c:if>
                                <c:if test="${order.order_state==1}">
                                已借用</c:if>
                                <c:if test="${order.order_state==2}">
                                已归还</c:if> </li>
                            <li>${order.borrow_time}</li>
                            <li>${order.return_time}</li>
                            <li>${order.order_price}</li>
                            <div class="clear"></div>
                        </ul>
                    </div>
                    <div class="clear"></div>
                </div>
            </c:forEach>
        </div>
        <div class="clear"></div>
    </div>
</div>

</body>
</html>