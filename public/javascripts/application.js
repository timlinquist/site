function remove_fields(link) {
  $(link).previous("input[type=hidden]").value = "1";
  $(link).up(".form-field-set").hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).previous().insert({
    before: content.replace(regexp, new_id)
      });
}