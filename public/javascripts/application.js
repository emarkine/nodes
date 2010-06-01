jQuery.ajaxSetup({ 'beforeSend': function(xhr) {
    xhr.setRequestHeader("Accept", "text/javascript")
} });

jQuery(document).ajaxError(function(event, request, settings) {
    alert("Error AJAX request: ");
    $("#error").html(request.responseText);
});


jQuery.fn.elementlocation = function() {
    var curleft = 0;
    var curtop = 0;

    var obj = this;

    do {
        curleft += obj.attr('offsetLeft');
        curtop += obj.attr('offsetTop');

        obj = obj.offsetParent();
    } while (obj.attr('tagName') != 'BODY');


    return ( {x:curleft, y:curtop} );
};

jQuery.fn.id = function() {
    var obj = this;
    var node = this.parent();
    return node.attr('id');
};

jQuery.fn.drag = function() {
    this.draggable({
        cursor: "move", // меняем тип курсора
        revert: "invalid", // элемент не возвратится в предыдущую позицию только в том случае, если он был «сброшен» в целевой элемент
        zIndex: 1, // плаваем сверху всех
        //        snap: true,  //  прилипание к элементу у которого установлен класс ui-draggable
        //       snapMode: 'inner', //  опция определяет, как именно перемещаемый элемент будет «прилипать» к выбранным элементам
        //        delay: 500, // отсрочка начала времени перемещения элемента в миллисекундах.
        //        distance: 10,  // расстояние в пикселах, на которое должен переместиться курсор при удерживаемой в нажатом положении левой клавиши мыши прежде, чем начнется перемещение элемента
        scroll: false, // при перемещении элемента к краю области просмотра не склролится

        opacity : 0.5  // полупрозрачность
    });
}

// все div с классом draggable можно будет такскать туда-сюда
$(function() {
    $("div.draggable").drag();
});


// добавляем поле для ввода ключей
$(function() {
    $('div.editor').dblclick(function(event) {
        $("#error").html('');
        var id = $(this).attr('id');
        var location = $(this).elementlocation();
        var width = $(this).width();
        var height = $(this).height();
        $("#width-debug").text(width);
        $("#height-debug").text(height);
        var x = event.pageX - location.x;
        var y = event.pageY - location.y;
        $("#x-debug").text(x);
        $("#y-debug").text(y);
        if (y > height) { // если кликнули внизу области где marging
            if ($('#add-key-div').length == 0) { // если елемент не существует
                $(this).append("<div id='add-key-div' class='line'><input id='add-key' type='text' size='10' /></div>"); // добовляем поле ввода
                $('#add-key').focus(); // фокусируем его
                $('#add-key').blur(function() {  // если фокус потеряли
                    var text = $('#add-key').val().trim(); // берем значение текста
                    if (text) { // если туда что-то ввели
                        //                        alert("text: " + text + " id: " + id);
                        $.getJSON("/nodes/add_key", { id: id, key: text }, function(data) {
                            if (!data.error) {
                                $('div.editor').append("<div class='key-container line draggable' " +
                                                       "key='" + text + "'>" +
                                                       "<div class='key'>" + text + "</div></div>");
                                var new_key = $('div.editor').children().last();
                                new_key.drag(); // можно таскать только что вставленный елемент
                                new_key.add_values(); // и вставляет ему значения
                            } else {
                                $("#error").html(data.error);
                            }
                        });
                    }
                    $('#add-key-div').remove();
                });
            }
        }
    });
});


//  добавляем поля для ввода значений
jQuery.fn.add_values = function() {
    this.dblclick(function(event) {
        $("#error").html('');
        var container = $(this);
        var id = $(this).id();
        var key = $(this).attr('key');
        if ($('#add-value-div').length == 0) { // если елемент не существует
            $(this).append("<div id='add-value-div'><input id='add-value' type='text' size='20' /></div>"); // добовляем поле ввода
            $('#add-value').focus(); // фокусируем его
            $('#add-value').blur(function() {  // если фокус потеряли
                var text = $('#add-value').val().trim(); // берем значение текста
                if (text) { // если туда что-то ввели
                    $.getJSON("/nodes/add_value", { id: id, key: key,  value: text }, function(data) {
                        if (!data.error) {
                            container.append("<div class='value draggable'>" + text + "</div>");
                            container.children().last().drag(); // можно таскать только что вставленный елемент
                        } else {
                            $("#error").html(data.error);
                        }
                    });
                }
                $('#add-value-div').remove();
            });
        }
    });
}

// определям выброс в корзинку
$(function() {
    $('div#trash').droppable({
        tolerance : 'touch',
        accept : 'div.draggable',
        drop : function(event, ui) {
            $("#error").html('');
            var elm = $(ui.draggable);
            if (elm.hasClass('key-container')) {
                var key = elm.children().first().text().trim();
                $.getJSON("/nodes/delete_key", { id: elm.id(), key: key }, function(data) {
                    if (!data.error) {
                        elm.remove();
                    } else {
                        $("#error").html(data.error);
                    }
                });
            }
            if (elm.hasClass('value')) {
                var index = elm.attr('index');
                var container = elm.parent();
                var key = container.attr('key');
                var id = container.parent().attr('id');
                $.getJSON("/nodes/delete_value", { id: id, key: key, index: index }, function(data) {
                    if (!data.error) {
                        elm.remove();
                    } else {
                        $("#error").html(data.error);
                    }
                });
            }
        }
    });
});



$(document).ready(function() {
    $('div.key-container').add_values();
});
