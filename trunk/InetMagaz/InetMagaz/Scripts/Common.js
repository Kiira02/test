function ButtinsBund() {
    $.ajaxSetup({ async: false });
    LoadHomePage('HomePage');

    var userId = getCookie("userID");

    if (userId != "") {
        $.post("Database/AutoLogin", { ID: userId }, function (data) {
            $("#EnterBtnContainer").css("display", "none");
            $("#NameContainer").css("display", "");
            $("span.WelcomeBack", "#NameContainer").html("WELCOME BACK TOVARISCH <p>" + data.UserName + " </p>");
        });
    }

    $("#homeBtn").bind("click", function() {
        LoadHomePage('HomePage');
    });

    $("#homeBtn").bind("mouseover", function () {
        $("#star1").css("display", "");
        $(this).children().css('color', 'red');
    });
    $("#homeBtn").bind("mouseout", function () {
        $("#star1").css("display", "none");
        $(this).children().css('color', 'black');
    });
    $("#gameBtn").bind("click", function() {
        LoadHomePage('BuyGames', true, '7');
    });
    $("#gameBtn").bind("mouseover", function () {
        $("#star2").css("display", "");
        $(this).children().css('color', 'red');
    });
    $("#gameBtn").bind("mouseout", function () {
        $("#star2").css("display", "none");
        $(this).children().css('color', 'black');
    });
    $("#accessoriesBtn").bind("mouseover", function () {
        $("#star3").css("display", "");
        $(this).children().css('color', 'red');
    });
    $("#accessoriesBtn").bind("mouseout", function () {
        $("#star3").css("display", "none");
        $(this).children().css('color', 'black');
    });
    $("#findBttn").bind("mouseover", function () {
        $(this).children().css('color', 'red');
    });
    $("#findBttn").bind("mouseout", function () {
        $(this).children().css('color', 'black');
    });
    $("#findBttn").bind("click", function () {
        SearchForProducts($("#searchInpt").val());
        $("#searchInpt").animate({ backgroundPositionX: '+=20px' }, 500);
    });
    $("#searchInpt").bind("click", function () {
        if ($(this).val().indexOf('Search') + 1) {
            $(this).val('');
            return;
        }
    });
    $("#searchInpt").bind("focusout", function() {
        if ($(this).val().replace(/\s+/g, "") == "") $("#searchInpt").val('Search...');
    });
    $("#enterBtn").bind("mouseover", function () {
        $(this).children().css('color', 'red');
    });
    $("#enterBtn").bind("mouseout", function () {
        $(this).children().css('color', 'black');
    });
    $("#enterBtn").bind("click", function () {
        $("#LoginPopin").css("display", "");
        $("#ErrorMsg").css("display", "none");
        $("#regName").val('Name...');
        $("#regEmail").val('Email...');
        $("#regPassword").val('Password...');
        $.blockUI.defaults.css.cursor = 'default';
        $.blockUI({
            message: $('#LoginPopin'),
            onBlock: function () {
                $('.blockOverlay').bind("click", function () { $.unblockUI({onUnblock: function() {
                        $("#LoginPopin").css("display", "none");
                    }});
                });
            }
        });
        
    });

    $("div.BasketBttn").bind("click", function () {
        $.post("Database/GetProducts", function (data) {
            $.get('Templates/Basket.html', function (templ) {
                LoadTemplateForBasket(templ, data);
            }, 'html');
        });
        $("#basket").css("display", "");
        $.blockUI.defaults.css.cursor = 'default';
        $.blockUI({
            message: $('#basket'),
            onBlock: function () {
                $('.blockOverlay').bind("click", function () {
                    $.unblockUI({
                        onUnblock: function () {
                            $("#basket").css("display", "none");
                        }
                    });
                });
            }
        });
    });

    $("#RegisterBttn").bind("click", function () {
        $('#regEmail').css('background-color', 'black');
        $.blockUI({
            message: $('#RegisterPopin'),
            onBlock: function () {
                $("#RegisterPopin").css("display", "");
                $("#LoginPopin").css("display", "none");
                $('.blockOverlay').bind("click", function () { $.unblockUI({onUnblock: function() {
                        $("#RegisterPopin").css("display", "none");
                    }});
                });
            }
        });
    });

    $("#regCancelBttn").bind("click", function() {
        $.unblockUI({
            onUnblock: function() {
                $("#RegisterPopin").css("display", "none");
            }
        });
    });

    $("#LoginBttn").bind("click", function () {
        $.post("Database/LogOn", { email: $("#LoginInpt").val(), password: $("#PasswordInpt").val() }, function (data) {
            if (data.Status == false) {
                $("#ErrorMsg").css("display", "");
                $("#ErrorMsg").children().html('ERROR!!! AUTHENTICATION FAIL');
                $("#ErrorMsg").children().stop().animate({ opacity: '0.5' }, 300, function () { $("#ErrorMsg").children().stop().animate({ opacity: '1' }, 300); });
            } else {
                $("#ErrorMsg").css("display", "");
                $("#ErrorMsg").children().html('WELCOME COMRADE!');
                $("#ErrorMsg").children().stop().animate({ opacity: '0.5' }, 500, function () {
                    $("#ErrorMsg").children().stop().animate({ opacity: '1' }, 500, function () {
                        $("#LoginPopin").css("display", "none");
                        $("#ErrorMsg").css("display", "none");
                        $("#EnterBtnContainer").css("display", "none");
                        $("#NameContainer").css("display", "");
                        $("span.WelcomeBack", "#NameContainer").html("WELCOME BACK TOVARISCH <p>" + data.userName + " </p>");
                        $.unblockUI({onUnblock: function() {
                                $("#LoginPopin").css("display", "none");
                            }});
                    });
                });
                setCookie("userID", data.userId.toString(), { expires: 1800 });
            }
        });
    });

    $("#regOkBttn").bind("click", function () {
        var pattern = /^[a-z0-9_-]+@[a-z0-9-]+\.([a-z]{1,6}\.)?[a-z]{2,6}$/i;
        var mail = $('#regEmail');

        if (mail.val().search(pattern) == 0) {
        $.post("Database/Register", { name: $("#regName").val(), email: $("#regEmail").val(), password: $("#regPassword").val() }, function(data) {
            if (data.Status == true) {
                $("#RegErrorMsg").children().html("NOW YOU'RE WITH US'");
                $("#RegErrorMsg").css("display", "");
                $("#RegErrorMsg").children().stop().animate({ opacity: '0.5' }, 500, function () {
                    $("#RegErrorMsg").children().stop().animate({ opacity: '1' }, 500, function () {
                        $.unblockUI({onUnblock: function() {
                            $("#RegisterPopin").css("display", "none");
                        }});
                    });
                });
            } else {
                $("#RegErrorMsg").children().html('THIS EMAIL ALREADY EXIST!');
                $("#RegErrorMsg").css("display", "");
                $("#RegErrorMsg").children().stop().animate({ opacity: '0.5' }, 300, function () { $("#RegErrorMsg").children().stop().animate({ opacity: '1' }, 300); });
            }
        });
        } else {
            $('#regEmail').css('background-color', 'red');
            $('#regEmail').animate({ backgroundColor: 'red' }, 300, function () {
                $('#regEmail').animate({ backgroundColor: 'black' }, 300);
            });
        }
    });

    $("div.LogOutBttn", "#NameContainer").bind("click", function() {
        $("#EnterBtnContainer").css("display", "");
        $("#NameContainer").css("display", "none");
        deleteCookie("userID");
        deleteCookie('gameID');
    });

    $("#regName").bind("click", function() {
        if ($(this).val().indexOf('Name') + 1) {
            $(this).val('');
            return;
        }
    });
    
    $("#regEmail").bind("click", function () {
        if ($(this).val().indexOf('Email') + 1) {
            $(this).val('');
            return;
        }
    });
    
    $("#regPassword").bind("click", function () {
        if ($(this).val().indexOf('Password') + 1) {
            $(this).val('');
            return;
        }
    });
    
    $("#LoginInpt").bind("click", function () {
        if ($(this).val().indexOf('Email') + 1) {
            $(this).val('');
            return;
        }
    });

    $("#PasswordInpt").bind("click", function () {
        if ($(this).val().indexOf('Password') + 1) {
            $(this).val('');
            return;
        }
    });

    $("#regName").bind("focusout", function () {
        if ($(this).val().replace(/\s+/g, "") == "") $("#regName").val('Name...');
    });

    $("#regEmail").bind("focusout", function () {
        if ($(this).val().replace(/\s+/g, "") == "") $("#regEmail").val('Email...');
    });

    $("#regPassword").bind("focusout", function () {
        if ($(this).val().replace(/\s+/g, "") == "") $("#regPassword").val('Password...');
    });
    
    $("#LoginInpt").bind("focusout", function () {
        if ($(this).val().replace(/\s+/g, "") == "") $("#LoginInpt").val('Email...');
    });

    $("#PasswordInpt").bind("focusout", function () {
        if ($(this).val().replace(/\s+/g, "") == "") $("#PasswordInpt").val('Password...');
    });
}

