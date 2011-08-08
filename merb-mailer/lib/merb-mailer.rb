# encoding: UTF-8

require "merb-core"

require "merb-mailer/mailer"
require "merb-mailer/mail_controller"
require "merb-mailer/mailer_mixin"

Merb::Controller.send(:include, Merb::MailerMixin)
