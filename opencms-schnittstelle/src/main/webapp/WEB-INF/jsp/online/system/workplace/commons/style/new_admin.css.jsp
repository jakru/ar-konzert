<%@ page pageEncoding="UTF-8" %><%@ page import="org.opencms.jsp.*,java.net.*,org.opencms.workplace.*" %>

<%
    // Create a JSP action element 
    CmsJspActionElement cms = new CmsJspActionElement(pageContext,request,response);

    // up to now, the possible styles are "new_admin", "workplace", "menu", "popup" and "onlinehelp"
    String uri = request.getRequestURL().toString();

    // find out the name of the sibling. This is the stylename
    int dot = uri.lastIndexOf('.');
    int sep = uri.lastIndexOf('/');
    int style = 0;
    
    final int WORKPLACE = 0;
    final int NEW_ADMIN = 1;
    final int MENU = 2;
    final int POPUP = 3;
    final int ONLINEHELP = 4;
    
    String stylestring = uri.substring(sep + 1, dot);
    if(stylestring.equals("workplace")) {
      style = WORKPLACE;
    } else if (stylestring.equals("new_admin")) {
      style = NEW_ADMIN;
    } else if (stylestring.equals("menu")) {
      style = MENU;
    } else if (stylestring.equals("popup")) {
      style = POPUP;
    } else if (stylestring.equals("onlinehelp")) {
      style = ONLINEHELP;
    }
               
    /* style definitions valid only for MENU-style */
%>
<% if (style == MENU || style == NEW_ADMIN || style == WORKPLACE) { %>
/* ---------- links ------------ */
.link p {
  display: inline;
  background: none;
  background-color: transparent;
  vertical-align: middle;
  color: /*begin-color WindowText*/#000000/*end-color*/;
  cursor: auto;
  text-decoration: none;
}
.link,
.link a {
  display: inline;
  background: none;
  background-color: transparent;
  cursor: hand;
  cursor: pointer;
  color: /*begin-color WindowText*/#000000/*end-color*/;
  text-decoration: none;
}

.link:hover a,
.link a:hover {
  text-decoration: underline;
  color: /*begin-color TextHover*/#b31b34/*end-color*/;
}

.link:hover img,
.link img:hover { 
  text-decoration: none;
}

.linkdisabled {
  color: /*begin-color GrayText*/#999999/*end-color*/;
  text-decoration: none;
  cursor: default;
}

.link img {
  /*width: 20px;*/
  height: 20px;
  display: inline;
  vertical-align: middle;
  text-decoration: none;
}

/* ---------- list  --------- */
.list {
	border-collapse: collapse;
}
	 
.list td {
  text-align: left;
  vertical-align: middle;
  white-space: nowrap;
}

.list th { 
  vertical-align: middle;
  text-align: center;
  background-color:/*begin-color ThreedFace*/#f0f0f0/*end-color*/; 
  border-right: 1px solid /*begin-color ThreedDarkShadow*/#606161/*end-color*/; 
  border-top: 1px solid /*begin-color ThreeDHighlight*/#ffffff/*end-color*/; 
  border-bottom: 1px solid /*begin-color ThreedDarkShadow*/#606161/*end-color*/; 
  border-left: 1px solid /*begin-color ThreeDHighlight*/#ffffff/*end-color*/; 
} 

.list th a:link, 
.list th a:visited, 
.list th a:active {
  color: /*begin-color WindowText*/#000000/*end-color*/;
  text-decoration: none;
}

.evenrowbg {
	background-color: /*begin-color ButtonFace*/#f0f0f0/*end-color*/; 
}

.oddrowbg {
	background-color: /*begin-color Window*/#ffffff/*end-color*/;
}

.evenrowbgnew {
	background-color: /*begin-color InfoBackground*/#f9f9f9/*end-color*/;
}

.misc {
  text-align: right;
}

.main input {
	margin-right: 7px;
}

.misc input {
  text-align: left;
}

td.listdetailhead {
	vertical-align: top;
	font-size: 10px;
}

td.listdetailitem {
	padding-left: 10px;
	font-size: 10px;
	color: /*begin-color ThreeDShadow*/#999999/*end-color*/;
}

<% } %>

<% if(style == MENU || style == NEW_ADMIN) { %>
body {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 11px;
	font-weight: normal;
	color: /*begin-color WindowText*/#000000/*end-color*/;
   <% if (style == NEW_ADMIN) { %>
	background-color: /*begin-color Window*/#ffffff/*end-color*/;     
	padding-bottom: 20px;
   <% } else {%>
	padding: 0 12px;
	margin: 0;
	background-color: /*begin-color ThreeDFace*/#f0f0f0/*end-color*/; 
	background-image: url(<%=CmsWorkplace.getSkinUri()%>admin/images/border.gif);
	background-position: right;
	background-repeat: repeat-y;
	background-attachment: fixed;
  <% } %>
}

img {
  border: none;
}

/* --- loader ---*/

#loader {
  width: 320px;
  margin-left: auto;
  margin-right: auto;
}

#loader td {
  padding: 0px;
  background: /*begin-color Window*/#ffffff/*end-color*/;
  border: 1px solid black;
}

