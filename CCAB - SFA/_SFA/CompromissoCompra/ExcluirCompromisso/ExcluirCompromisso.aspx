﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ExcluirCompromisso.aspx.cs" Inherits="_SFA_ExcluirCompromisso_ExcluirCompromisso" %>
<%@ Register TagPrefix="uc" TagName="Filtro" Src="~/_SFA/CompromissoCompra/ExcluirCompromisso/Filtro.ascx" %>
<%@ Register TagPrefix="uc" TagName="Resultado" Src="~/_SFA/CompromissoCompra/ExcluirCompromisso/Resultado.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
  
    <!-- Cabeçalho -->
    <div class="pageSection">
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td class="tbTitulo_bordaEsquerda">
                    &nbsp;
                </td>
                <td class="tbTitulo_BG">
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td width="500" align="left">
                                &nbsp;
                            </td>
                            <td width="20" align="right">
                                <asp:Image ID="Image1" runat="server" Width="18" Height="36" ImageAlign="Top" 
                                    ImageUrl="~/imgsCCAB/tbTitulo_imgMarcador.jpg" />
                            </td>
                            <td width="240" class="tbTitulo_NomeTela" align="left">
                                <asp:Label ID="lbNomeTela" runat="server" SkinID="normal" />
                            </td>
                        </tr>
                    </table>
                </td>
                <td class="tbTitulo_bordaDireita">
                    &nbsp;
                </td>
            </tr>
        </table>
    </div>
    
    <%if (!Convert.ToBoolean(Session["ShowMessage"]))
    {%> 
    
    <!-- Filtro -->
    <div class="pageSection">
        <uc:Filtro ID="Filtro1" runat="server" />
    </div>
    
    <!-- Área de Mensagens -->
    <div>
        <asp:CustomValidator ID="CustomValidator1" runat="server" ValidationGroup="Form" />
    </div>
    
    <!-- Grid Resultado -->
    <div>
        <uc:Resultado ID="Resultado1" runat="server" />
    </div>
    
    <%}
    else
    {%> 
    <div class="tbCadastro_Mestra">
        <h2 style="color: #808080">
            Compromisso(s) Excluido(s) com sucesso.<br />
        </h2>
        <br />
        <asp:Button runat="server" ID="btExcluirPedido" CssClass="button" Text="excluir compromisso" 
            CausesValidation="false" Width="170" OnClick="btExcluirPedido_Click" />
    </div>  
    <%} %>  
    
</asp:Content>

