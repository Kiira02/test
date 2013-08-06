<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Welcome to Inet Magaz</title>

    <script src="./Scripts/jquery-1.9.1.min.js" type="text/javascript"></script>
    <script src="./Scripts/Common.js" type="text/javascript"></script>
    <script src="./Scripts/jquery-ui.js" type="text/javascript"></script>
    <script src="./Scripts/jquery.imagesloaded.min.js" type="text/javascript"></script>
    <script src="./Scripts/jquery.tmpl.min.js"></script>
    <script src="./Scripts/jquery.blockUI.js"></script>
    <script src="./Scripts/jquery.cycle.all.min.js"></script>
    <script src="./Scripts/jquery.color.js"></script>
    <script src="./Scripts/xfade.js"></script>
    <script src="./Scripts/masonry.pkgd.min.js"></script>
    <script type="text/javascript">
        $(window).load(function () {
            ButtinsBund();
            LoadProducts();
        });
    </script>

    <link href="../../Content/Style.css" rel="stylesheet" type="text/css" />
</head>

<body class="MainBg">
    <form id="form1" runat="server">
    <div class="RegisterContainer">
        <div id="RegisterPopin" style="display: none;" class="Container">
            <table cellpadding="0" cellspacing="0" class="RegisterBg">
                <tr>
                    <td>
                        <table cellpadding="0" cellspacing="0">
                            <tr>
                                <td>
                                    <div class="TextAlign">
                                        <span class="Txt">Your Name</span>
                                    </div>
                                    <input id="regName" class="Input" value="Name..."/>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="TxtContainer">
                                        <span class="Txt">Your Email</span>
                                    </div>
                                    <input id="regEmail" class="Input" value="Email..."/>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="TxtContainer">
                                        <span class="Txt">Your Password</span>
                                    </div>
                                    <input id="regPassword" class="Input" value="Password..."/>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td>
                        <table cellpadding="0" cellspacing="0" class="OkButtonContainer">
                            <tr>
                                <td>
                                    <div id="regOkBttn" class="OkButtonLeft" >
                                        <span class="Txt">OK</span>
                                    </div>
                                </td>
                                <td>
                                    <div class="OkButtonRight"></div>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td>
                        <table cellpadding="0" cellspacing="0" class="CancelButtonContainer">
                            <tr>
                                <td>
                                    <div class="Left"></div>
                                </td>
                                <td>
                                    <div id="regCancelBttn" class="Center">
                                        <span class="Txt">CANCEL</span>
                                    </div>
                                </td>
                                <td>
                                    <div class="Right"></div>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <div id="RegErrorMsg" class="ErrorMessage">
                <span class="Txt"></span>
            </div>
        </div>
        <div id="LoginPopin" style="display: none;" class="Container">
            <table cellpadding="0" cellspacing="0" class="LoginBg">
                <tr>
                    <td>
                        <table cellpadding="0" cellspacing="0">
                            <tr>
                                <td>
                                    <div class="TextAlign">
                                        <span class="Txt">Login</span>
                                    </div>
                                    <input id="LoginInpt" class="Input" value="Email..."/>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="TextAlign" style="margin-top: 3px;">
                                        <span class="Txt">Password</span>
                                    </div>
                                    <input id="PasswordInpt" class="Input" value="Password..."/>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td>
                        <table cellpadding="0" cellspacing="0" class="OkButtonContainer">
                            <tr>
                                <td>
                                    <div id="LoginBttn" class="Center">
                                        <span class="Txt">OK</span>
                                    </div>
                                </td>
                                <td>
                                    <div class="Right"></div>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td>
                        <table cellpadding="0" cellspacing="0" class="RegisterButton">
                            <tr>
                                <td>
                                    <div class="Left"></div>
                                </td>
                                <td>
                                    <div id="RegisterBttn" style="background-color: black; height: 47px;width: 105px; line-height: 50px; cursor: pointer;">
                                        <span style="margin-left: 6px; font-family: MetalGear; color: white;">REGISTER</span>
                                    </div>
                                </td>
                                <td>
                                    <div style="background-image: url(./Content/Images/right-bg-bttn2.png); height: 47px; width: 24px;"></div>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <div id="ErrorMsg" style="display: none; position: relative;bottom: 212px; left: 10px;">
                <span style="font-family: MetalGear; color: red; font-size: 17pt;"></span>
            </div>
        </div>
        <div id="basket" style="display: none;">
            <table cellpadding="0" cellspacing="0" style="width: 100%">
                <tr>
                    <td>
                        <div id="basketID"></div>
                    </td>
                </tr>
                <tr>
                    <td>

                        <div class="BuyGameBttn">
                            <span class="Span">Buy Games</span>
                        </div>
                        <div id="total" style="float: right; width: 20px; height: 40px;"></div>
                        <div class="BuyGameBttn">
                            <span class="Span">Totals</span>
                        </div>
                    </td>
                </tr>
            </table>

        </div>
        <table cellspacing="0" cellpadding="0" style="width: 100%;">
            <tr>
                <td>
                    <div style="background-image: url(./Content/Images/logo.png); background-repeat: no-repeat; height: 125px; width: 100%"></div>
                </td>
            </tr>
            <tr>
                <td>
                    <table cellpadding="0" cellspacing="0" style="height: 125px; width: 100%; margin-top: -125px;">
                        <tr>
                            <td style="width: 213px">
                                <table cellpadding="0" cellspacing="0" style="margin-left: 130px; margin-bottom: 1px; height: 76px;">
                                    <tr>
                                        <td>
                                            <div id="homeBtn" style="width: 59px; height: 47px; line-height: 50px; cursor: pointer; background-color: white" >
                                                <span style="margin-left: 9px; font-family: MetalGear;">HOME</span>
                                            </div>
                                        </td>
                                        <td>
                                            <div id="homeBtnRgth" style="height: 47px; width: 24px;" class="BgWhite"></div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" style="height: 14px;">
                                            <div id="star1" style="background-image: url(./Content/Images/star1.png); height: 10px; width: 9px; margin-top: -11px; margin-left: 31px; display: none;"></div>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td style="width: 125px">
                                <table cellpadding="0" cellspacing="0" style="margin-bottom: 1px; margin-left: -17px;">
                                    <tr>
                                        <td>
                                            <div style="background-image: url(./Content/Images/left-bg-bttn.png); height: 47px; width: 25px;"></div>
                                        </td>
                                        <td>
                                            <div id="gameBtn" style="background-color: white; height: 47px;width: 105px; line-height: 50px; cursor: pointer;">
                                                <span style="margin-left: 6px; font-family: MetalGear;">BUY GAME</span>
                                            </div>
                                        </td>
                                        <td>
                                            <div style="background-image: url(./Content/Images/right-bg-bttn.png); height: 47px; width: 24px;"></div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" style="height: 14px;">
                                            <div id="star2" style="background-image: url(./Content/Images/star2.png); height: 10px; width: 22px; margin-top: 4px; margin-left: 59px; display: none;"></div>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td style="width: 182px;">
                                <table cellpadding="0" cellspacing="0" style="margin-bottom: 1px; margin-left: -17px;">
                                    <tr>
                                        <td>
                                            <div style="background-image: url(./Content/Images/left-bg-bttn.png); height: 47px; width: 25px;"></div>
                                        </td>
                                        <td>
                                            <div id="accessoriesBtn" style="background-color: white; height: 47px;width: 176px; line-height: 50px;cursor: pointer;">
                                                <span style="margin-left: 6px;font-family: MetalGear;">BUY ACCESSORIES</span>
                                            </div>
                                        </td>
                                        <td>
                                            <div style="background-image: url(./Content/Images/right-bg-bttn.png); height: 47px; width: 24px;"></div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" style="height: 14px;">
                                            <div id="star3" style="background-image: url(./Content/Images/star3.png); height: 10px; width: 41px; margin-top: 4px; margin-left: 76px; display: none;"></div>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td style="width: 481px;">
                                <table cellpadding="0" cellspacing="0" style="margin-bottom: 15px; margin-left: -9px;">
                                    <tr>
                                        <td>
                                            <div style="background-image: url(./Content/Images/left-bg-search.png); height: 31px; width: 17px;"></div>
                                        </td>
                                        <td>
                                            <table cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td>
                                                        <div style="background-color: white; height: 31px;">
                                                            <input id="searchInpt" class="SearchInput" value="Search..."/>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div id="findBttn" style="width: 40px; background-color: white; height: 31px; line-height: 34px;cursor: pointer;">
                                                            <span style="margin-left: 5px;font-family: MetalGear;">FIND</span>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td>
                                            <div style="background-image: url(./Content/Images/right-bg-search.png); height: 31px; width: 24px;"></div>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td>
                                <div style="height: 1px; width: 1px;"></div>
                            </td>
                            <td style="min-width: 280px;">
                                <table id="EnterBtnContainer" cellpadding="0" cellspacing="0" class="EnterBttnTable">
                                    <tr>
                                        <td>
                                            <div style="background-image: url(./Content/Images/right-bg-reverse-bttn.png); height: 47px; width:24px;"></div>
                                        </td>
                                        <td>
                                            <div id="enterBtn"style="background-color: white; width: 80px; height: 47px; cursor: pointer; line-height: 47px;">
                                                <span style="margin-left: 11px; font-family:  MetalGear">ENTER</span>
                                            </div>
                                        </td>
                                        <td>
                                            <div style="background-image: url(./Content/Images/right-bg-bttn.png); height: 47px; width:24px;"></div>
                                        </td>
                                    </tr>
                                </table>
                                <div id="NameContainer" class="NameInHeader" style="display: none">
                                    <table cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td>
                                                <span class="WelcomeBack"></span>
                                            </td>
                                            <td>
                                                <table cellpadding="0" cellspacing="0">
                                                    <tr>
                                                        <td>
                                                            <div class="BasketBttn">
                                                                <span class="Span">BASKET</span>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <div class="LogOutBttn">
                                                                <span class="Span">LOG<p>OUT</p></span>
                                                            </div>                                                        
                                                        </td>
                                                    </tr>
                                                </table>


                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <div id="test2"></div>
                    <div style="height: 900px;">
                        <div id="testing" class="itemConteiner"></div>
                    </div>
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>

</html>
