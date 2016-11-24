# 为什么无法取到环境变量？  ENV['RAILS_ENV'] => nil
if ENV['RAILS_ENV'] == 'production'

  app_root = '/var/www/newpoint'
  pidfile "#{app_root}/tmp/puma.pid"
  state_path "#{app_root}/tmp/puma.state"
  bind "unix://#{app_root}/tmp/puma.sock"
  stdout_redirect "#{app_root}/current/log/puma.log"
#  activate_control_app "unix://#{app_root}/tmp/pumactl.sock"
  daemonize true
  threads 1, 4
#  preload_app!
#
#  on_worker_boot do
#    ActiveSupport.on_load(:active_record) do
#      ActiveRecord::Base.establish_connection
#    end
end
#
#  before_fork do
#    ActiveRecord::Base.connection_pool.disconnect!
#  end
#
#else
#  plugin :tmp_restart
#end
