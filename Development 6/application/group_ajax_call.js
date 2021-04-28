function GroupAjax(query,type) {

    
    var tmp_url = "/TextChat/"+type;
    var data = JSON.stringify({ "query": query });
    var info = [];
    $.ajax({
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        type: "post",
        cache: false,
        async: false,
        url: tmp_url,
        data: data,
        success: function (response) {

            info = response;

        },
        error: function (xhr) {
            alert("ajax calling failed");


        }
    });

    return info;
}
