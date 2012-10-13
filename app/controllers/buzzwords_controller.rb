
class BuzzwordsController < ApplicationController
  # GET /buzzwords
  # GET /buzzwords.json
  def index
    @buzzwords = Buzzword.paginate(page: params[:page], per_page:10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @buzzwords }
    end
  end

  # GET /buzzwords/1
  # GET /buzzwords/1.json
  def show
    @buzzword = Buzzword.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @buzzword }
    end
  end

  # GET /buzzwords/new
  # GET /buzzwords/new.json
  def new
    @buzzword = Buzzword.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @buzzword }
    end
  end

  # GET /buzzwords/1/edit
  def edit
    @buzzword = Buzzword.find(params[:id])
  end

  # POST /buzzwords
  # POST /buzzwords.json
  def create
    @buzzword = Buzzword.new(params[:buzzword])

    respond_to do |format|
      if @buzzword.save
        format.html { redirect_to @buzzword, notice: 'Buzzword was successfully created.' }
        format.json { render json: @buzzword, status: :created, location: @buzzword }
      else
        format.html { render action: "new" }
        format.json { render json: @buzzword.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /buzzwords/1
  # PUT /buzzwords/1.json
  def update
    @buzzword = Buzzword.find(params[:id])

    respond_to do |format|
      if @buzzword.update_attributes(params[:buzzword])
        format.html { redirect_to @buzzword, notice: 'Buzzword was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @buzzword.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /buzzwords/1
  # DELETE /buzzwords/1.json
  def destroy
    @buzzword = Buzzword.find(params[:id])
    @buzzword.destroy

    respond_to do |format|
      format.html { redirect_to buzzwords_url }
      format.json { head :no_content }
    end
  end
end
