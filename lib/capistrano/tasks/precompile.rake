namespace :deploy do
  desc 'Precompile assets'
  task :precompile_assets do
    on roles(:app) do
      within release_path do
        execute :yarn, 'install' # Install Yarn packages
        execute :yarn, 'build:css' # Run the yarn build:css command
        # Add other asset precompilation commands if needed
      end
    end
  end
end
