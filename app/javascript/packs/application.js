// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
// Turbolinks.start()
ActiveStorage.start()
require("@popperjs/core")
import $ from 'jquery';
global.$ = jQuery;

import "/vendor/assets/javascripts/admin/custom.js"
import "/vendor/assets/javascripts/admin/slick.min.js"
import "/vendor/assets/javascripts/admin/main.js"

import "./cart_product"
import "./order"
import "./admin/main"
import "./home"

import "bootstrap"
import 'bootstrap-icons/font/bootstrap-icons.css'
import "@fortawesome/fontawesome-free/css/all"

import { Tooltip, Popover } from "bootstrap"

// Import the specific modules you may need (Modal, Alert, etc)

require("../stylesheets/application.scss");
