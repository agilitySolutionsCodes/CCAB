<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
    <title></title>
    <meta http-equiv="content-type" content="text/html; charset=iso-8859-1" />
    <meta http-equiv="Page-Enter" content="blendTrans(Duration=0.01)" />
    <link href="App_Themes/Default/estiloCCAB.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .style2
        {
            width: 107px;
        }
        .style9
        {
            width: 44px;
        }
        .style10
        {
            width: 16px;
        }
        .style11
        {
            width: 94px;
        }
        .style12
        {
            width: 45px;
        }
        .style13
        {
            width: 38px;
        }
        .style14
        {
            width: 2px;
        }
        .style16
        {
            width: 56px;
        }
        .style17
        {
            width: 110px;
        }
        .style18
        {
            width: 102px;
        }
        .style19
        {
            height: 8px;
        }
        .style20
        {
            width: 102px;
            height: 8px;
        }
        .style22
        {
            width: 157px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div id="container">
        <div id="cabecalho">
            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td class="tdTopo_background02">
                        &nbsp;
                    </td>
                    <td valign="top" class="tdTopo_background">
                        <table width="100%" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td valign="top">
                                    <asp:Image runat="server" ImageAlign="Top" ImageUrl="~/imgsCCAB/topoDefault_img01.jpg" />
                                </td>
                                <td width="*">&nbsp;
                                </td>
                                <td width="114" valign="top">
                                    <asp:Image runat="server" ImageAlign="Top" ImageUrl="~/imgsCCAB/topoDefault_img02.jpg" />
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td class="tdTopo_background">
                        &nbsp;
                    </td>
                </tr>
            </table>   
        </div>
        <div id="body">
            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td class="tdBG_defaultEsquerdo">
                        &nbsp;
                    </td>
                    <td width="959" height="520" class="tdImagem_background">
                        <!--<asp:Image runat="server" ImageAlign="Top" ImageUrl="~/imgsCCAB/defaultImagem.jpg" />-->
                        &nbsp;
                    </td>
                    <td class="tdBG_defaultDireito">
                        &nbsp;
                    </td>
                </tr>
            </table>
        </div>
        <div id="rodape">
            <table id="telaCheia" width="100%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td valign="top" class="tdRodape">
                        &nbsp;
                    </td>
                    <td valign="top" class="tdRodape">
                        <asp:Image runat="server" ImageAlign="Top" ImageUrl="~/imgsCCAB/rodapeImagem.jpg" />
                    </td>
                    <td valign="top" class="tdRodape">
                        &nbsp;
                    </td>
                </tr>
            </table>    
        </div>
    </div>
    <div style="position: absolute; top: 110px; left: 35%">
        <div style="clear: both; color: #ffffff; font-size: smaller; text-align: center; width: 390px">
            <asp:Label ID="lblPrincipal" runat="server" ForeColor="White" 
                Text="Para acessar o Sistema, informe seu Usuário e Senha:" 
                CssClass="label"></asp:Label>
            <br />
            &nbsp;
            <br />
            <asp:Panel ID="panLogin" runat="server" Height="57" Width="390">
                <table style="width: 288pt; height: 10px;">
                    <tr>
                        <td class="style12">
                            <asp:Label ID="lblUsuario" runat="server" CssClass="label" ForeColor="White" 
                                Height="15px" Text="Usuário:"></asp:Label>
                        </td>
                        <td class="style11">
                            <asp:TextBox ID="txtUsuario" runat="server" CssClass="campoTexto" 
                                Font-Size="Smaller" Height="12px" style="margin-top: 0px" Width="100px" 
                                MaxLength="30" TabIndex="1"></asp:TextBox>
                        </td>
                        <td class="style10">
                            &nbsp;</td>
                        <td class="style13">
                            <asp:Label ID="lblSenha" runat="server" CssClass="label" ForeColor="White" 
                                Height="15px" Text="Senha:"></asp:Label>
                        </td>
                        <td class="style2">
                            <asp:TextBox ID="txtSenha" runat="server" CssClass="campoTexto" 
                                Font-Size="Smaller" Height="12px" style="margin-top: 0px" TextMode="Password" 
                                Width="100px" MaxLength="255" TabIndex="2"></asp:TextBox>
                        </td>
                        <td class="style14">
                            &nbsp;</td>
                        <td class="style9">
                            <asp:Button ID="btnOk" runat="server" CssClass="button" Font-Bold="False" 
                                Font-Size="Smaller" ForeColor="Black" Height="20px" onclick="btnOk_Click" 
                                Text="OK" Width="40px" TabIndex="3" />
                        </td>
                    </tr>
                </table>
                <table style="width: 284pt;">
                    <tr>
                        <td style="text-align: left;" class="style22">
                            &nbsp;</td>
                        <td class="style16">
                            &nbsp;</td>
                        <td style="text-align: right">
                            <asp:HyperLink ID="HyperLink1" runat="server" CssClass="label" 
                                NavigateUrl="Default.aspx?prm=esqueci" TabIndex="5" ForeColor="White">Esqueci minha senha</asp:HyperLink>
                        </td>
                    </tr>
                </table>
                <br />
                <br />
            </asp:Panel>
            <asp:Panel ID="panTroca" runat="server" Height="41" Width="100" Visible="False">
                <table style="padding-left: 60px">
                    <tr>
                        <td class="style12">
                            <asp:Label ID="lblUsuario0" runat="server" CssClass="label" ForeColor="White" 
                                Height="15px" Text="Usuário:"></asp:Label>
                        </td>
                        <td class="style17">
                            <asp:TextBox ID="txtUsuarioSenha" runat="server" CssClass="campoTexto" 
                                Font-Size="Smaller" Height="12px" style="margin-top: 0px" Width="100px" 
                                MaxLength="30" TabIndex="6"></asp:TextBox>
                        </td>
                        <td class="style14">
                            &nbsp;</td>
                        <td class="style9">
                            <asp:Button ID="btnSenha" runat="server" CssClass="button" Font-Bold="False" 
                                Font-Size="Smaller" ForeColor="Black" Height="20px" onclick="btnSenha_Click" 
                                Text="Enviar Senha" Width="89px" TabIndex="7" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <asp:Panel ID="panOk" runat="server" Height="37px" Visible="False">
                <table style="width: 64pt;">
                    <tr>
                        <td>
                            <asp:Button ID="btnOkGeral" runat="server" Font-Bold="False" Font-Size="Smaller" 
                                ForeColor="Black" Height="20px" onclick="btnOkGeral_Click" Text="OK" 
                                Width="40px" CssClass="button" TabIndex="9" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <asp:Panel ID="panTrocaSenha" runat="server" Height="89px" Visible="False">
                <table style="width:199px;">
                    <tr>
                        <td style="text-align: left">
                            <asp:Label ID="lblUsuarioTroca" runat="server" CssClass="label" 
                                ForeColor="White" Height="15px" Text="Usuário:"></asp:Label>
                        </td>
                        <td class="style18" style="text-align: left">
                            <asp:Label ID="panUsuarioTroca" runat="server" CssClass="label" 
                                ForeColor="White" Height="15px" Text="Nome do Usuário"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: left">
                            <asp:Label ID="lblSenhaTroca" runat="server" CssClass="label" ForeColor="White" 
                                Height="15px" Text="Senha Nova:"></asp:Label>
                        </td>
                        <td class="style18">
                            <asp:TextBox ID="txtSenhaTroca" runat="server" CssClass="campoTexto" 
                                Font-Size="Smaller" Height="12px" MaxLength="255" style="margin-top: 0px" 
                                TabIndex="10" TextMode="Password" Width="100px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: left">
                            <asp:Label ID="lblSenhaConfirmacao" runat="server" CssClass="label" 
                                ForeColor="White" Height="15px" Text="Confirmação:"></asp:Label>
                        </td>
                        <td class="style18">
                            <asp:TextBox ID="txtSenhaConfirmacao" runat="server" CssClass="campoTexto" 
                                Font-Size="Smaller" Height="12px" MaxLength="255" style="margin-top: 0px" 
                                TabIndex="11" TextMode="Password" Width="100px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="style19">
                            <asp:Label ID="lblPessoaSeq" runat="server" CssClass="label" ForeColor="White" 
                                Height="15px" Text="lblPessoa" Visible="False"></asp:Label>
                        </td>
                        <td class="style20" style="text-align: right">
                            <asp:Button ID="btnTrocarSenha" runat="server" CssClass="button" 
                                Font-Bold="False" Font-Size="Smaller" ForeColor="Black" Height="20px" 
                                onclick="btnTrocarSenha_Click" Text="OK" Width="40px" TabIndex="12" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <asp:Panel ID="panTermoUso" runat="server" Height="199px" Visible="False">
                <table style="width: 100%; height: 106px;">
                    <tr>
                        <td>
                            &nbsp;</td>
                        <td>
                            <table style="border: 1px solid #FFFFFF; width: 550px;">
                                <tr>
                                    <td>
                                        <asp:Label ID="Label1" runat="server" CssClass="label" ForeColor="White" 
                                            Height="15px" 
                                            Text="Antes de aceitar e confirmar seu cadastro, leia atentamente os Termos e Condições do Site."></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:CheckBox ID="chkTermo" runat="server" 
                                            oncheckedchanged="chkTermo_CheckedChanged" AutoPostBack="True" />
                                        Lí todos os 
                                        <asp:HyperLink ID="HyperLink2" runat="server" ForeColor="White" 
                                            NavigateUrl="~/TermoUso.aspx" Target="_blank">termos de uso</asp:HyperLink>
                                         do Site.    
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Button ID="btnConcordo" runat="server" CssClass="button" 
                                            Font-Size="Smaller" ForeColor="Black" Height="20px" 
                                            onclick="btnConcordo_Click" TabIndex="17" Text="Concordo" Width="75px" />
                                        &nbsp;&nbsp;&nbsp;
                                        <asp:Button ID="btnDiscordo" runat="server" CssClass="button" 
                                            Font-Size="Smaller" ForeColor="Black" Height="20px" 
                                            onclick="btnDiscordo_Click" TabIndex="17" Text="Discordo" Width="75px" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td>
                            &nbsp;</td>
                    </tr>
                </table>
            </asp:Panel>
            <br />
            <br />
            <br />
            <asp:Label ID="lblMensagem" runat="server" ForeColor="White" CssClass="label"></asp:Label>
        </div>
        
    </div>
    </form>
</body>
</html>