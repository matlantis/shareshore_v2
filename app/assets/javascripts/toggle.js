function toggle(id1, id2){
    var e = document.getElementById(id1);
    var f = document.getElementById(id2);
    
    if (e.style.display == "none"){
        e.style.display = "";
        f.className = "glyphicon glyphicon-chevron-down";
    } else {
        e.style.display = "none";
        f.className = "glyphicon glyphicon-chevron-right";
    }
}
