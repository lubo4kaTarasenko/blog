// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//= require jquery3
//= require popper
//= require bootstrap
import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

require("trix")
require("@rails/actiontext")
global.$ = require('jquery')
const $ = global.$;

const main = function(){
  $(".clickable").click(function(){
      var url = $(this).find('a').attr("href")
      $(location).attr('href',url);
  });
  var token = $( 'meta[name="csrf-token"]' ).attr( 'content' );

  $.ajaxSetup( {
    beforeSend: function ( xhr ) {
      xhr.setRequestHeader( 'X-CSRF-Token', token );
    }
  });

  $(".vote").click(function(e){
    e.preventDefault()
    e.stopPropagation()
    let type = $(this).attr('name')  
    let comment_id = $(this).data('comment_id')
    let path = '/vote'
    $.ajax({
      method: "POST", 
      url: path, 
      data: {        
        comment_id: comment_id,
        positive: type
      },
      success: function(response){
        console.log(response)
        const location = window.location.toString().replace(/#.+/, '') + '#comment_' + comment_id;
        console.log(location)
        Turbolinks.visit(window.location)
      }
    })


  })
}

// $(document).ready(main)
$(document).on('turbolinks:load', main)
