// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html";
import $ from "jquery";

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"

function update_buttons() {
  $('.manage-button').each( (_, bb) => {
    let owner_id = $(bb).data('owner-id');
    let manage = $(bb).data('manage');
    if (manage != "") {
      $(bb).text("Unmanage");
    }
    else {
      $(bb).text("Manage");
    }
  });
}

function set_button(owner_id, value) {
  $('.manage-button').each( (_, bb) => {
    if (owner_id == $(bb).data('owner-id')) {
      $(bb).data('manage', value);
    }
  });
  update_buttons();
}

function manage(owner_id) {
  let text = JSON.stringify({
    manage: {
        manager_id: current_owner_id,
        managee_id: owner_id
      },
  });

  $.ajax(manage_path, {
    method: "post",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: text,
    success: (resp) => { set_button(owner_id, resp.data.id); },
  });
}

function unmanage(owner_id, manage_id) {
  $.ajax(manage_path + "/" + manage_id, {
    method: "delete",
    dataType: "json",
    contentType: "application/json; charset=UTF-8",
    data: "",
    success: () => { set_button(owner_id, ""); },
  });
}

function manage_click(ev) {
  let btn = $(ev.target);
  let manage_id = btn.data('manage');
  let owner_id = btn.data('owner-id');

  if (manage_id != "") {
    unmanage(owner_id, manage_id);
  }
  else {
    manage(owner_id);
  }
}

function init_manage() {
  if (!$('.manage-button')) {
    return;
  }

  $(".manage-button").click(manage_click);

  update_buttons();
}

$(init_manage);
