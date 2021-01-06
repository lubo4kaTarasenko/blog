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

  $('.open_children').click(function(){ 
    $(this).parent('.comment').find('> .hidden_c').removeClass('hidden_c');
    $(this).addClass('hidden_c')
  });

  $.ajaxSetup( {
    beforeSend: function ( xhr ) {
      xhr.setRequestHeader( 'X-CSRF-Token', token );
    }
  });

  $(".vote").off('click').click(function(e){
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
        const $response = $(response)
        const commentIdSelector = "#comment_" + comment_id
        $(commentIdSelector).html($response.find(commentIdSelector).html())
        main();
      }

    })


  })
}

$(document).on('turbolinks:load', main)
