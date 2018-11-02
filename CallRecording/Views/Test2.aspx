<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Test2.aspx.cs" Inherits="CallRecording.Views.Test2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <asp:ValidationSummary runat="server" ID="ValidationSummary1" 
        DisplayMode="BulletList" ShowMessageBox="False" 
        ShowSummary="True" CssClass="alert alert-danger"/>

    <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
    <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
    <asp:CustomValidator ID="CustomValidator1" runat="server" 
                         ErrorMessage="CustomValidator Error Message" 
                         ControlToValidate="TextBox1" 
                         ClientValidationFunction="Test2" 
                         ForeColor="Red" 
                         Display="None">

    </asp:CustomValidator>
    <asp:Button ID="Button1" runat="server" Text="Button" />

    <script>
        function Test2(source, args) {
            if (args.Value > 0)
                return args.IsValid = true;
            else
                return args.IsValid = false;
        }
    </script>

</asp:Content>
