import unittest
import app


class TestSimpleFlaskApp(unittest.TestCase):
    """Unit tests to demonstrate tests running in a pipeline"""

    def test_bye_endpoint(self):
        message = "Goodbye from Flask!"
        response = app.bye_page()
        self.assertEqual(response, message)


if __name__ == '__main__':
    unittest.main()
