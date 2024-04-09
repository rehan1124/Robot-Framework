from robot.api.deco import library, keyword
from robot.libraries.BuiltIn import BuiltIn


@library
class UserDefinedFuncs:

    def __init__(self):
        self.sel_lib = BuiltIn().get_library_instance("SeleniumLibrary")
        self.ss = BuiltIn().get_library_instance("Screenshot")

    @keyword
    def add_multiple_items_to_cart(self, items_list):
        for items in items_list:
            item_xpath = f"//a[text()='{items}']//ancestor::app-card//button[contains(text(), 'Add')]"
            self.sel_lib.scroll_element_into_view(item_xpath)
            self.sel_lib.click_button(item_xpath)
        self.ss.take_screenshot()