#loader p {
  border-top: 3px solid /*begin-color ThreeDHighlight*/#ffffff/*end-color*/;
  border-left: 3px solid /*begin-color ThreeDHighlight*/#ffffff/*end-color*/;
  border-right: 3px solid /*begin-color ThreeDShadow*/#999999/*end-color*/;
  border-bottom: 3px solid /*begin-color ThreeDShadow*/#999999/*end-color*/;
  padding: 10px;
  margin: 0;
  background: /*begin-color ThreeDFace*/#f0f0f0/*end-color*/;
}

#loader img {
  float: left;
  margin-right: 12px;
}

#loader strong {
  display: block;
  margin-bottom: 3px;
}

#loaderContainer {
  position: absolute;
  width: 100%;
  height: 100%;
  top: 0;
  left: 0;
  z-index: 2;
  height: expression(document.documentElement.clientHeight+'px');
}

#loaderContainer td {
	padding-top: 150px;
	vertical-align: top;
	text-align: center;
	background-image: url(<%=CmsWorkplace.getSkinUri()%>admin/images/semi-transparent.gif);
}

#loaderContainer td td {
	padding-top: 0px;
	text-align: left;
}

<% } 

   if(style == MENU) { %>

/* navegation area */

#navArea img {
  display: block;
  margin: 0;
}

#navArea {
  padding-top: 12px;
  padding-bottom: 60px;
}

.navOpened,
.navClosed {
  border-top: 2px solid /*begin-color ThreeDHighlight*/#ffffff/*end-color*/;
  border-left: 2px solid /*begin-color ThreeDHighlight*/#ffffff/*end-color*/;
  border-right: 2px solid /*begin-color ThreeDShadow*/#999999/*end-color*/;
  border-bottom: 2px solid /*begin-color ThreeDShadow*/#999999/*end-color*/;
}

#navArea .node img,
#navArea .nodeActive img {
  display: inline;
  vertical-align: middle;
  margin: 0px;
}

/* opened tab */

.navOpened {
  margin-bottom: 15px;
  background-color: /*begin-color ActiveCaption*/#1f232a/*end-color*/;
}

.navTitle,
.navTitleOver {
  cursor: pointer;
  cursor: hand;
  -moz-user-select: none;
}

.titleBorder {
   border: 3px solid /*begin-color ThreeDFace*/#f0f0f0/*end-color*/;  
   border-bottom: 0px solid /*begin-color ThreeDFace*/#f0f0f0/*end-color*/; 
 }

.treeBorder {
   border: 3px solid /*begin-color ThreeDFace*/#f0f0f0/*end-color*/;  
 }

.navOpened .navTitle,
.navOpened .navTitleOver {
  height: 22px;
}

.navOpened .navTitle .titleText {
  font-weight: bold;
  vertical-align: middle;
  color: /*begin-color CaptionText*/#ffffff/*end-color*/;
}

.navOpened .navTitleOver .titleText {
  font-weight: bold;
  vertical-align: middle;
  color: /*begin-color InactiveCaptionText*/#f0f0f0/*end-color*/;
}

.navClosed {
  background-position: right;
  background-repeat: repeat-y;
  margin-bottom: 15px;
  background-color: /*begin-color InactiveCaption*/#999999/*end-color*/;
}

.navClosed .navTitle,
.navClosed .navTitleOver {
  height: 22px;
}

.navClosed .navTitle .titleText,
.navClosed .navTitleOver .titleText {
  font-weight: bold;
  vertical-align: middle;
}

.titleText {
  padding-left: 20px;
  padding-top: 3px;
}

.navClosed .navTitle .titleText {
  color: /*begin-color InactiveCaptiontext*/#f0f0f0/*end-color*/;
}

.navClosed .navTitleOver .titleText {
  color: /*begin-color CaptionText*/#ffffff/*end-color*/;
}

div.tree {
  padding: 2px;
  padding-top: 3px;
  padding-bottom: 10px;
  background-color: /*begin-color Window*/#ffffff/*end-color*/; 
  border: 1px solid /*begin-color WindowText*/#000000/*end-color*/;
}

.navOpened .tree {
  display: block;
}

.navClosed .tree {
  display: none;
}

.node,
.nodeActive {
  padding-top: 4px;
  padding-left: 5px;
  vertical-align: middle;
}

#contexthelp {
  height: 100px;
  width: 164px;
  overflow: hidden;
}

