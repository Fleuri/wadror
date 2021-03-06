class BeerClubsController < ApplicationController
  # GET /beer_clubs
  # GET /beer_clubs.json

  before_filter :ensure_that_signed_in, :except => [:index, :show]

  def index
    @beer_clubs = BeerClub.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @beer_clubs }
    end
  end

  # GET /beer_clubs/1
  # GET /beer_clubs/1.json
  def join
      @beer_club = BeerClub.find(params[:id])
      if Membership.where(:beer_club_id => @beer_club.id, :user_id => current_user.id).exists?
        respond_to do |format|
                format.html { redirect_to :back, notice: "You are already a member of this club!" }
          end
      else
      @membership = Membership.create
      @membership.beer_club_id = @beer_club.id
      @membership.user_id = current_user.id
      if @beer_club.memberships.count < 1
      @membership.confirmed = true
      else
        @membership.confirmed = false
        end
      respond_to do |format|
    if @membership.save
      format.html { redirect_to :back, notice: "You joined #{@beer_club.name}" }
    else
      format.html { redirect_to :back, notice: "Something went awry! D:" }
    end
        end
  end
  end

  def confirm_membership
    user = User.find(params[:id])
    membership = Membership.where(:user_id => params[:id], :beer_club_id => self)
    membership.confirmed = true
    membership.save
    redirect_to :back
  end

  def show

    @beer_club = BeerClub.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @beer_club }
    end
  end

  # GET /beer_clubs/new
  # GET /beer_clubs/new.json
  def new
    @beer_club = BeerClub.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @beer_club }
    end
  end

  # GET /beer_clubs/1/edit
  def edit
    @beer_club = BeerClub.find(params[:id])
  end

  # POST /beer_clubs
  # POST /beer_clubs.json
  def create
    @beer_club = BeerClub.new(params[:beer_club])

    respond_to do |format|
      if @beer_club.save
        format.html { redirect_to join_path(@beer_club), notice: 'Beer club was successfully created.' }

      else
        format.html { render action: "new" }
        format.json { render json: @beer_club.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /beer_clubs/1
  # PUT /beer_clubs/1.json
  def update
    @beer_club = BeerClub.find(params[:id])

    respond_to do |format|
      if @beer_club.update_attributes(params[:beer_club])
        format.html { redirect_to @beer_club, notice: 'Beer club was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @beer_club.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /beer_clubs/1
  # DELETE /beer_clubs/1.json
  def destroy
    @beer_club = BeerClub.find(params[:id])
    @beer_club.destroy

    respond_to do |format|
      format.html { redirect_to beer_clubs_url }
      format.json { head :no_content }
    end
  end
end
