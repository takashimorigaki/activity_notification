require 'rails/generators/base'

module ActivityNotification
  module Generators
    class ControllersGenerator < Rails::Generators::Base
      CONTROLLERS = %w(notifications notifications_with_devise).freeze

      desc <<-DESC.strip_heredoc
        Create inherited ActivityNotification controllers in your app/controllers folder.

        Use -c to specify which controller you want to overwrite.
        If you do no specify a controller, all controllers will be created.
        For example:

          rails generate activity_notification:controllers users -c=notifications

        This will create a controller class at app/controllers/users/notifications_controller.rb like this:

          class Users::NotificationsController < ActivityNotification::NotificationsController
            content...
          end
      DESC

      source_root File.expand_path("../../templates/controllers", __FILE__)
      argument :target, required: true,
        desc: "The target to create controllers in, e.g. users, admins"
      class_option :controllers, aliases: "-c", type: :array,
        desc: "Select specific controllers to generate (#{CONTROLLERS.join(', ')})"

      def create_controllers
        @target_prefix = target.blank? ? '' : (target.camelize + '::')
        controllers = options[:controllers] || CONTROLLERS
        controllers.each do |name|
          template "#{name}_controller.rb",
                   "app/controllers/#{target}/#{name}_controller.rb"
        end
      end

      def show_readme
        readme "README" if behavior == :invoke
      end
    end
  end
end
