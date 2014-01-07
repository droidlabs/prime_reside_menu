module PrimeResideMenu
  module Screen
    def show_sidebar
      app_delegate.show_sidebar
    end

    def hide_sidebar
      app_delegate.hide_sidebar
    end
  end
end

MotionPrime::Screen.send :include, PrimeResideMenu::Screen