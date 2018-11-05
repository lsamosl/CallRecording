<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RecordForm.aspx.cs" Inherits="CallRecording.RecordForm" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <asp:ValidationSummary ID="ValidationSummary1"
        runat="server"  
        DisplayMode="BulletList" 
        ShowMessageBox="False" 
        ShowSummary="True" 
        CssClass="alert alert-danger"/>

    <p class="font-weight-bold">User Information</p>

    <div class="form-group row">
        <label for="UserID" class="col-sm-2 col-form-label">User ID</label>
        <div class="col-sm-10">
            <asp:TextBox runat="server" CssClass="form-control" ID="UserID" Enabled="false" ></asp:TextBox>
            <%--<asp:RequiredFieldValidator ID="RequiredFieldValidatorUserID" runat="server" ErrorMessage="Please enter User ID." ControlToValidate="UserID" SetFocusOnError="True" CssClass="alert-text" />--%>
        </div>
    </div>

    <div class="form-group row">
        <label for="tbExtension" class="col-sm-2 col-form-label">Extension</label>
        <div class="col-sm-10">
            <asp:TextBox runat="server" CssClass="form-control" ID="tbExtension" Enabled="false" ></asp:TextBox>
            <%--<asp:RequiredFieldValidator ID="RequiredFieldValidatorExtension" runat="server" ErrorMessage="Please enter Extension." ControlToValidate="tbExtension" SetFocusOnError="True" CssClass="alert-text" />--%>
        </div>
    </div>

    <hr />

    <p class="font-weight-bold">Claim Search</p>
        
    <div class="form-group row">
        <asp:Label ID="Label2" runat="server" Text="Claim #" CssClass="col-sm-2 col-form-label"></asp:Label>
        <div class="col-sm-4">
            <asp:TextBox runat="server" ID="tbClaimNumber" CssClass="form-control" CausesValidation="true"></asp:TextBox>
            <asp:CustomValidator ID="CustomValidator1" 
                runat="server" 
                ErrorMessage="The Claim Number or Policy Number is required." 
                ControlToValidate="tbClaimNumber" 
                ClientValidationFunction="NumberValidation" 
                ForeColor="Red"
                Display="None" 
                ValidateEmptyText="true">
            </asp:CustomValidator>
        </div>
        <asp:Label ID="Label1" runat="server" Text="Policy Number" CssClass="col-sm-2 col-form-label"></asp:Label>
        <div class="col-sm-4">
            <asp:TextBox runat="server" ID="tbPolicyNumber" CssClass="form-control"></asp:TextBox>
        </div>
    </div>

    <div class="form-group row">

    </div>

    <div class="form-group row">
        <label for="tbLastName" class="col-sm-2 col-form-label">Last Name</label>
        <div class="col-sm-10">
            <asp:TextBox runat="server" CssClass="form-control" ID="tbLastName"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidatorLastName" 
                runat="server" 
                ErrorMessage="Please enter Last Name." 
                ControlToValidate="tbLastName" 
                Display="None" 
                SetFocusOnError="True"/>
        </div>
    </div>

    <div class="form-group row">
        <label for="tbFirstName" class="col-sm-2 col-form-label">First Name</label>
        <div class="col-sm-10">
            <asp:TextBox runat="server" CssClass="form-control" ID="tbFirstName"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidatorFirstName" 
                runat="server" 
                ErrorMessage="Please enter First Name." 
                ControlToValidate="tbFirstName" 
                Display="None" 
                SetFocusOnError="True"/>
        </div>
    </div>

    <div class="form-group row">
        <label for="ddlRole" class="col-sm-2 col-form-label">Role</label>
        <div class="col-sm-10">
            <asp:DropDownList ID="ddlRole" runat="server" CssClass="form-control">
                <asp:ListItem Value="0">Select a Role</asp:ListItem>
                <asp:ListItem Value="1">Named Insured</asp:ListItem>
                <asp:ListItem Value="2">DIV</asp:ListItem>
                <asp:ListItem Value="3">DCV</asp:ListItem>
                <asp:ListItem Value="4">Witness</asp:ListItem>
                <asp:ListItem Value="5">Agent</asp:ListItem>
                <asp:ListItem Value="6">Other</asp:ListItem>
            </asp:DropDownList>
            <asp:CustomValidator ID="CustomValidator2" 
                runat="server" 
                ErrorMessage="The Role is required." 
                ControlToValidate="ddlRole" 
                ClientValidationFunction="RoleValidation" 
                ForeColor="Red"
                Display="None" >
            </asp:CustomValidator>
        </div>
    </div>

    <hr />

    <div class="row">
        <asp:Button runat="server" 
            ID="btnStart" 
            CssClass="btn btn-lg btn-primary btn-space" 
            Text="Start Recording" 
            OnClientClick="StartRecording(event)" />
        <asp:Button runat="server" 
            ID="btnStop"  
            CssClass="btn btn-lg btn-secondary btn-space" 
            Text="Stop Recording" 
            OnClientClick="StopRecording(event)"/>
    </div>

<script>

    $(document).ready(function () {
        EnableButtonsRecording(false);
    });

    function StartRecording(e) {

        e.preventDefault();

        var isValid = false;
        if (typeof (Page_ClientValidate) == 'function')
            isValid = Page_ClientValidate();

        if (!isValid)
            return;

        else {
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

        var claimNumber = args.Value;
        var policyNumber = $("#<%=tbPolicyNumber.ClientID%>").val();

        if (!claimNumber && !policyNumber)
            args.IsValid = false;   
        else 
            args.IsValid = true

        return args.IsValid;
    }

    function RoleValidation(sender, args) {
        var role = args.Value;

        if (role == 0)
            args.IsValid = false;   
        else 
            args.IsValid = true

        return args.IsValid;
    }
</script>

</asp:Content>