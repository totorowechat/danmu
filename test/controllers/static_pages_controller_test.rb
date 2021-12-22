# frozen_string_literal: true

require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test 'should get about' do
    get about_path
    assert_response :success
    assert_select 'title', 'About | Danmaku'
  end

  test 'should get document' do
    get document_path
    assert_response :success
    assert_select 'title', 'Document | Danmaku'
  end

  test 'should get examples' do
    get examples_path
    assert_response :success
    assert_select 'title', 'Examples | Danmaku'
  end
end