function LoadTempl2(data, type) {
    $(data).each(function () {
        if (type == "7" || type == this.categoryType) {
            $('<div/>', {
                id: this.ProductID + "_template",
                addClass: 'item2',
                attr: { gameCont: "1" }
            }).appendTo('#test');
        
            $('<div/>', {
                id: this.ProductID + "_container",
                addClass: "gameTextContainer gameTextProp"
            }).appendTo("#" + this.ProductID + "_template");
        
            $('<img/>', {
                id: this.ProductID + "_image",
                src: this.ImageUrl,
                css: { position: 'relative', maxWidth: '300px'}
            }).appendTo("#" + this.ProductID + "_template");
        
            $('<span></span>', {
                id: this.ProductID + "_span",
                text: this.Name,
                addClass: "span"
            }).appendTo("#" + this.ProductID + "_container");
        
            $('<div/>', {
                id: this.ProductID + "_descrId",
                attr: { descrContainer: "1" },
                addClass: 'gameExplCont',
                css: {height: "100%"}
            }).appendTo("#" + this.ProductID + "_template");

            $('<span></span>', {
                id: this.ProductID + "_description",
                text: this.Description,
                addClass: 'descriptProp'
            }).appendTo("#" + this.ProductID + "_descrId");
        
            $('<div/>', {
                id: this.ProductID + "_buyButton",
                addClass: "buyButtonGame"
            }).appendTo("#" + this.ProductID + "_descrId");
        
            $('<span/>', {
                text: "Buy Game"
            }).appendTo("#" + this.ProductID + "_buyButton");

            var template = $("#" + this.ProductID + "_template");
        
            template.bind("click", function () {
                $(this).stop();
                $('img', this).css('top', 0);
                $('#test').masonry();
            });
        
            template.bind('mouseover', function () {
                var obj = this;
                var heAnim = $('img', this).height();
            
                if ($(obj).width() == 300) {
                        setTimeout(function() {
                            $('img', obj).stop().animate({ top: -heAnim }, 200);
                            $('div.gameTextContainer', obj).removeClass('gameTextProp').addClass('gameTextPropOver');
                            $('div.gameTextContainer', obj).css('background-color', '#4D7BD6');
                            $('div.gameTextContainer', obj).css('color', 'white');
                            $('div.gameTextContainer', obj).stop().animate({ bottom: +heAnim - 35 }, 200);
                            $('div[descrContainer="1"]', obj).stop().animate({ marginTop: -heAnim }, 200);
                        }, 300);
                    } else {
                        $('img', obj).stop().css('top', 0);
                        $('div.gameTextContainer', obj).removeClass('gameTextProp').addClass('gameTextPropOver');
                        $('div.gameTextContainer', obj).css('background-color', 'aliceblue');
                        $('div.gameTextContainer', obj).css('color', 'black');
                        $('div.gameTextContainer', obj).stop().css('bottom', 0);
                        $('div[descrContainer="1"]', obj).stop().css('margin-top', 0);
                    }
            });
        
            template.bind('mouseout', function () {
                var obj = this;
                var heAnim = $('img', this).height();
                setTimeout(function() {
                    if ($(obj).width() == 300) {
                        $('img', obj).stop().animate({ top: 0 }, 200);
                        $('div.gameTextContainer', obj).removeClass('gameTextPropOver').addClass('gameTextProp');
                        $('div.gameTextContainer', obj).css('background-color', 'aliceblue');
                        $('div.gameTextContainer', obj).css('color', 'black');
                        $('div.gameTextContainer', obj).stop().animate({ bottom: 0 }, 200);
                        $('div[descrContainer="1"]', obj).stop().animate({ marginTop: 0 }, 200);
                    } else {
                        $('img', obj).stop().css('top', 0);
                        $('div.gameTextContainer', obj).removeClass('gameTextPropOver').addClass('gameTextProp');
                        $('div.gameTextContainer', obj).css('background-color', 'aliceblue');
                        $('div.gameTextContainer', obj).css('color', 'black');
                        $('div.gameTextContainer', obj).stop().css('bottom', 0);
                        $('div[descrContainer="1"]', obj).stop().css('margin-top', 0);
                    }
                }, 300);
            });
            setTimeout(function() {
                $('#test').masonry();
            }, 300);
        }
    });
    
    $('#test').masonry({
        itemSelector: '.item2',
        singleMode: false,
        isResizable: true,
        isAnimated: true,
        animationOptions: {
            queue: false,
            duration: 500
        }
    });
    
    $('img').load(function() {
        var he = $(this).height();
        $(this).parent().css('height', he);
        $('span.descriptProp', $(this).parent()).css('height', he - 70);
        $('#test').css('height', 900);
    });

    LoadCategories();
}

