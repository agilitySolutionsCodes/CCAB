<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="~/Message.aspx.cs" Inherits="Message" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    
    
    
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
        
            <asp:Button runat="server" ID="btShowModalPopup" Style="display: none" />
            <asp:ModalPopupExtender ID="ModalPopupExtender1" runat="server" TargetControlID="btShowModalPopup"
                PopupControlID="pnlMessage" PopupDragHandleControlID="pnlMessage" 
                BackgroundCssClass="modalBackground" CancelControlID="btFechar" />
                
            <asp:Panel ID="pnlMessage" runat="server" Style="display: none;">
                <asp:HiddenField ID="errMsg" runat="server" />
                    <div class="popup">
                        <div class="msgHeaderImage">
                            <span>
                                <asp:Image ID="Image1" runat="server" ImageAlign="Left" />
                            </span>
                            <h2 class="msgTitle"><%= MessageType %></h2>
                        </div>
                        <fieldset class="fieldsetForm">
                            <p>
                                <asp:Label SkinID="normal" ID="lblSource" runat="server" />
                            </p>
                            <p>
                                <asp:Label SkinID="normal" ID="lblMessage" runat="server" />
                            </p>
                            <% if (Request["tp"] == "err")
                               {%>
                            <p>
                                <b>Reporte o erro:<br /><br />
                                </b>Clique <span>
                                    <asp:LinkButton runat="server" ID="LinkButton1" PostBackUrl="~/_SUP/ErrReport.aspx"
                                        Text="aqui" />
                                </span>para enviar esta informação à equipe de suporte.
                            </p>
                            <%} %>
                            <div class="buttonalign">
                                <asp:Button ID="btFechar" Text="Fechar" runat="server" CssClass="button" />
                            </div>
                        </fieldset>
                    </div>
            </asp:Panel>
            
        </ContentTemplate>
    </asp:UpdatePanel>
    
</asp:Content>

