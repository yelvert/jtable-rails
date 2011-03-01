module JTable
  class Railtie < Rails::Railtie
    rake_tasks do
      load "tasks/jtable_rails.rake"
    end
  end
end