function LoadProducts(type) {
    $.post("Database/GetProducts", function (data) {
        $.get('Templates/Product.html', function () {
            LoadTempl2(data, type);
        }, 'html');
    });
}

function LoadCategories() {
    $.post("Database/GetCategories", function (data) {
        $.get('Templates/Category.html', function (templ) {
            $.template('categories', templ);
            $(data).each(function () {
                $.tmpl('categories', this, {
                    category: this.categoryType,
                    categoryName: this.CategoryName
                }).appendTo('#categoryName');
            });
        }, 'html');
    });
    BindEventForCategory();
}

function BindEventForCategory() {
    $('li.categoryStyle').each(function () {
        $(this).bind('click', function () {
            var type = $(this)[0].id.replace("CategoryType_", "");
            LoadHomePage('BuyGames', true, type);
        });

        $(this).bind('mouseover', function() {
            $(this).stop().animate({ backgroundColor: "#7AA5CE", color: "white" }, 200);
            $('div.categoryBg', this).css("border-right", "1px solid #7AA5CE");
        });
        
        $(this).bind('mouseout', function () {
            $(this).stop().animate({ backgroundColor: "white", color: "black" }, 200);
            $('div.categoryBg', this).css("border-right", "1px solid #d5d5d5");
        });
    });
}

