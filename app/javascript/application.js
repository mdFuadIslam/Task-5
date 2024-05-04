// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

// app/javascript/packs/application.js

import 'jquery';
import Rails from '@rails/ujs';
import 'channels';
import 'bootstrap';

Rails.start();

//= require jquery3
//= require popper
//= require bootstrap