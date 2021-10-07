        //20210325 RJ group deleting query
        function delete_group(org_id, dc_id) {
            var final_query_string = '{"org_id":"' + org_id + '","dc_id":"' + dc_id + '"}';
            var check = GroupDelete(final_query_string)
            
            console.log("Check: ", check,final_query_string);
        }

        //20210221 RJ ajax calling for deleting group
        function GroupDelete(query) {

            var data = JSON.stringify({ "query": query });
            var tmp_url = "/TextChat/DeleteGroup";
            var info = [];
            $("#accordion").ejAccordion("expandPanel", [1]);

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
