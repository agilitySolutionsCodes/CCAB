<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Permissao.aspx.cs" Inherits="_SFA_Permissao_Permissao" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            
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
                                    <td width="400" align="left">
                                        <asp:ImageButton runat="server" id="btVoltar" BackColor="Transparent" ImageAlign="Top" 
                                            ImageUrl="~/imgsCCAB/tbTitulo_btVoltar.gif" AlternateText=".: voltar" />&nbsp;&nbsp;&nbsp;&nbsp;
                                    </td>
                                    <td width="20" align="right">
                                        <asp:Image ID="Image1" runat="server" Width="18" Height="36" ImageAlign="Top" 
                                            ImageUrl="~/imgsCCAB/tbTitulo_imgMarcador.jpg" />
                                    </td>
                                    <td width="340" class="tbTitulo_NomeTela" align="left">
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
            
            <!-- Identificação do Pai --> 
            <fieldset style="text-align:left; vertical-align:middle; height:18px; padding: 5px 5px; margin-bottom: 20px;">
                <h5>
                    <asp:Label runat="server" ID="lbDadosPai" SkinID="normal" />
                </h5>
            </fieldset>
            
            <!-- Área de Mensagens -->
            <div style="margin-bottom: 20px">
                <%-- <asp:ValidationSummary EnableClientScript="true" ID="ValidationSummary1" ShowSummary="false"
                    ShowMessageBox="true" ValidationGroup="Form" HeaderText="O formulário contém erros:"
                    runat="server" />--%>
                <asp:CustomValidator ID="CustomValidator1" runat="server" ValidationGroup="Form" />
            </div>
            
            <!-- Grid Resultado -->
            <div>
                <asp:GridView ID="GridView1" SkinID="NoPaging" runat="server" OnRowDataBound="GridView1_RowDataBound">
                    <Columns>
                        <asp:BoundField DataField="cdItemMenu" HeaderText="Código" SortExpression="cdItemMenu" >
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Top"/>
                            <HeaderStyle HorizontalAlign="Left"/>
                        </asp:BoundField> 
                        <asp:BoundField DataField="dsItemMenu" HeaderText="Operação" SortExpression="dsItemMenu" >
                            <ItemStyle HorizontalAlign="Left" VerticalAlign="Top"/>
                            <HeaderStyle HorizontalAlign="Left"/>
                        </asp:BoundField> 
                        <asp:TemplateField HeaderText="Pesquisar">
                            <ItemTemplate>
                                <asp:CheckBox runat="server" ID="chkPesquisar" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Incluir">
                            <ItemTemplate>
                                <asp:CheckBox runat="server" ID="chkIncluir" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Visualizar">
                            <ItemTemplate>
                                <asp:CheckBox runat="server" ID="chkVisualizar" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Alterar">
                            <ItemTemplate>
                                <asp:CheckBox runat="server" ID="chkAlterar" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Excluir">
                            <ItemTemplate>
                                <asp:CheckBox runat="server" ID="chkExcluir" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
            <div style="text-align: right; margin-top: 20px;">
                <asp:Button runat="server" ID="btSalvar" CssClass="button" ValidationGroup="Form" 
                    OnCommand="btSalvar_OnClick" Text="salvar" />
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
        
</asp:Content>

