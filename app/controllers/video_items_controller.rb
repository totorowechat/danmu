# frozen_string_literal: true

class VideoItemsController < ApplicationController
  before_action :set_video_item, only: %i[show edit update destroy]

  # GET /video_items or /video_items.json
  def index
    page = (params['page'] || 0).to_i
    page_size = (params['page_size'] || 10).to_i
    page = 0 if page.negative?
    page_size = 100 if page_size > 100
    @video_items = VideoItem.order(updated_at: :desc).offset(page * page_size).limit(page_size)
    @params = params
    @is_first = !page.zero?
    @is_end = !VideoItem.all.offset((page + 1) * page_size).limit(page_size).size.zero?
  end

  # GET /video_items/1 or /video_items/1.json
  def show; end

  # GET /video_items/new
  def new
    @video_item = VideoItem.new
    render layout: false
  end

  # GET /video_items/1/edit
  def edit
    render layout: false
  end

  # POST /video_items or /video_items.json
  def create
    @video_item = VideoItem.new(video_item_params)

    respond_to do |format|
      if @video_item.save
        format.html { redirect_to @video_item, notice: 'Video item was successfully created.' }
        format.json { render :show, status: :created, location: @video_item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @video_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /video_items/1 or /video_items/1.json
  def update
    respond_to do |format|
      if @video_item.update(video_item_params)
        format.html { redirect_to @video_item, notice: 'Video item was successfully updated.' }
        format.json { render :show, status: :ok, location: @video_item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @video_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /video_items/1 or /video_items/1.json
  def destroy
    @video_item.destroy
    respond_to do |format|
      format.html { redirect_to video_items_url, notice: 'Video item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_video_item
    @video_item = VideoItem.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def video_item_params
    params.require(:video_item).permit(:title, :url, :site, :streams, :extra)
  end
end
