<%@ page import="ConfigAttributes.FetchEmailController" %>
<%@ page import="ConfigAttributes.FriendController" %>
<%@ page import="ConfigMail.ManageEmail" %>
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
<body style="margin:15px">

<%--LOG OUT AND HISTORY AND RECEIVE BUTTON--%>
<div class="form-row">
    <div class="col-1.5">
        <form action="HistoryController" method="post">
            <input type="submit" name="showHistory" id="historyButton" class="btn btn-info btn-send"
                   value="History">
        </form>
    </div>
    <div class="col">
        <form action="FetchEmailController" method="post">
            <input type="submit" name="showReceived" id="receiveButton" class="btn btn-info btn-send"
                   value="Get Emails">
        </form>
    </div>
    <div class="col">
        <button type="button" name="back" style="float: right;" onclick="window.location='LoginForm.jsp'"
                class="btn btn-danger">Log Out
        </button>
    </div>
</div>

<br><br>
</div>
<%------------------------%>

<%--SEND EMAIL--%>
<form action="ManageEmail" method="post">
    <div class="messages"></div>
    <div class="controls">
        <div class="row">
            <div class="col-md-12">
                <div class="form-group">
                    <label for="email">To *</label>
                    <input id="email" type="email" name="receiver" class="form-control"
                           placeholder="Please enter email" required="required"
                           data-error="Email is required.">
                    <div class="help-block with-errors"></div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="form-group">
                    <label for="form_message">Subject *</label>
                    <textarea id="Subject" name="subject" class="form-control" placeholder="Please enter subject"
                              rows="1" required="required" data-error="Subject is required."></textarea>
                    <div class="help-block with-errors"></div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="form-group">
                    <label for="form_message">Message *</label>
                    <textarea id="form_message" name="content" class="form-control" placeholder="Message for me *"
                              rows="6" required="required" data-error="Please, leave a message."></textarea>
                    <div class="help-block with-errors"></div>
                </div>
            </div>
            <div class="col-md-12">
                <input type="submit" class="btn btn-success btn-send" value="Send message">
            </div>
            <br><br>
        </div>
    </div>
    <br><br><br><br>
    Contacts:


    <%--CHECK IF EMAIL WAS SENT AND RUN MODAL--%>
    <% if (ManageEmail.EmailSent) { %>
    <script type="text/javascript">
        $(window).on('load', function () {
            $('#sentModal').modal('show');
        });
    </script>
    <% ManageEmail.EmailSent = false;
    }
        ; %>
    <%------------------------%>

    <%--SHOW SENT DISPLAY--%>
    <div class="modal fade" id="sentModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
         aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Sent!</h5>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
    <%------------------------%>
</form>
<%------------------------%>


<%--MANAGE ADDING/REMOVING FRIENDS--%>
<form action="FriendController" method="post">
    <%--ADD BUTTONS CONTROLLER--%>
    <div class="controls">
        <div class="row">
            <div class="col-md-12">
                <input type="submit" name="addContact1" id="addContact1" class="btn btn-info btn-send"
                       value="Add Contact">
                <input type="submit" name="removeContact1" id="removeContact1" class="btn btn-info btn-send"
                       value="Remove Contact">
            </div>
        </div>
    </div>
    <%------------------------%>
    <%--RUN ADD MODAL IF NEEDED--%>
    <% if (FriendController.addFriend) {%>
    <script type="text/javascript">
        $(window).on('load', function () {
            $('#addFriendModal').modal('show');
        });
    </script>
    <% FriendController.addFriend = false;
    }%>
    <%------------------------%>
    <%--RUN REMOVE MODAL IF NEEDED--%>
    <% if (FriendController.removeFriend) {%>
    <script type="text/javascript">
        $(window).on('load', function () {
            $('#removeFriendModal').modal('show');
        });
    </script>
    <% FriendController.removeFriend = false;
    }%>
    <%------------------------%>
</form>
<%------------------------%>


<%--ADD FRIEND MODAL--%>
<form action="FriendController" method="post">
    <div class="modal fade" id="addFriendModal">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">New contact</h5>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="form-group">
                            <label for="friendEmail">Email address:</label>
                            <input type="email" class="form-control" id="friendEmail" name="friendEmail"/>
                        </div>
                        <div class="form-group">
                            <label for="friendDescription" class="col-form-label">Short description:</label>
                            <input type="text" class="form-control" id="friendDescription" name="friendDescription"/>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="submit" name="addContact2" id="addContact2" class="btn btn-primary"> Add</button>
                </div>
            </div>
        </div>
    </div>
</form>

<%--REMOVE FRIEND MODAL--%>
<form action="FriendController" method="post">
    <div class="modal fade" id="removeFriendModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
         aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Remove contact</h5>
                </div>
                <div class="modal-body">
                    <form>
                        <select class="browser-default custom-select" name="friendChoiceBox">
                            <option value="" disabled selected>Choose email</option>
                            <% for (int i = 0; i < Database.friendList.size(); i++) { %>
                            <option value=<%=Database.friendList.get(i).getEmail()%>>
                                <%=Database.friendList.get(i).getEmail()%>
                            </option>
                            <% } %>
                        </select>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="submit" name="removeContact2" class="btn btn-primary">Remove</button>
                </div>
            </div>
        </div>
    </div>
</form>
<%------------------------%>

<%--UPDATE FRIEND LIST--%>
<% for (int i = 0; i < Database.friendList.size(); i++) { %>
<div id="accordion">
    <div class="card">
        <div class="card-header">
            <h5>
                <a href="#collapse<%=i%>" data-parent="#accordion" data-toggle="collapse" class="collapsed">
                    <%=Database.friendList.get(i).getEmail()%>
                </a>
            </h5>
        </div>
        <div id="collapse<%=i%>" class="collapse" style="">
            <div class="card-body">
                <%=Database.friendList.get(i).getDescription()%>
            </div>
        </div>
    </div>
</div>
<%}%>
<%------------------------%>

<%--RUN RECEIVED MODAL IF NEEDED--%>
<form action="FetchEmailController" method="post">
    <% if (FetchEmailController.showReceived) {%>
    <script type="text/javascript">
        $(window).on('load', function () {
            $('#showReceived').modal('show');
        });
    </script>
    <% FetchEmailController.showReceived = false;
    }%>
</form>

<%--RECEIVED EMAILS MODAL--%>
<form action="FetchEmailController" method="post">
    <div class="modal fade" id="showReceived" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
         aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Number of messages to display</h5>
                </div>
                <div class="modal-body">
                    <input type="number" class="form-control" id="maxNumberEmails" name="maxNumberEmails"/>
                </div>
                <div class="modal-footer">
                    <button type="submit" name="applyNumber" class="btn btn-primary">Display</button>
                </div>
            </div>
        </div>
    </div>
</form>
</body>
</html>