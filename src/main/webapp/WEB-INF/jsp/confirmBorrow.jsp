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

    <div class="wdgwc fl ml40">借电池确认</div>
    <div class="wxts fl ml20">温馨提示：所有借用的电池必须要归还哦，否则是无法退押金的呢</div>
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
                <div class="sub_top fl">押金</div>
                <div class="sub_top fl">本次需支付</div>
                <div class="sub_top fr"></div>
                <div class="clear"></div>
            </div>
            <div class="content2 center">
                <div class="sub_content fl ">
                </div>
                <div class="sub_content fl"><img src="/images/dianping.jpg"></div>
                <div class="sub_content fl ft20">${battery.battery_id}
                <input type="hidden" value="${battery.battery_id}" name = "battery_id">
                <input type="hidden" value="${box.site_id}" name = "site_id">
                <input type="hidden" value="${box.box_id}" name = "box_id"></div>
                <div class="sub_content fl ">9元/日</div>
                <div class="sub_content fl">
                    999元
                </div>
                <div class="sub_content fl">999元</div>
                <div class="sub_content fl"></div>
                <div class="clear"></div>
            </div>
        </div>
        <div class="jiesuandan mt20 center">
            <div class="jiesuan fr">
                <div class="jiesuanjiage fl">共需支付:<span>999.00元</span></div>
                <div class="jsanniu fr"><input onclick="return queren()" class="jsan" type="submit" name="jiesuan"  value="确认"/></div>
                <div class="clear"></div>
            </div>
            <div class="clear"></div>
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