<% /* style definitions valid only for NEW_ADMIN style */ %>
<% } else if(style == NEW_ADMIN) { %>

body, form {
  margin: 0;
  padding: 0;
}

.inputButton{
  background-color: #D4D0C8;
  padding: 1px 9px 1px 9px;
  text-align: center;
  /* for firefox:*/
  /* border: 2px solid #808080; */
  /* for ie:*/
  border: 2px solid #C0C0C0; 
  border-style: outset;
  margin-right: 1px;
  font-family: Arial, Helvetica, sans-serif; 
  font-size: 9pt; 
  text-decoration: none;
  color: black;    
}
 
.pathbar {
   padding-top: 10px;
   padding-left: 10px;
   background-color: /*begin-color ThreeDFace*/#f0f0f0/*end-color*/;
}

/* hiding first nav level in new workplace ui */
.legacy-app .pathbar > :first-child{
	display: none;
}

.screenBody {
  margin: 0 10px;
}

.uplevel {
  text-align: right;
}

.screenTitle {
  margin: 0;
  vertical-align: middle;
  background-color: /*begin-color ThreeDFace*/#f0f0f0/*end-color*/;
  border-bottom: 1px solid /*begin-color ActiveBorder*/#f0f0f0/*end-color*/;
}

.screenTitle td {
  padding: 3px 12px 5px 11px;
  vertical-align: middle;
  font-size: 18px;
  font-family: Verdana, Arial, Helvetica, sans-serif;
  color: /*begin-color WindowText*/#000000/*end-color*/;
}

/* hiding up button in new workplace ui */
.legacy-app .screenTitle td.uplevel {
	display: none;
}

/* adjusting margins in new workplace ui */
.legacy-app .screenTitle td:first-child, .legacy-app .pathbar {
	padding-left:20px;
}

.legacy-app .dialogcontent {
	width: auto;
	margin-left: 20px;
	margin-right: 20px;
}


p, hr {
  margin: 5px 0;
}

hr {
  clear: both;
}

.toolsArea {
  padding: 8px 0 0 0;
}

.iconblock {
    margin: auto; 
    width: 95%;
}

/* ---------- big icon buttons  --------- */
.bigLink {
  width: 128px;
  height: 62px;
  float: left;
  text-align: center;
  padding-top: 5px;
  padding-bottom: 2px;
  padding-right: 2px;
  padding-left: 2px;
}

.bigLink .link img {
  width: 32px;
  height: 32px;
  display: inline;
  vertical-align: middle;
  padding-bottom: 1px;
  padding-right: 1px;
  padding-left: 1px;
  text-decoration: none;
}

<%
/* style definitions valid for WORKLACE, NEW_ADMIN and POPUP style */
} if(!(style == MENU) && !(style == ONLINEHELP)) { 
%>

/* Default font settings for all standard p, td elements */
p, td, div, span {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 11px;
}

/* Default font settings for all form elements */
input, select, option, textarea {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 11px;
}

/* headline of dialog window */
.dialoghead {
   <% if(style == POPUP || style==NEW_ADMIN) { %>
	visibility: hidden;
	display: none;   
	<% } else if(style == WORKPLACE) { %>
	background-color: /*begin-color ActiveCaption*/#1f232a/*end-color*/;
	<% } %>
	margin-bottom: 8px;
	padding: 2px;
	color: /*begin-color CaptionText*/#ffffff/*end-color*/;
	font-size: 12px;
	font-weight: bold;
	white-space: nowrap;	
}


/* outer table of complete dialog window */
table.dialog {
	<% if(style == POPUP || style == NEW_ADMIN) { %>
	margin: auto;
	width: 100%;
	<% } else if(style == WORKPLACE) { %>
        margin: 20px auto;
	width: 85%;
	border-left: 1px solid /*begin-color ThreeDLightShadow*/#f0f0f0/*end-color*/;
	border-top: 1px solid /*begin-color ThreeDLightShadow*/#f0f0f0/*end-color*/;
	border-right: 1px solid /*begin-color ThreedDarkShadow*/#606161/*end-color*/;
	border-bottom: 1px solid /*begin-color ThreedDarkShadow*/#606161/*end-color*/;
   <% } %>
}

body.dialogpopup {
	margin: 0 auto;
	<% if(!(style == NEW_ADMIN)) { %>
	background-color: /*begin-color ThreeDFace*/#f0f0f0/*end-color*/;
	<% } %>
}

/* inner table of complete dialog window */
table.dialogbox {
	width: 100%;
	<% if(!(style == NEW_ADMIN)) { %>
	background-color: /*begin-color ThreeDFace*/#f0f0f0/*end-color*/;
	<% } %>
	<% if(style == NEW_ADMIN) { %>
	padding-top: 10px;	
	<% } %>
        <% if(style == WORKPLACE) { %>
	background-color: /*begin-color ThreeDFace*/#f0f0f0/*end-color*/;
	border-left: 1px solid /*begin-color ThreeDHighlight*/#ffffff/*end-color*/;
	border-top: 1px solid /*begin-color ThreeDHighlight*/#ffffff/*end-color*/;
	border-right: 1px solid /*begin-color ThreeDShadow*/#999999/*end-color*/;
	border-bottom: 1px solid /*begin-color ThreeDShadow*/#999999/*end-color*/;
	padding-top: 1px;	
	<% } %>
}

/* Button - Horizontal Separator line */
.horseparator {
	width: 100%;
	<% if(!(style == NEW_ADMIN)) { %>
	background-color: /*begin-color ThreeDHighlight*/#ffffff/*end-color*/;
	<% } %>
	border-top: 1px solid /*begin-color ThreeDShadow*/#999999/*end-color*/;
}

body.dialog {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 11px;
	padding: 0;
	margin: 0;
	<% if(style == POPUP) { %>
	background-color: /*begin-color ThreeDFace*/#f0f0f0/*end-color*/;
	<% } %>
}

/* Button - Text button wrapper  */
span.txtbutton {
	display: block;
	height: 17px;
	white-space: nowrap;
	padding-top: 3px;
	padding-left: 5px;
	padding-right: 5px;
}

/* Button - Image button wrapper */
span.imgbutton {
	padding-left: 1px;
	padding-right: 5px;
}

/* Button - Combined image and text button wrapper */
span.combobutton {
	display: block;
	height: 17px;
	white-space: nowrap;
	padding-top: 3px;
	padding-left: 21px;
	padding-right: 5px;
	background-repeat: no-repeat;
}

/* Button - Image button in image style */
img.button {
	height: 20px;
	width: 20px;
	border: none;
	vertical-align: middle;
}

/* Button - Link (href) style */
a.button {
	color: /*begin-color ButtonText*/#000000/*end-color*/;
	text-decoration: none;
	cursor: pointer;
}

/* Button - Normal style (inactive) */
span.norm {
	display: block;
	border: 1px solid transparent;
}

/* Button - Hover style */
span.over {
	display: block;
	border-top: 1px solid /*begin-color ThreeDHighlight*/#ffffff/*end-color*/;
	border-left: 1px solid /*begin-color ThreeDHighlight*/#ffffff/*end-color*/;
	border-bottom: 1px solid /*begin-color ThreeDShadow*/#999999/*end-color*/;
	border-right: 1px solid /*begin-color ThreeDShadow*/#999999/*end-color*/;
}

/* Button - Push style */
span.push {
	display: block;
	border-top: 1px solid /*begin-color ThreeDShadow*/#999999/*end-color*/;
	border-left: 1px solid /*begin-color ThreeDShadow*/#999999/*end-color*/;
	border-bottom: 1px solid /*begin-color ThreeDHighlight*/#ffffff/*end-color*/;
	border-right: 1px solid /*begin-color ThreeDHighlight*/#ffffff/*end-color*/;
}

/* Button - Disabled style */
span.disabled {
	display: block;
	border: 1px solid /*begin-color ThreeDFace*/#f0f0f0/*end-color*/;
	color: /*begin-color GrayText*/#999999/*end-color*/;
}

/* Button - Tart tab */
span.starttab {
	display: block;
	height: 16px;
	width: 1px;
	border-top: 1px solid /*begin-color ThreeDHighlight*/#ffffff/*end-color*/;
	border-left: 1px solid /*begin-color ThreeDHighlight*/#ffffff/*end-color*/;
	border-bottom: 1px solid /*begin-color ThreeDShadow*/#999999/*end-color*/;
	border-right: 1px solid /*begin-color ThreeDShadow*/#999999/*end-color*/;
}

/* Button - Separator */
span.separator {
	display: block;
	height: 18px;
	width: 0px;
	border-top: 0px;
	border-left: 1px solid /*begin-color ThreeDShadow*/#999999/*end-color*/;
	border-bottom: 0px;
	border-right: 1px solid /*begin-color ThreeDHighlight*/#ffffff/*end-color*/;
}

/* final button row of dialog window.*/
.dialogbuttons {
	padding: 3px 8px 5px;
	text-align: center;
	<% if(style == NEW_ADMIN) { %>
	background: #ffffff;
	border-top: 1px solid #cccccc;
	border-bottom: 1px solid #cccccc;
	<% } %>
}


/* Subheadline used in content area */
.dialogsubheader {
	font-weight: bold;
	margin: 12px 0 5px 0;
}

.dialogcontent {
	<% if(!(style == NEW_ADMIN)) { %>
	border-left: 1px solid /*begin-color ThreeDHighlight*/#ffffff/*end-color*/;
	border-top: 1px solid /*begin-color ThreeDHighlight*/#ffffff/*end-color*/;
	border-right: 2px solid /*begin-color ThreeDShadow*/#999999/*end-color*/;
	border-bottom: 2px solid /*begin-color ThreeDShadow*/#999999/*end-color*/;
	margin: 8px;
	padding: 15px;
	<% } %>
	<% if(style == NEW_ADMIN) { %>
    width: 95%;
    margin: auto;
	<% } %>
}

/* one content line of dialog (e.g. text and input field) without breaks */
.dialogrow {
	margin-bottom: 5px;
	display: block;
	white-space: nowrap;
}

/* 3D block main style */
fieldset.dialogblock {
	margin: 0;
	padding: 8px;
}

fieldset.dialogblock span {
	color: /*begin-color WindowText*/#000000/*end-color*/;
}

/* outer border of white inner box */
.dialoginnerboxborder {
	border-left: 1px solid /*begin-color ThreeDShadow*/#999999/*end-color*/;
	border-top: 1px solid /*begin-color ThreeDShadow*/#999999/*end-color*/;
	border-right: 1px solid /*begin-color ThreeDHighlight*/#ffffff/*end-color*/;
	border-bottom: 1px solid /*begin-color ThreeDHighlight*/#ffffff/*end-color*/;
	padding: 0;
}

/* white inner box for dialogs */
.dialoginnerbox {
   <% if(style != NEW_ADMIN) { %>
	background-color: /*begin-color Window*/#ffffff/*end-color*/;
   <% } %>
	border-left: 1px solid /*begin-color ThreedDarkShadow*/#606161/*end-color*/;
	border-top: 1px solid /*begin-color ThreedDarkShadow*/#606161/*end-color*/;
	border-right: 1px solid /*begin-color ThreeDLightShadow*/#f0f0f0/*end-color*/;
	border-bottom: 1px solid /*begin-color ThreeDLightShadow*/#f0f0f0/*end-color*/;
	padding: 2px;
}

/* separator line */
.dialogseparator {
	border-top: 1px solid /*begin-color ThreeDShadow*/#999999/*end-color*/;
	border-bottom: 1px solid /*begin-color ThreeDHighlight*/#ffffff/*end-color*/;
	margin: 5px 0;
}

/* separator line */
.dialogspacer {
	height: 10px;
}

/* error messages style */
.dialogerror {
	color: #c03;
}


/* Submit and other buttons */
input.dialogbutton {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 11px;
   <% if(style != NEW_ADMIN) { %>
	background-color: /*begin-color ButtonFace*/#f0f0f0/*end-color*/;
   <% } %>
	width: 100px;
	height: 20px;
	padding: 0 5px;
	margin-left: 12px;
	overflow: visible;
}

/* Special input field for property dialog */
input.dialogmarkedfield {
	width: 100%;
	background-color: #E9E9E9;
}

/* row marked as selected */
.dialogmarked {
	background-color: /*begin-color ActiveCaption*/#1f232a/*end-color*/;
	color: /*begin-color CaptionText*/#ffffff/*end-color*/;
	display: block;
	cursor: pointer;
	white-space: nowrap;
}

/* an unmarked row */
.dialogunmarked {
	display: block;
	cursor: pointer;
	white-space: nowrap;
}

/* empty dummy style */
.empty {}

/* bold text */
.textbold {
	font-weight: bold;
}

/* centered text */
.textcenter {
	text-align: center;
}

/* The checkboxes in property dialogs. */
table tr td.propertydialog-checkboxcell {
	padding-left:4px;
}

/* maximum width for td, input field, etc. */
.maxwidth {
	width: 100%;
}

/* no border for elements */
.noborder {
	border-style: none;
}

/* element without margin and padding */
.nomargin {
	padding: 0;
	margin: 0;
}

/* hide a block */
.hide {
	display: none;
	visibility: hidden;
}

/* show a block */
.show {
	display: inline;
	visibility: visible;
}

/* special definitions for permission dialog */
table.dialogpermissiondetails {
	table-layout: fixed;
	width: 420px;
	margin-left: 15px;
}

td.dialogpermissioncell {
	width: 140px;
	overflow: hidden;
}

div.dialogpermissioninherit {
	width: 420px;
	overflow: auto;
	margin-left: 17px;
}

/* definitions for "tab-style" dialogs */
.dialogtab {
	border-top: 1px solid /*begin-color ThreeDHighlight*/#ffffff/*end-color*/;
	border-left: 1px solid /*begin-color ThreeDHighlight*/#ffffff/*end-color*/;
	border-right: 2px solid /*begin-color ThreeDShadow*/#999999/*end-color*/;
	background-color: /*begin-color ThreeDFace*/#f0f0f0/*end-color*/;
	text-align: center;
	color: #000;
	white-space: nowrap;
}

.dialogtabactive {
	border-top: 2px solid /*begin-color ThreeDHighlight*/#ffffff/*end-color*/;
	border-left: 2px solid /*begin-color ThreeDHighlight*/#ffffff/*end-color*/;
	border-right: 2px solid /*begin-color ThreeDShadow*/#999999/*end-color*/;
	background-color: /*begin-color ThreeDFace*/#f0f0f0/*end-color*/;
	text-align: center;
	color: /*begin-color CaptionText*/#ffffff/*end-color*/;
	font-weight: bold;
	white-space: nowrap;
}

.dialogtabstart {
	padding: 15px;
	margin: 8px;
}

.dialogtabrow {
	height: 1px;
	<% if(!(style == NEW_ADMIN)) { %>
	background-color: /*begin-color ThreeDHighlight*/#ffffff/*end-color*/;
	<% } %>
}

.dialogtabcontent {
	border-left: 1px solid /*begin-color ThreeDHighlight*/#ffffff/*end-color*/;
	border-right: 2px solid /*begin-color ThreeDShadow*/#999999/*end-color*/;
	border-bottom: 2px solid /*begin-color ThreeDShadow*/#999999/*end-color*/;
	padding: 15px;
	margin-top: -1px;
}

a.tab {
	color: /*begin-color WindowText*/#000000/*end-color*/;
	text-decoration: none;
	display: block;
	padding: 4px;
}

a.tab:hover {
	color: /*begin-color GrayText*/#999999/*end-color*/;
}

span.tabactive {
	color: /*begin-color WindowText*/#000000/*end-color*/;
	text-decoration: none;
	display: block;
	padding: 4px;
}

<% if(!(style == NEW_ADMIN)) { %>
body.report {
	background-color: /*begin-color Window*/#ffffff/*end-color*/;
}
<% } %>

/* style definitions for WORKPLACE only */
<% } if(style == WORKPLACE) { %>

/* classes used only on the login screen */
table.logindialog {
    margin: 20px auto;
	width: 550px;
	border-left: 1px solid /*begin-color ThreeDLightShadow*/#f0f0f0/*end-color*/;
	border-top: 1px solid /*begin-color ThreeDLightShadow*/#f0f0f0/*end-color*/;
	border-right: 1px solid /*begin-color ThreedDarkShadow*/#606161/*end-color*/;
	border-bottom: 1px solid /*begin-color ThreedDarkShadow*/#606161/*end-color*/;
}

div.loginsecurity {
	border-bottom: 1px solid /*begin-color ThreeDHighlight*/#ffffff/*end-color*/;
	padding-bottom: 10px;
	margin-bottom: 10px;
}

input.loginbutton {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 11px;
	background-color: /*begin-color ButtonFace*/#f0f0f0/*end-color*/;
	width: 148px;
	height: 23px;
	padding: 0 5px;
	margin: 0px;
	overflow: visible;
}

#ouSelId {
	padding: 6px 4px;
	min-width: 300px;
	max-width: 420px;
	min-height: 100px;
	max-height: 250px;
	overflow: auto;
	background-color: /*begin-color InfoBackground*/#f9f9f9/*end-color*/;
	border: 2px inset /*begin-color ButtonFace*/#f0f0f0/*end-color*/;
}

