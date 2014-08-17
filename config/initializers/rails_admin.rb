RailsAdmin.config do |config|
  # auth handling is done by route constraint
  config.authenticate_with do
    authenticate_or_request_with_http_basic('Admin') do |user, pass|
      secrets = Rails.application.secrets
      (user == secrets.admin_user) && (pass == secrets.admin_pass)
    end
  end

  config.navigation_static_links = {
    'Sidekiq' => '/sidekiq'
  }

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
