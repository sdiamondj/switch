<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: DiamondJ
  Date: 2019/7/23
  Time: 16:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>借电池确认</title>
    <link rel="stylesheet" type="text/css" href="/css/myStyle.css">
</head>
<body>
<!-- start header -->
<!--end header -->

<!-- start banner_x -->
<div class="banner_x center">
    <a><div class="logo fl"></div></a>

    <div class="wdgwc fl ml40">还池确认</div>
    <div class="wxts fl ml20">选择您要归还的电池</div>
    <div class="dlzc fr">
        <ul>
            <li><a href="/site/detail/${box.site_id}">返回上一级</a></li>
            <li>|</li>
            <li><a href="/init/index">返回地图</a></li>
        </ul>

    </div>
    <div class="clear"></div>
</div>
<div class="xiantiao"></div>
<div class="gwcxqbj">
    <form method="post" action="/order/createNewOrder">
        <div class="gwcxd center">
            <div class="top2 center">
                <div class="sub_top fl">
                </div>
                <div class="sub_top fl">电池编号</div>
                <div class="sub_top fl">单价</div>
                <div class="sub_top fl">已借天数</div>
                <div class="sub_top fl">需支付(非押金)</div>
                <div class="sub_top fr">操作</div>
                <div class="clear"></div>
            </div>
            <c:forEach items="${returnBatteryVOS}" var="returnBatteryVOS">
                <div class="content2 center">
                    <div class="sub_content fl ">
                    </div>
                    <div class="sub_content fl"><img src="/images/dianping.jpg"></div>
                    <div class="sub_content fl ft20">${returnBatteryVOS.battery_id}</div>
                    <div class="sub_content fl ">9元/日</div>
                    <div class="sub_content fl">${returnBatteryVOS.borrow_day}</div>
                    <div class="sub_content fl">${returnBatteryVOS.borrow_day*9}元</div>
                    <div class="sub_content fl"><a href="/order/confirmReturn?box_id=${box.box_id}&battery_id=${returnBatteryVOS.battery_id}&order_price=${returnBatteryVOS.borrow_day*9}">√</a> </div>
                    <div class="clear"></div>
                </div>
            </c:forEach>
        </div>
    </form>
</div>

<script>
    function queren() {
        if(confirm("确认借用吗?")){
            return true;
        }else{
            return false;
        }
    }
</script>
</body>
</html>

