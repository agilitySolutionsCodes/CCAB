﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CompromissoCompra.aspx.cs" Inherits="_SFA_Relatorios_CompromissoCompra" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=9.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7">
    <title>Relatório - CompromissoCompra</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <rsweb:ReportViewer ID="rptCompromissoCompra" runat="server" Height="100%" ProcessingMode="Remote" Width="100%">
        </rsweb:ReportViewer>
    </div>
    </form>
</body>
</html>
