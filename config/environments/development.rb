require "active_support/core_ext/integer/time"

Rails.application.configure do
  #config.hosts << "cd43-92-46-60-26.ngrok-free.app"

  config.action_mailer.default_url_options = { host:'localhost', port: 3000 }

  ## MAILGUN
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    :authentication => :plain,
    :address => "smtp.mailgun.org",
    :port => 587,
    :domain => "sandboxe2fe6ff4e19d4b38b881d4b12599f814.mailgun.org",
    :user_name => "postmaster@sandboxe2fe6ff4e19d4b38b881d4b12599f814.mailgun.org",
    :password => ENV.fetch('MAILGUN_PASSW')
  }

  ## MAILTRUP
  # config.action_mailer.delivery_method = :smtp
  # config.action_mailer.smtp_settings = {
  #   :user_name => '51f2f8301c1e36',
  #   :password => 'c5215848201eed',
  #   :address => 'sandbox.smtp.mailtrap.io',
  #   :host => 'sandbox.smtp.mailtrap.io',
  #   :port => '2525',
  #   :authentication => :cram_md5
  # }

  ## MAILTRUP
  # config.action_mailer.delivery_method = :smtp
  # config.action_mailer.smtp_settings = {
  #   :address   => 'send.smtp.mailtrap.io',
  #   :port      => 587,
  #   :domain    => 'mailtrap.io',
  #   :user_name => ENV.fetch('MAILTRAP_API_KEY'),
  #   :password  => ENV.fetch('MAILTRAP_PASSW'),
  #   :authentication => 'plain',
  #   :enable_starttls_auto => true
  # }

  ## GMAIL
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address:              'smtp.doodle.kz',
    port:                 25,
    domain:               'doodle.kz',
    user_name:            'info@doodle.kz',
    password:             'A-z@12#12@',
    authentication:       'plain',
    enable_starttls_auto: true,
    open_timeout:         5,
    read_timeout:         5 }

  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded any time
  # it changes. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable server timing
  config.server_timing = true

  # Enable/disable caching. By default caching is disabled.
  # Run rails dev:cache to toggle caching.
  if Rails.root.join("tmp/caching-dev.txt").exist?
    config.action_controller.perform_caching = true
    config.action_controller.enable_fragment_cache_logging = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      "Cache-Control" => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # Store uploaded files on the local file system (see config/storage.yml for options).
  config.active_storage.service = :local

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  config.action_mailer.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise exceptions for disallowed deprecations.
  config.active_support.disallowed_deprecation = :raise

  # Tell Active Support which deprecation messages to disallow.
  config.active_support.disallowed_deprecation_warnings = []

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Highlight code that triggered database queries in logs.
  config.active_record.verbose_query_logs = true

  # Suppress logger output for asset requests.
  config.assets.quiet = true

  # Raises error for missing translations.
  # config.i18n.raise_on_missing_translations = true

  # Annotate rendered view with file names.
  # config.action_view.annotate_rendered_view_with_filenames = true

  # Uncomment if you wish to allow Action Cable access from any origin.
  # config.action_cable.disable_request_forgery_protection = true
end
