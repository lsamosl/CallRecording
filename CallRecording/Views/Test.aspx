<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Test.aspx.cs" Inherits="CallRecording.Test" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="panel-body form-horizontal">

        <asp:ValidationSummary runat="server" ID="ValidationSummary1" DisplayMode="BulletList" ShowMessageBox="False" ShowSummary="True" CssClass="validation-summary-valid text-danger alert alert-danger"/>

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

        console.log("StartRecording");
        var isValid = false;
        if (typeof(Page_ClientValidate) == 'function') 
            isValid = Page_ClientValidate();

        if (!isValid)
            return;

        else {
            e.preventDefault();
 
            $.ajax({
            type: "POST",
            url: "Test.aspx/StartRecording",
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

        console.log("StopRecording");
        var isValid = false;
        if (typeof(Page_ClientValidate) == 'function') 
            isValid = Page_ClientValidate();

        if (!isValid)
            return;

        else {
            e.preventDefault();
 
            $.ajax({
            type: "POST",
            url: "Test.aspx/StopRecording",
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

        console.log("EnableButtonsRecording");
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
