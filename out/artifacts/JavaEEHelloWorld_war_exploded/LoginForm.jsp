<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="ConfigServer.Login" %>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
      integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<html>
<head>
    <title>Login Form</title>
</head>
<body>

<div style="width:90%; margin-right:15px; margin-left:15px; margin-top:15px">

    <form action="Login" method="post">
        <div class="form-group">
            <label for="email">Email address:</label>
            <input type="email" class="form-control" id="email" name="email" value=${Login.username}>
        </div>
        <div class="form-group">
            <label for="pwd">Password:</label>
            <input type="password" class="form-control" id="pwd" name="pwd">
        </div>
        <div class="form-group form-check">
            <label class="form-check-label">
                <input class="form-check-input" type="checkbox"> Remember me
            </label>
        </div>
        <button type="submit" class="btn btn-primary">Submit</button>
        <% if (!Login.valid) { %>
        <div class="alert alert-danger">
            <strong> Error! </strong> Invalid email address or password.
        </div>
        <%}%>
    </form>
</div>


</body>
</html>
