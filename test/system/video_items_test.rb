require "application_system_test_case"

class VideoItemsTest < ApplicationSystemTestCase
  setup do
    @video_item = video_items(:one)
  end

  test "visiting the index" do
    visit video_items_url
    assert_selector "h1", text: "Video Items"
  end

  test "creating a Video item" do
    visit video_items_url
    click_on "New Video Item"

    fill_in "Extra", with: @video_item.extra
    fill_in "Site", with: @video_item.site
    fill_in "Streams", with: @video_item.streams
    fill_in "Title", with: @video_item.title
    fill_in "Url", with: @video_item.url
    click_on "Create Video item"

    assert_text "Video item was successfully created"
    click_on "Back"
  end

  test "updating a Video item" do
    visit video_items_url
    click_on "Edit", match: :first

    fill_in "Extra", with: @video_item.extra
    fill_in "Site", with: @video_item.site
    fill_in "Streams", with: @video_item.streams
    fill_in "Title", with: @video_item.title
    fill_in "Url", with: @video_item.url
    click_on "Update Video item"

    assert_text "Video item was successfully updated"
    click_on "Back"
  end

  test "destroying a Video item" do
    visit video_items_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Video item was successfully destroyed"
  end
end
