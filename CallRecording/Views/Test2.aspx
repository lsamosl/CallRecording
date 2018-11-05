<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Test2.aspx.cs" Inherits="CallRecording.Views.Test2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <asp:ValidationSummary runat="server" 
        ID="ValidationSummary1" 
        DisplayMode="BulletList" 
        ShowMessageBox="False" 
        ShowSummary="True" 
        CssClass="alert alert-danger"/>

    <div class="form-group row">
            <asp:Label ID="Label2" runat="server" Text="Number 1" CssClass="col-sm-2 col-form-label"></asp:Label>
            <div class="col-sm-10">
                <asp:TextBox runat="server" CssClass="form-control" ID="tbNumber"></asp:TextBox>
                <asp:CustomValidator ID="CustomValidator2" 
                    runat="server"                          
                    ErrorMessage="CustomValidator Error Message"                          
                    ControlToValidate="tbNumber"                          
                    ClientValidationFunction="Test2"                          
                    ForeColor="Red"                          
                    Display="None" ValidateEmptyText="true">
                </asp:CustomValidator>
            </div>
    </div>

    <div class="form-group row">
            <asp:Label ID="Label1" runat="server" Text="Number 2" CssClass="col-sm-2 col-form-label"></asp:Label>
            <div class="col-sm-10">
                <asp:TextBox runat="server" CssClass="form-control" ID="tbNumber2"></asp:TextBox>
            </div>
    </div>

    <div class="form-group row">
        <asp:Label ID="Label3" runat="server" Text="Text" CssClass="col-sm-2 col-form-label"></asp:Label>
        <div class="col-sm-10">
            <asp:TextBox runat="server" CssClass="form-control" ID="tbText"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidatorText" 
                runat="server" 
                ErrorMessage="Please enter Text." 
                ControlToValidate="tbText" 
                Display="None" 
                SetFocusOnError="True"/>
        </div>
    </div>

    <asp:Button ID="btnEnviar" runat="server" 
        Text="Enviar" 
        CssClass="btn btn-lg btn-primary" 
        OnClientClick="Enviar(event)"/>

    <script>
        $(document).ready(function () {
        
        });


        function Test2(source, args) {

            console.log('Test2');
            console.log(source);
            console.log(args);

            var number1 = args.Value;
            var number2 = $("#<%=tbNumber2.ClientID%>").val();

            if (!number1 && !number2) {
                args.IsValid = false;
                console.log(args);
                return args.IsValid = args.IsValid;
            }
                
            else {
                args.IsValid = true
                console.log(args);
                return args.IsValid = args.IsValid;
            }
                

        }

        function Enviar(e) {

            console.log('Enviar');
            e.preventDefault();

            var isValid = false;
            if (typeof (Page_ClientValidate) == 'function') 
                isValid = Page_ClientValidate();

            if (!isValid)
                return;

            else {

            }

        }
    </script>


</asp:Content>
