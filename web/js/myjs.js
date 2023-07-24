function doLike(pid, uid) {
//    console.log(pid + " " + uid);

    const d = {
        uid: uid,
        pid: pid,
        operation: "like"
    };

    $.ajax({
        url: "LikeServlet",
        data: d,
        success: function (data, textStatus, jqXHR) {
            console.log(data);
            if (data.trim() === 'true') {
                // increment count
                let temp = ".like-counter-" + pid;
                let likecount = $(temp).html();
                likecount++;

                // update count
                $(temp).html(likecount);
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.log(textStatus);
        }
    });

}


