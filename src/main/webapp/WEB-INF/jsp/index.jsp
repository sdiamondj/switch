<%--
  Created by IntelliJ IDEA.
  User: DiamondJ
  Date: 2019/7/9
  Time: 17:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no, width=device-width">
    <link rel="stylesheet" href="https://a.amap.com/jsapi_demos/static/demo-center/css/demo-center.css" />
    <title>地图</title>
    <style>
        html,
        body,
        #container {
            width: 100%;
            height: 100%;
        }
    </style>
</head>
<body>
<div id="container"></div>
<script src="https://webapi.amap.com/maps?v=1.4.15&key=1f4243c6db75a48d61b178e648b8b2b0ֵ"></script>
<script>
    var map = new AMap.Map('container', {
        resizeEnable: true,
        zoom:10,
        center: [121.3688, 31.1186]
    });
    <c:forEach items="${site}" var="site" varStatus="status">
        var marker${status.index} = new AMap.Marker({
            position: new AMap.LngLat(${site.site_x}, ${site.site_y}),
            title: '${site.site_name}'
        });
        map.add(marker${status.index});
        marker${status.index}.on('click', showInfoM${status.index});
        function showInfoM${status.index}() {
            window.location.href="/site/detail/"+'${site.site_id}';
        }
    </c:forEach>
</script>
</body>
</html>
