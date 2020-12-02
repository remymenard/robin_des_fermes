class ApplicationMailer < ActionMailer::Base
  default from: 'remy@gra.app' # TODO change this email to the RDF one's
  layout 'mailer'
end