function LoadTemplates(templ, data) {
    $.template('games', templ);
    $(data).each(function() {
        $.tmpl('games', this, {
            productID: this.ProductID,
            imageUrl: this.ImageUrl,
            description: this.Description,
            name: this.Name
        }).appendTo('#test');
    });
}

function LoadTemplateForBasket(templ, data) {
    $('#basketID').html('');
    $.template('gamesBasket', templ);
    var gameCook = getCookie('gameID');
    if (gameCook == undefined) {
        gameCook = '';
    }
    if (gameCook != '') {
        var productId = gameCook.split(';');
        var nPrice = 0;
        $(productId).each(function () {
            var item = this;
            $(data).each(function () {
                if (this.ProductID == item.toString()) {
                    $.tmpl('gamesBasket', this, {
                        productID: this.ProductID,
                        imageUrl: this.ImageUrl,
                        description: this.Name,
                        price: '$' + this.Price
                    }).appendTo('#basketID');
                    nPrice += parseFloat(this.Price.replace(new RegExp(",", 'g'), "."));
                }
            });
        });
        var totalPrice = nPrice;
        var o = 1;
    } else {
        $.tmpl('gamesBasket', this, {
            description: "There is no Games in Basket"
        }).appendTo('#basketID');
    }
}

function LoadHomePage(name, val, type) {
    $.get('Templates/' + name + '.html', function (templ) {
        $('#test2').html('');
        $.template('page', templ);
        $.tmpl('page').appendTo('#test2');
        if (val == true) {
            LoadProducts(type);
        }
    }, 'html');
}

