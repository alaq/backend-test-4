require "application_system_test_case"

class CallsTest < ApplicationSystemTestCase
   # Basic test to make sure index is rendered
   test "visiting the index" do
     visit calls_url
  
     assert_selector "h1", text: "Call"
   end
end
