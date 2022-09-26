<%--
  ADOBE CONFIDENTIAL

  Copyright 2016 Adobe Systems Incorporated
  All Rights Reserved.

  NOTICE:  All information contained herein is, and remains
  the property of Adobe Systems Incorporated and its suppliers,
  if any.  The intellectual and technical concepts contained
  herein are proprietary to Adobe Systems Incorporated and its
  suppliers and may be covered by U.S. and Foreign Patents,
  patents in process, and are protected by trade secret or copyright law.
  Dissemination of this information or reproduction of this material
  is strictly forbidden unless prior written permission is obtained
  from Adobe Systems Incorporated.
--%><%
%><%@include file="/libs/granite/ui/global.jsp" %><%
%><%@page session="false"
          import="java.util.Iterator,
      			  javax.jcr.Session,
                  com.adobe.granite.ui.components.Config,
                  com.adobe.granite.ui.components.rendercondition.RenderCondition,
                  com.adobe.granite.ui.components.rendercondition.SimpleRenderCondition,
                  org.apache.jackrabbit.api.security.user.UserManager, 
				  org.apache.jackrabbit.api.security.user.User, 
				  org.apache.jackrabbit.api.security.user.Group" %><%

Config cfg = cmp.getConfig();
UserManager um = resourceResolver.adaptTo(UserManager.class);
boolean isAllowed = false;
String group = cfg.get("group", "");

User user = um.getAuthorizable(resourceResolver.adaptTo(Session.class).getUserID(), User.class);
isAllowed = user.isAdmin();
Iterator<Group> itrGrp = user.memberOf();
while(itrGrp.hasNext()) {
    Group grp = itrGrp.next();
    if (grp.getID().equals(group)) {
        isAllowed = true;
    }
}
request.setAttribute(RenderCondition.class.getName(), new SimpleRenderCondition(isAllowed));
%>