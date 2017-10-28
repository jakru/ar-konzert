<%@ page pageEncoding="UTF-8" %><%@ page session="false" isErrorPage="true" contentType="text/html" import="org.opencms.jsp.util.CmsJspStatusBean"%><%
	
	// initialize instance of status bean
	CmsJspStatusBean cms = new CmsJspStatusBean(pageContext, request, response, exception);
	
%><!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title><%= cms.keyStatus("error_message") %></title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>

        * {
            line-height: 1.2;
            margin: 0;
        }

        html {
            color: #888;
            display: table;
            font-family: sans-serif;
            height: 100%;
            width: 100%;
        }

        body {
            display: table-cell;
            vertical-align: middle;
            margin: 2em auto;       
        }

        .wrapper {
            margin: -20px auto 0;
            width: 500px;
        }

        header{
            margin: 0 0 10px;
        }

        h1 {
            color: #555;
            font-size: 2em;
            font-weight: bold;
        }

        h2 {
            font-size: 1.2em;
            font-weight: normal;
        }

        .logo{
            margin: 0 0 20px 0;
            display: block;
            height: 42px;
            width: 170px;    
            text-indent: -9999px;  
            background: url("data:image/png;base64,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") no-repeat;
            background-size: contain;   
        }

        p{
            margin: 5px 0 0;
            font-size: 1.2em;
        }

        p span{
            font-weight: bold;
        }

        footer{
            margin: 10px 0 0;
        }

        footer a{
            font-size: 0.7em;
            color: #888;
            text-decoration: none;
            transition: color 1s;
        }
        footer a:hover{
            color: #b31b34;
            transition: color 1s;
        }


        @media only screen and (max-width: 500px) {

            .wrapper {
                width: 95%;
            }

            h1, h2, .logo {
                font-size: 1.5em;
            }

            .logo{
                width: 100%;
                margin: 0 0 10px;
            }

            h1, h2{
                float: left;
                margin: 0 5px 0 0;
            }

            header:after{
                content: '';
                display: table;
                clear: both;
            }

        }

    </style>
</head>
<body>
    <div class="wrapper">
        <header>
            <a href="http://www.opencms.org/" class="logo">OpenCms</a>		
			<!-- Status error messages start -->
			<h1><%= cms.getStatusCode() %></h1>	<h2><%= cms.keyStatus("error_message") %></h2>
		</header>
		<main>
			<p><%= cms.keyStatus("error_description") %></p>
		</main>
        <footer>
            <a href="http://www.opencms.org/">This server runs OpenCms - the open source content management system</a>
        </footer>
    </div>
</body>
</html>