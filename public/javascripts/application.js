jQuery.ajaxSetup({ 'beforeSend': function(xhr) {
    xhr.setRequestHeader("Accept", "text/javascript")
} })

function _ajax_request(url, data, callback, type, method) {
    if (jQuery.isFunction(data)) {
        callback = data;
        data = {};
    }
    return jQuery.ajax({
        type: method,
        url: url,
        data: data,
        success: callback,
        dataType: type
    });
}

jQuery.extend({
    put: function(url, data, callback, type) {
        return _ajax_request(url, data, callback, type, 'PUT');
    },
    delete_: function(url, data, callback, type) {
        return _ajax_request(url, data, callback, type, 'DELETE');
    }
});

jQuery.fn.submitWithAjax = function() {
    this.unbind('submit', false);
    this.submit(function() {
        $.post(this.action, $(this).serialize(), null, "script");
        return false;
    })

    return this;
};

//Send data via get if <acronym title="JavaScript">JS</acronym> enabled
jQuery.fn.getWithAjax = function() {
    this.unbind('click', false);
    this.click(function() {
        $.get($(this).attr("href"), $(this).serialize(), null, "script");
        return false;
    })
    return this;
};

//Send data via Post if <acronym title="JavaScript">JS</acronym> enabled
jQuery.fn.postWithAjax = function() {
    this.unbind('click', false);
    this.click(function() {
        $.post($(this).attr("href"), $(this).serialize(), null, "script");
        return false;
    })
    return this;
};

jQuery.fn.putWithAjax = function() {
    this.unbind('click', false);
    this.click(function() {
        $.put($(this).attr("href"), $(this).serialize(), null, "script");
        return false;
    })
    return this;
};

jQuery.fn.deleteWithAjax = function() {
    this.removeAttr('onclick');
    this.unbind('click', false);
    this.click(function() {
        $.delete_($(this).attr("href"), $(this).serialize(), null, "script");
        return false;
    })
    return this;
};

//This will "ajaxify" the links
function ajaxLinks() {
    $('.ajaxForm').submitWithAjax();
    $('a.get').getWithAjax();
    $('a.post').postWithAjax();
    $('a.put').putWithAjax();
    $('a.delete').deleteWithAjax();
}


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

$(function() {
    $('div#trash').droppable({
        tolerance : 'fit',
        accept : 'div.draggable',
        drop : function(event, ui) {
            alert("hollo drop!");
            $(this).append(ui.draggable);
        }
    });
});

$(document).ready(function() {


    // All non-GET requests will add the authenticity token
    // if not already present in the data packet
    $(document).ajaxSend(function(event, request, settings) {
        if (typeof(window.AUTH_TOKEN) == "undefined") return;
        // <acronym title="Internet Explorer 6">IE6</acronym> fix for http://dev.jquery.com/ticket/3155
        if (settings.type == 'GET' || settings.type == 'get') return;

        settings.data = settings.data || "";
        settings.data += (settings.data ? "&" : "") + "authenticity_token=" + encodeURIComponent(window.AUTH_TOKEN);
    });

    ajaxLinks();


});
