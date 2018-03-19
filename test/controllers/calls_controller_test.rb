require 'test_helper'

class CallsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @call = calls(:one)
  end

  test "should get index" do
    get calls_url
    assert_response :success
  end

  test "should get new" do
    get new_call_url
    assert_response :success
  end

  test "should create call" do
    assert_difference('Call.count') do
      post calls_url, params: { call: { call_duration: @call.call_duration, caller: @call.caller, callid: @call.callid, recording_duration: @call.recording_duration, recording_url: @call.recording_url, selection: @call.selection, status: @call.status } }
    end

    assert_redirected_to call_url(Call.last)
  end

  test "should show call" do
    get call_url(@call)
    assert_response :success
  end

  test "should get edit" do
    get edit_call_url(@call)
    assert_response :success
  end

  test "should update call" do
    patch call_url(@call), params: { call: { call_duration: @call.call_duration, caller: @call.caller, callid: @call.callid, recording_duration: @call.recording_duration, recording_url: @call.recording_url, selection: @call.selection, status: @call.status } }
    assert_redirected_to call_url(@call)
  end

  test "should destroy call" do
    assert_difference('Call.count', -1) do
      delete call_url(@call)
    end

    assert_redirected_to calls_url
  end
end
