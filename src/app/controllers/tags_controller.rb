# Project name: ACCR Mail Manager
# Description: Mail database and management system for ACCR community partner
# Filename: tags_controller.rb
# Description: The main Ruby file for logic relevant to tags (add, delete, etc.)
# Last modified on: 3/30/22
# Code written by Team 13

class TagsController < ApplicationController
  before_action :set_tag, only: %i[ show edit update destroy ]

  # GET /tags or /tags.json
  def index
    @tags = Tag.all
    @joins = Tag.all
  end

  # GET /tags/1 or /tags/1.json
  def show
    redirect_to '/tags'
  end

  # GET /tags/new
  def new
    @tag = Tag.new
  end

  # POST /tags or /tags.json
  def create
    @tag = Tag.new(tag_params)

    respond_to do |format|
      if @tag.save
        format.html { redirect_to tag_url(@tag), notice: "Tag was successfully created." }
        format.json { render :show, status: :created, location: @tag }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tags/1 or /tags/1.json
  def update
    respond_to do |format|
      if @tag.update(tag_params)
        format.html { redirect_to tag_url(@tag), notice: "Tag was successfully updated." }
        format.json { render :show, status: :ok, location: @tag }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tags/1 or /tags/1.json
  def destroy
    @tag.destroy

    respond_to do |format|
      format.html { redirect_to tags_url, notice: "Tag was successfully deleted." }
      format.json { head :no_content }
    end
  end

  # Delete the selected tags.
  def delete_selected
    @to_delete = params[:delete]
    
    # Only attempt if there is at least one tag.
    if @to_delete
      
      # Need to delete the tag entries themselves.
      @to_delete.each { |tag|
        tag = Tag.where("id = " + tag.to_s)

        # Ensures that the tag still exists to be deleted (if two people are
        # using the app and one fails to refresh after a tag is deleted).
        if tag[0]
          tag[0].destroy
        end
      }

      # Need to delete the join entries for each tag that is deleted.
      @to_delete.each { |tag|
        joins = Join.where("tag_id = " + tag.to_s)

        # If some joins exist, delete them all.
        if joins
          joins.each { |join|
            join.destroy
          }
        end
      }

      # Print the alerts to the screen for success.
      respond_to do |format|
        format.html { redirect_to '/tags', notice: "Tags were successfully deleted If any mail entry used this tag, it no longer does." }
        format.json { render :show, status: :created, location: @tag }
      end

    else

      # Print the alerts to the screen for failure.
      respond_to do |format|
        format.html { redirect_to '/tags', alert: "No tags selected. Please select at least one tag." }
        format.json { render :show, status: :created, location: @tag }
      end

    end


  end

  # Create the entered tags.
  def create_entered 
    
    # Store the string of comma-separated tag names.
    to_add_string = params[:tags_string]

    # Split the string up using commas as delimiters.
    to_add_array = to_add_string.split(',') 

    # Try saving each tag to the database.
    tag_error = false
    to_add_array.each { |tag_name|

      # Strip the spaces from the front and end of the tag.
      tag_name.strip!

      # Only add non-empty, non-duplicate tags.
      if !(tag_name.blank? || Tag.pluck(:name).map(&:upcase).include?(tag_name.upcase))
        
        new_tag = Tag.new
        new_tag.name = tag_name

        # Keep track of tags that don't save properly.
        if !new_tag.save
          tag_error = true
        end

      # Be sure to raise error on at least one tag.
      else
        tag_error = true
      end

    }
  
    # Print the alerts to the screen for success.
    if !tag_error
      
      respond_to do |format|
        format.html { redirect_to '/tags', notice: "Tags were successfully added. They can now be attached to mail entries!" }
        format.json { render :show, status: :created, location: @tag }
      end

    else
      
      # Print the alerts to the screen for failure.
      respond_to do |format|
        format.html { redirect_to '/tags', alert: "There was an error adding one or more of your tags. Tags must contain at least one letter or number and duplicates are not allowed." }
        format.json { render :show, status: :created, location: @tag }
      end

    end
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tag
      @tag = Tag.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tag_params
      params.require(:tag).permit(:name)
      params.require(:join).permit(:mail_id, :tag_id)
    end
end
