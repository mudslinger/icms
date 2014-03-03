Icms::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb
  #ここで設定された内容はconfig/application.rbより優先します。

  # In the development environment your application's code is reloaded on
  # every request.  This slows down response time but is perfect for development
  # since you don't have to restart the webserver when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  #nilに対してメソッドを呼んだときログメッセージを出す
  # config.whiny_nils = true
  config.eager_load = false
  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  #↓Rails3.1でエラーになる
  #config.action_view.debug_rjs             = true
  #キャッシュ
  #config.action_controller.perform_caching = true #キャッシュする
  config.action_controller.perform_caching = false #キャッシュしない

  #メール送信エラーを無視
  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false

  #非推奨のログ
  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin
end

