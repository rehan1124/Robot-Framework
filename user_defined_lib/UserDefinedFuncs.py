from robot.api.deco import library, keyword


@library
class UserDefinedFuncs:

    def __init__(self):
        pass

    @keyword
    def hello_world(self):
        print("Hello Robot!")
