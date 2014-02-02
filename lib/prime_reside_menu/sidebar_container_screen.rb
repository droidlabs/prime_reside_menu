module PrimeResideMenu
  class SidebarContainerScreen < RESideMenu
    include ::MotionPrime::ScreenBaseMixin

    def self.new(menu, content, options = {})
      screen = self.alloc.initWithContentViewController(nil, menuViewController: nil)
      screen.parallaxEnabled = false
      if !Prime::Config.sidebar_container.background_image.nil?
        screen.backgroundImage = Prime::Config.sidebar_container.background_image
      end

      full_width = UIScreen.mainScreen.bounds.size.width

      if scale = options[:content_scale_value]
        screen.contentViewScaleValue = scale
      end
      x_offset = options[:x_offset] || 45
      screen.contentViewInPortraitOffsetCenterX = full_width*(1 + screen.contentViewScaleValue/2) - x_offset

      if y_offset = options[:y_offset]
        screen.contentViewInPortraitOffsetCenterY = UIScreen.mainScreen.bounds.size.height/2 + y_offset
      end

      screen.on_create(options.merge(navigation: false)) if screen.respond_to?(:on_create)
      screen.menu_controller = menu unless menu.nil?
      screen.content_controller = content unless content.nil?

      screen
    end

    def show_sidebar
      self.presentMenuViewController
    end

    def hide_sidebar
      self.hideMenuViewController
    end

    def toggle_sidebar
      self.presentMenuViewController
    end

    def menu_controller=(c)
      @menu_controller_ref = prepare_controller(c)
      self.setMenuViewController(@menu_controller_ref)
    end

    def content_controller=(c)
      @content_controller_ref = prepare_controller(c)
      if should_reinit_content?(@content_controller_ref)
        self.setContentViewController(@content_controller_ref)
      else
        content_controller.viewControllers = [@content_controller_ref]
      end
      hide_sidebar
    end

    def menu_controller
      self.menuViewController
    end

    def content_controller
      self.contentViewController
    end

    private

      def should_reinit_content?(new_controller)
        content_controller.blank? ||
        content_controller.is_a?(MotionPrime::TabBarController) ||
        new_controller.is_a?(MotionPrime::TabBarController)
      end

      def prepare_controller(controller)
        controller = setup_screen_for_open(controller, {})
        if should_reinit_content?(controller)
          controller.wrap_in_navigation if controller.respond_to?(:wrap_in_navigation)
          controller.send(:on_screen_load) if controller.respond_to?(:on_screen_load)
          controller = controller.main_controller if controller.respond_to?(:main_controller)
        else
          controller.navigation_controller = content_controller if controller.respond_to?(:navigation_controller)
          controller.send(:on_screen_load) if controller.respond_to?(:on_screen_load)
        end
        controller.strong_ref
      end
  end
end