<%@ page import="Database.Database" %>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
      integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
        integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
        crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
        integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
        crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
        integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
        crossorigin="anonymous"></script>

<html>
<body style="margin: 15px">
<div class="row">
    <div class="col-md-6">
        <button type="button" name="back" onclick="window.location='HomePage.jsp'" class="btn btn-info btn-send">
            Back
        </button>
    </div>
    <div class="col-md-6">
        <button type="button" name="back" style="float: right;" onclick="window.location='LoginForm.jsp'"
                class="btn btn-danger">Log Out
        </button>
    </div>
</div>
<br>
<table class="table table-condensed" style="border-collapse:collapse;">
    <thead>
    <tr>
        <th>#</th>
        <th>Date</th>
        <th>From</th>
        <th>Subject</th>
    </tr>
    </thead>
    <tbody>
    <% for (int i = 0; i < Database.receivedList.size(); i++) {%>
    <tr data-toggle="collapse" data-target="#history<%=i%>" class="accordion-toggle">
        <td><%=Database.receivedList.get(i).getIndex()%>
        </td>
        <td><%=Database.receivedList.get(i).getDate()%>
        </td>
        <td><%=Database.receivedList.get(i).getUser()%>
        </td>
        <td><%=Database.receivedList.get(i).getSubject()%>
        </td>
    </tr>
    <%}%>
    </tbody>
</table>
</body>
</html>