#ouSelId div {
	margin-bottom: 6px;
	padding: 4px;
	background-color: /*begin-color Window*/#ffffff/*end-color*/;
	border: 1px solid /*begin-color ButtonShadow*/#999999/*end-color*/;
	cursor: pointer;
}

#ouSelId div:hover, #ouSelId div.active:hover {
	background-color: #a8adb4;
}

#ouSelId div.active {
	background-color: #003082;
}

#ouSelId div span.name {
	display: block;
	font-size: 12px;
	font-weight: bold;
	color: /*begin-color InfoText*/#ffffff/*end-color*/;
	padding-bottom: 2px;
}

#ouSelId div span.path {
	display: block;
	color: /*begin-color GrayText*/#999999/*end-color*/;
	font-size: 11px;
	font-style: italic;
	overflow: hidden;
}

#ouSelId div:hover span.name, #ouSelId div:hover span.path, #ouSelId div.active span.name, #ouSelId div.active span.path {
	color: /*begin-color HighlightText*/#ffffff/*end-color*/;
}

#ouSearchId input.inactive {
	color: /*begin-color GrayText*/#999999/*end-color*/;
}

.timewarp {
	border: 1px solid #000066; 
	background: #990000; 
	color: white; 
	padding: 2px 4px 2px 4px;
	margin-left:8px;
}