function SearchForProducts(value) {
    if (value == 'Search...') {
        LoadHomePage('BuyGames', true, '7');
    } else {
        $.post("Database/SearchForProducts", { name: value }, function(val) {
            if (val == -1) {
                $.blockUI({
                    message: "Sorry, we can't find this!",
                    onBlock: function() {
                        $('.blockOverlay').bind("click", function() { $.unblockUI(); });
                    }
                });
            } else {
                LoadHomePage('BuyGames');
                LoadProducts();
                HideObgects(val);
            }
        });
    }
}

function HideObgects(id) {
    $('div[game=1]').each(function () {
        if (this.id != id.toString()) {
            $(this).hide();
        } else {
        }
    });
}

function AdminBttnBind() {
    $("div.GamesList").bind("click", function() {
        $("#UsersGridContainer").css("display", "none");
        $("#GameGridContainer").css("display", "");
    });

    $("div.UsersList").bind("click", function() {
        $("#UsersGridContainer").css("display", "");
        $("#GameGridContainer").css("display", "none");
    });

    $("div.GamesList").bind("mouseover", function () {
        $('div.GamesList').css("color", "#6666AA");
        $('div.GamesList').css("backgroundColor", "#EEEEF4");
        $('div.GamesList').css("borderColor", "#9999DD");
    });
    $("div.GamesList").bind("mouseout", function () {
        $('div.GamesList').css("color", "#888888");
        $('div.GamesList').css("backgroundColor", "#EEEEEE");
        $('div.GamesList').css("borderColor", "#BBBBBB");
    });

    $("div.UsersList").bind("mouseover", function () {
        $('div.UsersList').css("color", "#6666AA");
        $('div.UsersList').css("backgroundColor", "#EEEEF4");
        $('div.UsersList').css("borderColor", "#9999DD");
    });
    $("div.UsersList").bind("mouseout", function () {
        $('div.UsersList').css("color", "#888888");
        $('div.UsersList').css("backgroundColor", "#EEEEEE");
        $('div.UsersList').css("borderColor", "#BBBBBB");
    });
}

function setCookie(name, value, options) {
    options = options || {};

    var expires = options.expires;

    if (typeof expires == "number" && expires) {
        var d = new Date();
        d.setTime(d.getTime() + expires * 1000);
        expires = options.expires = d;
    }
    if (expires && expires.toUTCString) {
        options.expires = expires.toUTCString();
    }

    value = encodeURIComponent(value);

    var updatedCookie = name + "=" + value;

    for (var propName in options) {
        updatedCookie += "; " + propName;
        var propValue = options[propName];
        if (propValue !== true) {
            updatedCookie += "=" + propValue;
        }
    }

    document.cookie = updatedCookie;
}

function getCookie(name) {
    var matches = document.cookie.match(new RegExp(
      "(?:^|; )" + name.replace(/([\.$?*|{}\(\)\[\]\\\/\+^])/g, '\\$1') + "=([^;]*)"
    ));
    return matches ? decodeURIComponent(matches[1]) : undefined;
}

function deleteCookie(name) {
    setCookie(name, "", -1);
}