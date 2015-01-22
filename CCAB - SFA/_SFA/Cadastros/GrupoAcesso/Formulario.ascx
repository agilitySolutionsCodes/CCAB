<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Formulario.ascx.cs" Inherits="_SFA_GrupoAcesso_Formulario" %>
<!-- Cabeçalho Formulário -->

<script type="text/javascript" src="../../../scripts/JScript.js"></script>

<!-- Preparação da PopUp Modal que exibirá o Formulário (Permite que o formulário seja arrastado pela tela) -->
<asp:Button runat="server" ID="btShowPanel1" Style="display: none" />
<asp:ModalPopupExtender ID="ModalPopupExtender1" runat="server" TargetControlID="btShowPanel1"
    PopupControlID="Panel1" PopupDragHandleControlID="Panel1DragHandle" BackgroundCssClass="modalBackground" />
    
<div class="pageSection">
    <asp:Panel runat="Server" ID="Panel1DragHandle" CssClass="drag">
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td class="tbTitulo_bordaEsquerda">
                    &nbsp;
                </td>
                <td class="tbTitulo_BG">
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td width="250" class="tbTitulo_NomeTela" align="left">
                                <asp:Label runat="server" SkinID="normal" ID="lbOperacao" />
                            </td>
                            <td width="*">
                                <asp:Image ID="Image2" runat="server" Width="18" Height="36" ImageAlign="Right" ImageUrl="~/imgsCCAB/tbTitulo_imgMarcador.jpg" />
                            </td>
                            <td width="265" class="tbTitulo_NomeTela" align="left">
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
    </asp:Panel>
</div>
<!-- Área de Mensagens -->
<div>
    <asp:ValidationSummary EnableClientScript="true" ID="ValidationSummary1" ShowSummary="false"
        ShowMessageBox="true" ValidationGroup="Form" HeaderText="O formulário contém erros:"
        runat="server" />
    <asp:CustomValidator ID="CustomValidator1" runat="server" ValidationGroup="Form" />
</div>
<!-- Formulário -->
<div>
    <asp:FormView ID="FormView1" runat="server" DataKeyNames="cdGrupoAcessoSEQ" CellPadding="5"
        AutoGenerateRows="false" Width="100%" GridLines="None">
        
        <EditItemTemplate>
            <div class="pageSection">
                <asp:HiddenField ID="cdGrupoAcessoSEQ" runat="server" Value='<%# Bind("cdGrupoAcessoSEQ") %>' />
                <asp:HiddenField ID="cdUsuarioUltimaAlteracao" runat="server" />
                <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tbCadastro_Mestra">
                    <tr>
                        <td valign="middle" class="fonteTbCadastro">
                            Nome do Grupo:*
                        </td>
                        <td class="tdCamposFormularios">
                            <conv:TextBox Type="Text" StrictText="true" ID="dsGrupoAcesso" runat="server" ValidationGroup="Form"
                                Columns="35" MaxLength="30" CssClass="campoTexto" Text='<%# Bind("dsGrupoAcesso") %>' />
                        </td>
                        <td>
                            <asp:RequiredFieldValidator Display="None" ID="RequiredFieldValidator0" runat="server" ErrorMessage="Nome do Grupo é campo obrigatório"
                                Text="*" ForeColor="#f6f6f6" EnableClientScript="true" ValidationGroup="Form"
                                ControlToValidate="dsGrupoAcesso" />
                        </td>
                    </tr>
                    <tr>
                        <td valign="middle" class="fonteTbCadastro">
                            Observação:
                        </td>
                        <td class="tdCamposFormularios">
                            <conv:TextBox Type="Text" ID="wkGrupoAcesso" runat="server" ValidationGroup="Form"
                                Columns="50" Rows="5" TextMode="MultiLine" onkeyup="blocTexto(this, 255)" 
                                CssClass="campoTexto" Text='<%# Bind("wkGrupoAcesso") %>' />
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td class="fonteTbCadastro">
                            Situação:*
                        </td>
                        <td class="tdCamposFormularios">
                            <asp:DropDownList ID="cdIndicadorStatusGrupoAcesso" runat="server"   
                                CssClass="campoTexto" OnPreRender="ConfigCombo" DataValueField="vrDominioCodigoReferenciado" 
                                DataTextField="wkDominioCodigoReferenciado" DataSourceID="ObjectDataSource1" /> 
                        </td>
                        <td>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ErrorMessage="Situação é campo obrigatório"
                                Text="*" ForeColor="#f6f6f6" EnableClientScript="true" ValidationGroup="Form"
                                ControlToValidate="cdIndicadorStatusGrupoAcesso" InitialValue="0" />
                        </td>
                    </tr>
                </table>
            </div>
            <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="ObterLista" TypeName="CodigoReferenciado">
                <SelectParameters>
                    <asp:Parameter Name="dsDominioCodigoReferenciado" DefaultValue="DMESPINDICADORATIVOINATIVO" Type="String" />
                </SelectParameters>
            </asp:ObjectDataSource>
        </EditItemTemplate>          
    </asp:FormView>
    <div style="text-align: right;">
        <asp:Button runat="server" ID="btAction" CssClass="button" ValidationGroup="Form"
            CausesValidation="true" OnCommand="btAction_OnClick" />
        <asp:Button runat="server" ID="btCancel" CommandName="Cancel" CssClass="button" Text="cancelar" 
            CausesValidation="false" OnCommand="btCancel_OnClick" />
    </div>
</div>

