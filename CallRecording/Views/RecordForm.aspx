<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RecordForm.aspx.cs" Inherits="CallRecording.RecordForm" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="panel-body form-horizontal">

        <asp:ValidationSummary runat="server" ID="ValidationSummary1" DisplayMode="BulletList" ShowMessageBox="False" ShowSummary="True" CssClass="validation-summary-valid text-danger alert alert-danger"/>

         <p class="font-weight-bold">User Information</p>

        <div class="form-group row">
            <label for="UserID" class="col-sm-2 col-form-label">User ID</label>
            <div class="col-sm-10">
                <asp:TextBox runat="server" CssClass="form-control" ID="UserID" Enabled="false" ></asp:TextBox>
                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidatorUserID" runat="server" ErrorMessage="Please enter User ID." ControlToValidate="UserID" Display="Dynamic" SetFocusOnError="True" CssClass="alert-text" />--%>
            </div>
        </div>

        <div class="form-group row">
            <label for="tbExtension" class="col-sm-2 col-form-label">Extension</label>
            <div class="col-sm-10">
                <asp:TextBox runat="server" CssClass="form-control" ID="tbExtension" Enabled="false" ></asp:TextBox>
                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidatorExtension" runat="server" ErrorMessage="Please enter Extension." ControlToValidate="tbExtension" Display="Dynamic" SetFocusOnError="True" CssClass="alert-text" />--%>
            </div>
        </div>

        <hr />

        <p class="font-weight-bold">Claim Search</p>
        
        <div class="form-group row">
            <label for="tbClaimNumber" class="col-sm-2 col-form-label">Claim #</label>
            <div class="col-sm-4">
                <asp:TextBox runat="server" ID="tbClaimNumber" CausesValidation="true" CssClass="form-control"></asp:TextBox>
                <asp:CustomValidator ID="CustomValidatorNumber" runat="server" ControlToValidate="tbClaimNumber" ErrorMessage="The Claim Number or Policy Number is required" ClientValidationFunction="NumberValidation" ValidationGroup="Validate"></asp:CustomValidator>
            </div>
            <label for="tbPolicyNumber" class="col-sm-2 col-form-label">Policy Number</label>
            <div class="col-sm-4">
                <asp:TextBox runat="server" ID="tbPolicyNumber" CausesValidation="true" CssClass="form-control"></asp:TextBox>
                <asp:CustomValidator ID="CustomValidatorNumber1" runat="server" ControlToValidate="tbPolicyNumber" ErrorMessage="The Claim Number or Policy Number is required" ClientValidationFunction="NumberValidation" ValidationGroup="Validate"></asp:CustomValidator>
            </div>
        </div>

        <div class="form-group row">
            <label for="tbLastName" class="col-sm-2 col-form-label">Last Name</label>
            <div class="col-sm-10">
                <asp:TextBox runat="server" CssClass="form-control" ID="tbLastName"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidatorLastName" runat="server" ErrorMessage="Please enter Last Name." ControlToValidate="tbLastName" Display="None" SetFocusOnError="True" ValidationGroup="Validate" />
            </div>
        </div>

        <div class="form-group row">
            <label for="tbFirstName" class="col-sm-2 col-form-label">First Name</label>
            <div class="col-sm-10">
                <asp:TextBox runat="server" CssClass="form-control" ID="tbFirstName"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidatorFirstName" runat="server" ErrorMessage="Please enter First Name." ControlToValidate="tbFirstName" Display="None" SetFocusOnError="True" ValidationGroup="Validate" />
            </div>
        </div>

        <div class="form-group row">
            <label for="ddlRole" class="col-sm-2 col-form-label">Role</label>
            <div class="col-sm-10">
                <select class="form-control " id="ddlRole">
                    <option selected="selected" value="1">Select a Role</option>
                    <option value="1">Named Insured</option>
                    <option value="2">DIV</option>
                    <option value="3">DCV</option>
                    <option value="4">Witness</option>
                    <option value="5">Agent</option>
                    <option value="6">Other</option>
                </select>
            </div>
        </div>

        <hr />

        <div class="row">
            <asp:Button runat="server" ID="btnStart" CssClass="btn btn-lg btn-primary btn-space" Text="Start Recording" OnClientClick="StartRecording(event)" />
            <asp:Button runat="server" ID="btnStop"  CssClass="btn btn-lg btn-secondary btn-space" Text="Stop Recording" OnClientClick="StopRecording(event)"/>
        </div>

    </div>

<script>

    $(document).ready(function () {
        EnableButtonsRecording(false);
    });

    function StartRecording(e) {

        var isValid = false;
        if (typeof (Page_ClientValidate) == 'function')
            isValid = Page_ClientValidate();

        if (!isValid)
            return;

        else {
            e.preventDefault();

            $.ajax({
                type: "POST",
                url: "RecordForm.aspx/StartRecording",
                data: '{claimNumber: "' + $("#<%=tbClaimNumber.ClientID%>").val() + '" }',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    EnableButtonsRecording(true);
                },
                failure: function (response) {
                    EnableButtonsRecording(false);
                }
            });
        }
    }

    function StopRecording(e) {

        var isValid = false;
        if (typeof (Page_ClientValidate) == 'function')
            isValid = Page_ClientValidate();

        if (!isValid)
            return;

        else {
            e.preventDefault();

            $.ajax({
                type: "POST",
                url: "RecordForm.aspx/StopRecording",
                data: '{claimNumber: "' + $("#<%=tbClaimNumber.ClientID%>").val() + '" }',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    EnableButtonsRecording(false);
                },
                failure: function (response) {
                    EnableButtonsRecording(true);
                }
            });
        }
    }

    function EnableButtonsRecording(event) {

        if (event) {
            $("#<%=btnStart.ClientID%>").attr("disabled", true);
            $("#<%=btnStop.ClientID%>").attr("disabled", false);

            $("#<%=btnStart.ClientID%>").css('background-color', '#6c757d');
            $("#<%=btnStop.ClientID%>").css('background-color', '#007bff');
        }
        else {
            $("#<%=btnStart.ClientID%>").attr("disabled", false);
            $("#<%=btnStop.ClientID%>").attr("disabled", true);

            $("#<%=btnStart.ClientID%>").css('background-color', '#007bff');
            $("#<%=btnStop.ClientID%>").css('background-color', '#6c757d');
        }
    }

    function NumberValidation(sender, args) {

        console.log("NumberValidation");

        var valid = false;

        var claimNumber = $("#<%=tbClaimNumber.ClientID%>").val();
        var policyNumber = $("#<%=tbPolicyNumber.ClientID%>").val();

        if (!claimNumber && !policyNumber)
            args.isValid = valid;

        console.log(args.isValid);

        return;
    }
</script>

</asp:Content>