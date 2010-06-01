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

// ��� div � ������� draggable ����� ����� �������� ����-����
$(function() {
    $("div.draggable").draggable({
        cursor: "move", // ������ ��� �������
        revert: "invalid", // ������� �� ����������� � ���������� ������� ������ � ��� ������, ���� �� ��� ��������� � ������� �������
        zIndex: 1, // ������� ������ ����
        //        snap: true,  //  ���������� � �������� � �������� ���������� ����� ui-draggable
        //       snapMode: 'inner', //  ����� ����������, ��� ������ ������������ ������� ����� ����������� � ��������� ���������
        //        delay: 500, // �������� ������ ������� ����������� �������� � �������������.
        //        distance: 10,  // ���������� � ��������, �� ������� ������ ������������� ������ ��� ������������ � ������� ��������� ����� ������� ���� ������, ��� �������� ����������� ��������
        scroll: false, // ��� ����������� �������� � ���� ������� ��������� �� ����������

        opacity : 0.5  // ����������������
    });
});

// ��������� ������ � ��������
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

// ��������� ���� ��� �������������� ������ � ��������
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
        if ( y > height ) { // ���� �������� ����� ������� ��� marging
            if ( $('#add-key-div').length == 0 ) { // ���� ������� �� ����������
                $(this).append("<div id='add-key-div' class='line'><input id='add-key' type='text' size='10' /></div>"); // ��������� ���� �����
                $('#add-key').focus(); // ���������� ���
                $('#add-key').blur(function() {  // ���� ����� ��������
                    var text = $('#add-key').val().trim(); // ����� �������� ������
                    if ( text )  { // ���� ���� ���-�� �����
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
