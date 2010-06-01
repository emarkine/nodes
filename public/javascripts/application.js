jQuery(document).ajaxError(function(event, request, settings) {
    alert("Error AJAX request");
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

// все div с классом draggable можно будет такскать туда-сюда
$(function() {
    $("div.draggable").draggable({
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
});

// определям выброс в корзинку
$(function() {
    $('div#trash').droppable({
        //        tolerance : 'fit',
        accept : 'div.draggable',
        drop : function(event, ui) {
            //          alert("hollo drop!");
            //           $(this).append(ui.draggable);
        }
    });
});

// добавляем поля для редактирования ключей и значений
$(function() {
    $('div.editor').dblclick(function(event) {
        var location = $(this).elementlocation();
        var width = $(this).width();
        var height = $(this).height();
        $("#width-debug").text( width );
		$("#height-debug").text( height );
        var x = event.pageX - location.x;
        var y = event.pageY - location.y;
        $("#x-debug").text( x );
		$("#y-debug").text( y );
        if ( y > height ) { // если кликнули внизу области где marging
            if ( $('#add-key-div').length == 0 ) { // если елемент не существует
                $(this).append("<div id='add-key-div' class='line'><input id='add-key' type='text' size='10' /></div>"); // добовляем поле ввода
                $('#add-key').focus(); // фокусируем его
                $('#add-key').blur(function() {  // если фокус потеряли
                    var text = $('#add-key').val().trim(); // берем значение текста
                    if ( text )  { // если туда что-то ввели
                        var id = $(this).id; 
                        alert("text: "+text+ " id: "+id );
                        $.post("/nodes/add_key", { id: id, text: text } );
                    }
                });
            }
        }
    });
});


$(document).ready(function() {


});