/* style definitions for WORKPLACE and NEW_ADMIN style */
<% } if(style == WORKPLACE || style == NEW_ADMIN) { %>

 /* Body used for workplace head (top_head.html) */
body.buttons-head {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 11px;
	padding: 0px;
	margin: 0px;
	background-color: /*begin-color ThreeDFace*/#f0f0f0/*end-color*/;
	border-top: 1px solid /*begin-color ThreeDHighlight*/#ffffff/*end-color*/;
	border-left: 1px solid /*begin-color ThreeDHighlight*/#ffffff/*end-color*/;
	border-bottom: 1px solid /*begin-color ThreeDShadow*/#999999/*end-color*/;
	border-right: 1px solid /*begin-color ThreeDShadow*/#999999/*end-color*/;
}

/* Body used for workplace foot (top_foot.html) */
body.buttons-foot {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 11px;
	padding: 0px;
	margin: 0px;
	background-color: /*begin-color ThreeDFace*/#f0f0f0/*end-color*/;
	border-top: 1px solid /*begin-color ThreeDLightShadow*/#f0f0f0/*end-color*/;
	border-left: 1px solid /*begin-color ThreeDHighlight*/#ffffff/*end-color*/;
	border-bottom: 1px solid /*begin-color ThreeDShadow*/#999999/*end-color*/;
	border-right: 1px solid /*begin-color ThreeDShadow*/#999999/*end-color*/;
}

/* ########## Dialog styles ########## */

body.dialogadmin {
	margin-top: 0;
	margin-left: auto;
	margin-right: auto;
	/*background-color: /*begin-color Window*/#ffffff/*end-color*/;
	border-top: 1px solid /*begin-color ThreedDarkShadow*/#606161/*end-color*/;*/
}

.texteditor {
	font-family: fixedsys, monospace, sans-serif;
	font-size: 11px;
}

.buttonbackground {
	border-top: 1px solid /*begin-color ThreeDHighlight*/#ffffff/*end-color*/;
	border-left: 1px solid /*begin-color ThreeDHighlight*/#ffffff/*end-color*/;
	border-right: 1px solid /*begin-color ThreeDShadow*/#999999/*end-color*/;
	border-bottom: 1px solid /*begin-color ThreeDShadow*/#999999/*end-color*/;
	padding: 1px;
	background-color: /*begin-color ThreeDFace*/#f0f0f0/*end-color*/;	
}

.editorbuttonbackground {<%
	if (style == NEW_ADMIN) { %>
	border-top: 1px solid /*begin-color ThreeDHighlight*/#ffffff/*end-color*/;
	border-left: 1px solid /*begin-color ThreeDHighlight*/#ffffff/*end-color*/;
	border-right: 1px solid /*begin-color ThreeDShadow*/#999999/*end-color*/;
	border-bottom: 1px solid /*begin-color ThreeDShadow*/#999999/*end-color*/;
	padding: 1px;
	background-color: /*begin-color ThreeDFace*/#f0f0f0/*end-color*/;<% } %>
}

/* definitions for xmlcontent editor form */
.xmlTable { 
	width:100%; 
}

.xmlTableNested { 
	width:100%;
	border: 2px outset /*begin-color ThreeDHighlight*/#ffffff/*end-color*/;
}

.xmlTd    { 
	width: 100%; 
	height: 22px;
	padding: 3px;
}

.xmlTdDisabled {
	font-style: italic; 
	border-right: 1px dotted /*begin-color ThreeDShadow*/#999999/*end-color*/;
	padding: 3px;
}

.xmlTdErrorHeader {
	font-size: 14px;
	font-weight: bold;
	color: #B40000;
	text-align: center;
}

.xmlTdError {
	font-style: normal;
	font-weight: bold;
	color: #B40000;
	padding: 3px;
}

.xmlTdWarning {
	font-style: normal;
	font-weight: bold;
	color: #EE7700;
	padding: 3px;
}

.xmlLabel { 
	white-space: nowrap;
}

.xmlLabelDisabled {
	font-style: italic; 
	white-space: nowrap;
}

.xmlInput { 
	border: 1px solid /*begin-color WindowFrame*/#000000/*end-color*/;<%
	if (style == NEW_ADMIN) { %>
	margin: 0;
	padding: 0;<% } %>
}

.xmlInputError {
	background-color: #FFCCCC;
}

.xmlInputSmall { 
	width: 200px; 
	border: 1px solid /*begin-color WindowFrame*/#000000/*end-color*/; 
}

.xmlInputMedium { 
	width: 400px;
	border: 1px solid /*begin-color WindowFrame*/#000000/*end-color*/;
}

.xmlHtmlGallery {
	overflow: auto;
	border: 1px solid /*begin-color WindowFrame*/#000000/*end-color*/;<%
	if (style == NEW_ADMIN) { %>
	margin: 0;
	padding: 0;<% } %>
}

.xmlButtons {
	color: /*begin-color WindowText*/#000000/*end-color*/; 
	position: absolute; 
	top: 0px; 
	left: 0px; 
	width: 90px; 
	border-top: 1px solid /*begin-color ThreeDHighlight*/#ffffff/*end-color*/;
	border-left: 1px solid /*begin-color ThreeDHighlight*/#ffffff/*end-color*/;
	border-right: 1px solid /*begin-color ThreeDShadow*/#999999/*end-color*/;
	border-bottom: 1px solid /*begin-color ThreeDShadow*/#999999/*end-color*/;
	padding: 2px;
	background-color: /*begin-color ThreeDFace*/#f0f0f0/*end-color*/; 
	visibility: hidden; 
	font-size: 8pt;
}

div.xmlChoiceItem {
	cursor: pointer;
	background-color: /*begin-color Window*/#ffffff/*end-color*/;
	border: 1px solid /*begin-color ButtonShadow*/#999999/*end-color*/;
	margin: 6px 0;
	padding: 4px;
	font-weight: bold;
}

div.xmlChoiceHelp {
	padding-top: 2px;
	color: /*begin-color GrayText*/#999999/*end-color*/;
	font-style: italic;
	font-weight: normal;
}

div.xmlChoiceItem:hover, div.xmlChoiceItem:hover div.xmlChoiceHelp {
	background-color: #a8adb4;
	color: /*begin-color HighlightText*/#ffffff/*end-color*/;
}

.textInput {<%
	if (style != NEW_ADMIN) { %>
	width: 100%;
	<% } else { %>
	width: 99.9%;
        <% } %>
}

div.widgetcombo {
    position: absolute;
    top: 0px;
    left: 0px;
    padding: 0px;
    width: 300px;
    overflow: hidden;
    border: 1px solid /*begin-color WindowFrame*/#000000/*end-color*/; 
    background-color: /*begin-color Window*/#ffffff/*end-color*/;
    visibility: hidden;
}

button.widgetcombobutton {
	height: 17px;
	width: 17px;
}

div.widgetcombo a {
	text-decoration: none;
	display:block;
	background-color: /*begin-color Window*/#ffffff/*end-color*/;
	color: /*begin-color WindowText*/#000000/*end-color*/;
	width: 100%;
}

div.widgetcombo a:hover {
	background-color: /*begin-color Highlight*/#1f232a/*end-color*/;
	color: /*begin-color HighlightText*/#ffffff/*end-color*/;
}

<% } 

   if (style == ONLINEHELP) { %>
   
body, h1, h2, h3, h4, h5, h6, p, td, caption, th, ul, ol, dl, li, dd, dt {
	font-family: Verdana, Arial, Helvetica, sans-serif; 
	color: /*begin-color WindowText*/#000000/*end-color*/; 
	font-size: 11px;
}

body { 
	background-color: /*begin-color Window*/#ffffff/*end-color*/;
	margin: 0;
	padding: 0;
}

pre	{ 
	font-family: Courier, monospace; 
	font-size: 11px; 
	margin-left: 6px; 
}

h1          { font-size: 18px; margin-top: 5px; margin-bottom: 1px }	
h2          { font-size: 14px; margin-top: 15px; margin-bottom: 3px }
h3          { font-size: 12px; margin-top: 15px; margin-bottom: 3px }
h4          { font-size: 12px; margin-top: 15px; margin-bottom: 3px; font-style: italic }
p           { margin-top: 10px; margin-bottom: 10px }
ul	     	{ margin-top: 2px; margin-bottom: 2px }
li	     	{ margin-top: 2px; margin-bottom: 2px } 
ol	     	{ margin-top: 2px; margin-bottom: 2px }
strong	    { font-weight: bold; }
.definition	{ margin-top: 0px; margin-left: 30px; margin-bottom: 0px; margin-right: 0px; }

/* common links (navigation and page) */
a, a:link, a:visited {
	color: #CC0000; 
	text-decoration: none;
}

a:hover, a:active { 
	text-decoration: underline;
}

/* main content table */
table.helpcontent {
	width: 100%;
	height: 100%;
	empty-cells: show;
}

/* navigation cell */
td.helpnav { 
	background-color: /*begin-color ThreeDFace*/#f0f0f0/*end-color*/; 
	border-right: 1px solid /*begin-color ThreeDShadow*/#999999/*end-color*/; 
	padding: 5px;
	vertical-align: top;
	width: 30%;
}

/* content cell */
td.helpcontent { 
	background-color: /*begin-color Window*/#ffffff/*end-color*/; 
	padding: 5px 5px 5px 15px; 
	vertical-align: top;
	width: 70%;
}

/* navigation headline */
a.navhelphead, a.navhelphead:link, a.navhelphead:visited {
	-moz-box-sizing: border-box; 
	color: #000000;
	background-color: /*begin-color ThreeDFace*/#f0f0f0/*end-color*/; 
	width: 100%; 
	margin-bottom: 5px; 
	padding: 2px; 
	display: block; 
	text-align: left; 
	border: 1px solid /*begin-color WindowFrame*/#000000/*end-color*/;
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 11px;
	text-decoration: none;
}

a.navhelphead:hover, a.navhelphead:active {
	color: /*begin-color TextHover*/#b31b34/*end-color*/;
	text-decoration: underline;
}

/* navigation links */
/* common links (navigation and page) */
a.navhelp, a.navhelp:link, a.navhelp:visited {
	color: #000000; 
	text-decoration: none;
}

a.navhelp:hover, a.navhelp:active {
	color: /*begin-color TextHover*/#b31b34/*end-color*/;
	text-decoration: underline;
}

.navhelp {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 11px;
	float: left;
	background-image: url(<%=cms.link("/system/modules/org.opencms.workplace.help/resources/nav_i.gif")%>);
	padding-left: 10px; 
  background-position: 0px 1px;
	background-repeat:no-repeat;
}

/* current navigation item */
.navhelpcurrent {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 11px;
	float: left;
	background-image: url(<%=cms.link("/system/modules/org.opencms.workplace.help/resources/nav_a.gif")%>);
	background-repeat:no-repeat;
}

/* error messages style */
.dialogerror {
	color: #c03;
	background-color: /*begin-color infobackground*/#f9f9f9/*end-color*/;
	border: 1px solid /*begin-color threedshadow*/#999999/*end-color*/;
	padding: 4px;
	display:block;
}
	
.searchResult {
	color: #000000; 
	font-weight:bold;
	background-color: /*begin-color infobackground*/#f9f9f9/*end-color*/;
	border: 1px solid /*begin-color threedshadow*/#999999/*end-color*/;
	padding: 4px;
	margin-bottom:4px;
	display:block;
}
 
.searchExcerpt {
	color: #999999; 
	font-weight:normal;
	background-color: /*begin-color infobackground*/#f9f9f9/*end-color*/;
	border: 0;
	padding: 4px;
	display:block;
}
 
<% }
   // for ONLINEHELP and NEW_ADMIN (search results)
   if (style == ONLINEHELP || style == NEW_ADMIN) { %>
.searchResult {
	color: #000000; 
	font-weight:bold;
	background-color: /*begin-color infobackground*/#f9f9f9/*end-color*/;
	border: 1px solid /*begin-color threedshadow*/#999999/*end-color*/;
	padding: 4px;
	margin-bottom:4px;
	display:block;
}
 
.searchExcerpt {
	color: #999999; 
	font-weight:normal;
	background-color: /*begin-color infobackground*/#f9f9f9/*end-color*/;
	border: 0;
	padding: 4px;
	display:block;
}
/* navigation links and search result links for online help */
/* search result links for  new admin searchindex tool */
a.navhelp, a.navhelp:link, a.navhelp:visited {
	color: #000000; 
	text-decoration: none;
}

a.navhelp:hover, a.navhelp:active {
	color: /*begin-color TextHover*/#b31b34/*end-color*/;
	text-decoration: underline;
}

.navhelp {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 11px;
	float: left;
	background-image: url(<%=cms.link("/system/modules/org.opencms.workplace.help/resources/nav_i.gif")%>);
	padding-left: 10px; 
  background-position: 0px 1px;
	background-repeat:no-repeat;
}

/* navigation page links for online help and admin searchindex tool */
a.searchlink, a.searchlink:link, a.searchlink:visited {
	color: #CC0000; 
	text-decoration: none;
}
a.searchlink:hover, a.searchlink:active { 
	text-decoration: underline;
}

a.searchcategory, a.searchcategory:link, a.searchcategory:visited {
	color: #CC0000; 
	text-decoration: none;
  font-weight: bold;
}

a.searchcategory:hover, a.searchcategory:active {
  text-decoration: underline;
}

<% }

   // for all styles except onlinehelp!!
   if (style != ONLINEHELP) {
%>

.help { 
    color: #000000; 
    position: absolute; 
    top: 0px; 
    left: 0px; 
    padding: 5px; 
    width: 200px; 
    border: 1px solid /*begin-color WindowFrame*/#000000/*end-color*/; 
    background-color: /*begin-color InfoBackground*/#f9f9f9/*end-color*/; 
    visibility: hidden; 
    font-size: 8pt; 
} 

.legacy-app .help {
	display: none;
}

<% } // close !ONLINEHELP
	if (style != NEW_ADMIN && style != ONLINEHELP) { %>

/* special definition for IE bug displaying horizontal scroll bar in STRICT mode,
   this must ALWAYS stay at the end of the css! */
body.dialog { voice-family: "\"}\""; voice-family: inherit; width: expression(document.documentElement.clientWidth - 20); }

<% } %> 
